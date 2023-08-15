package com.chartiq.chartiq_flutter_sdk

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.view.View
import com.chartiq.chartiq_flutter_sdk.models.ChartAvailableModel
import com.chartiq.chartiq_flutter_sdk.models.DataPullModel
import com.chartiq.chartiq_flutter_sdk.models.MeasureModel
import com.chartiq.chartiq_flutter_sdk.models.MessageType
import com.chartiq.chartiq_flutter_sdk.models.StudyParameterWrapper
import com.chartiq.sdk.ChartIQ
import com.chartiq.sdk.DataSource
import com.chartiq.sdk.DataSourceCallback
import com.chartiq.sdk.model.ChartLayer
import com.chartiq.sdk.model.ChartScale
import com.chartiq.sdk.model.ChartTheme
import com.chartiq.sdk.model.DataMethod
import com.chartiq.sdk.model.OHLCParams
import com.chartiq.sdk.model.QuoteFeedParams
import com.chartiq.sdk.model.Series
import com.chartiq.sdk.model.TimeUnit
import com.chartiq.sdk.model.charttype.ChartAggregationType
import com.chartiq.sdk.model.charttype.ChartType
import com.chartiq.sdk.model.drawingtool.ChartIQDrawingTool
import com.chartiq.sdk.model.drawingtool.DrawingParameterType
import com.chartiq.sdk.model.drawingtool.DrawingTool
import com.chartiq.sdk.model.drawingtool.drawingmanager.ChartIQDrawingManager
import com.chartiq.sdk.model.signal.ChartIQSignal
import com.chartiq.sdk.model.signal.Signal
import com.chartiq.sdk.model.study.ChartIQStudy
import com.chartiq.sdk.model.study.Study
import com.chartiq.sdk.model.study.StudyParameter
import com.chartiq.sdk.model.study.StudyParameterModel
import com.chartiq.sdk.model.study.StudyParameterType
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.util.LinkedList

class ChartIQWebView(
    context: Context?,
    messenger: BinaryMessenger,
    id: Int,
    activity: Activity?,
    url: String
) : PlatformView,
    MethodChannel.MethodCallHandler {
    private var methodChannel: MethodChannel? = null
    private var eventSink: EventChannel.EventSink? = null
    private var activity: Activity? = null
    private val gson = Gson()
    private val chartIQ: ChartIQ
    private val chartIQDrawingManager: ChartIQDrawingManager
    private val chartIQDrawingTool: ChartIQDrawingTool
    private val chartIQStudy: ChartIQStudy
    private val chartIQSignal: ChartIQSignal
    private var pullInitialDataLastCallBack: ArrayDeque<DataSourceCallback> = ArrayDeque()
    private var pullUpdateDataLastCallBack: ArrayDeque<DataSourceCallback> = ArrayDeque()
    private var pullPaginationDataLastCallBack: ArrayDeque<DataSourceCallback> = ArrayDeque()

    init {
        methodChannel =
            MethodChannel(messenger, "plugins.com.chartiq.chart_flutter_sdk/chartiqwebview_$id")
        methodChannel?.setMethodCallHandler(this)
        EventChannel(messenger, "plugins.com.chartiq.chart_flutter_sdk/chartiqwebview_events_$id")
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {}
            })
        this.activity = activity
        chartIQ = ChartIQ.getInstance(url, context!!)
        chartIQDrawingManager = ChartIQDrawingManager()
        chartIQDrawingTool = chartIQ
        chartIQStudy = chartIQ
        chartIQSignal = chartIQ
        initDataSource()
        initListeners()
    }

    override fun getView(): View? {
        return chartIQ.chartView
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "start" -> start(methodCall, result)
            "pullInitialData" -> pullInitialData(methodCall, result)
            "pullUpdateData" -> pullUpdateData(methodCall, result)
            "pullPaginationData" -> pullPaginationData(methodCall, result)
            "getSymbol" -> getSymbol(methodCall, result)
            "getInterval" -> getInterval(methodCall, result)
            "getTimeUnit" -> getTimeUnit(methodCall, result)
            "getPeriodicity" -> getPeriodicity(methodCall, result)
            "setSymbol" -> setSymbol(methodCall, result)
            "setDataMethod" -> setDataMethod(methodCall, result)
            "enableCrosshairs" -> enableCrosshairs(methodCall, result)
            "disableCrosshairs" -> disableCrosshairs(methodCall, result)
            "isCrosshairsEnabled" -> isCrosshairsEnabled(methodCall, result)
            "setPeriodicity" -> setPeriodicity(methodCall, result)
            "setAggregationType" -> setAggregationType(methodCall, result)
            "setChartStyle" -> setChartStyle(methodCall, result)
            "setChartType" -> setChartType(methodCall, result)
            "setRefreshInterval" -> setRefreshInterval(methodCall, result)
            "getChartType" -> getChartType(methodCall, result)
            "getChartAggregationType" -> getChartAggregationType(methodCall, result)
            "getChartScale" -> getChartScale(methodCall, result)
            "setChartScale" -> setChartScale(methodCall, result)
            "getEngineProperty" -> getEngineProperty(methodCall, result)
            "setEngineProperty" -> setEngineProperty(methodCall, result)
            "getChartProperty" -> getChartProperty(methodCall, result)
            "setChartProperty" -> setChartProperty(methodCall, result)
            "getIsInvertYAxis" -> getIsInvertYAxis(methodCall, result)
            "setIsInvertYAxis" -> setIsInvertYAxis(methodCall, result)
            "getIsExtendedHours" -> getIsExtendedHours(methodCall, result)
            "setExtendedHours" -> setExtendedHours(methodCall, result)
            "getHUDDetails" -> getHUDDetails(methodCall, result)
            "getTranslations" -> getTranslations(methodCall, result)
            "setLanguage" -> setLanguage(methodCall, result)
            "setTheme" -> setTheme(methodCall, result)
            "getActiveSeries" -> getActiveSeries(methodCall, result)
            "addSeries" -> addSeries(methodCall, result)
            "removeSeries" -> removeSeries(methodCall, result)
            "setSeriesParameter" -> setSeriesParameter(methodCall, result)
            "push" -> push(methodCall, result)
            "pushUpdate" -> pushUpdate(methodCall, result)
            // ChartIQDrawingManager methods
            "isSupportingAxisLabel" -> isSupportingAxisLabel(methodCall, result)
            "isSupportingDeviations" -> isSupportingDeviations(methodCall, result)
            "isSupportingElliottWave" -> isSupportingElliottWave(methodCall, result)
            "isSupportingFibonacci" -> isSupportingFibonacci(methodCall, result)
            "isSupportingFillColor" -> isSupportingFillColor(methodCall, result)
            "isSupportingFont" -> isSupportingFont(methodCall, result)
            "isSupportingLineColor" -> isSupportingLineColor(methodCall, result)
            "isSupportingLineType" -> isSupportingLineType(methodCall, result)
            "isSupportingSettings" -> isSupportingSettings(methodCall, result)
            "isSupportingVolumeProfile" -> isSupportingVolumeProfile(methodCall, result)
            // ChartIQDrawingTool methods
            "clearDrawing" -> clearDrawing(methodCall, result)
            "cloneDrawing" -> cloneDrawing(methodCall, result)
            "deleteDrawing" -> deleteDrawing(methodCall, result)
            "disableDrawing" -> disableDrawing(methodCall, result)
            "enableDrawing" -> enableDrawing(methodCall, result)
            "getDrawingParameters" -> getDrawingParameters(methodCall, result)
            "redoDrawing" -> redoDrawing(methodCall, result)
            "restoreDefaultDrawingConfig" -> restoreDefaultDrawingConfig(methodCall, result)
            "setDrawingParameter" -> setDrawingParameter(methodCall, result)
            "setDrawingParameterByName" -> setDrawingParameterByName(methodCall, result)
            "undoDrawing" -> undoDrawing(methodCall, result)
            "manageLayer" -> manageLayer(methodCall, result)
            // Study methods
            "getStudyList" -> getStudyList(methodCall, result)
            "getActiveStudies" -> getActiveStudies(methodCall, result)
            "removeStudy" -> removeStudy(methodCall, result)
            "addStudy" -> addStudy(methodCall, result)
            "setStudyParameter" -> setStudyParameter(methodCall, result)
            "setStudyParameters" -> setStudyParameters(methodCall, result)
            "getStudyParameters" -> getStudyParameters(methodCall, result)
            // Signal methods
            "toggleSignal" -> toggleSignal(methodCall, result)
            "getActiveSignals" -> getActiveSignals(methodCall, result)
            "removeSignal" -> removeSignal(methodCall, result)
            "addSignalStudy" -> addSignalStudy(methodCall, result)
            "saveSignal" -> saveSignal(methodCall, result)
        }
    }

    private fun start(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.start {
                result.success(null)
            }
        }
    }

    private fun pullInitialData(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val params = gson.fromJson<List<OHLCParams>>(
            arguments,
            object : TypeToken<List<OHLCParams>>() {}.type
        )
        Handler(Looper.getMainLooper()).post {
            pullInitialDataLastCallBack.removeLast().execute(params)
        }
        result.success(null)
    }

    private fun pullUpdateData(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val params = gson.fromJson<List<OHLCParams>>(
            arguments,
            object : TypeToken<List<OHLCParams>>() {}.type
        )
        Handler(Looper.getMainLooper()).post {
            pullUpdateDataLastCallBack.removeLast().execute(params)
        }
        result.success(null)
    }

    private fun pullPaginationData(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val params = gson.fromJson<List<OHLCParams>>(
            arguments,
            object : TypeToken<List<OHLCParams>>() {}.type
        )
        Handler(Looper.getMainLooper()).post {
            pullPaginationDataLastCallBack.removeLast().execute(params)
        }
        result.success(null)
    }

    private fun getSymbol(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getSymbol {
                result.success(it)
            }
        }
    }

    private fun getInterval(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getInterval {
                result.success(it)
            }
        }
    }

    private fun getTimeUnit(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getTimeUnit {
                result.success(it)
            }
        }
    }

    private fun getPeriodicity(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getPeriodicity {
                result.success(it)
            }
        }
    }

    private fun setSymbol(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.setSymbol(arguments)
            result.success(null)
        }
    }

    private fun setDataMethod(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<String>
        val dataMethod = DataMethod.values().first { it.name == arguments[0] }
        val symbol = arguments[1]
        Handler(Looper.getMainLooper()).post {
            chartIQ.setDataMethod(dataMethod, symbol)
            result.success(null)
        }
    }

    private fun enableCrosshairs(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.enableCrosshairs()
            result.success(null)
        }
    }

    private fun disableCrosshairs(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.disableCrosshairs()
            result.success(null)
        }
    }

    private fun isCrosshairsEnabled(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.isCrosshairsEnabled {
                result.success(it)
            }
        }
    }

    private fun setPeriodicity(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val period = arguments[0] as Int
        val interval = arguments[1] as String
        val timeUnit = TimeUnit.values().first { it.name == arguments[2] as String }
        Handler(Looper.getMainLooper()).post {
            chartIQ.setPeriodicity(period, interval, timeUnit)
            result.success(null)
        }
    }

    private fun setAggregationType(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.setAggregationType(ChartAggregationType.values().first { it.value == arguments })
            result.success(null)
        }
    }

    private fun setChartStyle(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<String>
        Handler(Looper.getMainLooper()).post {
            chartIQ.setChartStyle(arguments[0], arguments[1], arguments[2])
            result.success(null)
        }
    }

    private fun setChartType(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.setChartType(ChartType.values().first { it.value == arguments })
            result.success(null)
        }
    }

    private fun setRefreshInterval(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as Int
        Handler(Looper.getMainLooper()).post {
            chartIQ.setRefreshInterval(arguments)
            result.success(null)
        }
    }

    private fun getChartType(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getChartType {
                if (it != null) {
                    result.success(it.value)
                } else {
                    result.success(null)
                }
            }
        }
    }

    private fun getChartAggregationType(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getChartAggregationType {
                if (it != null) {
                    result.success(it.value)
                } else {
                    result.success(null)
                }
            }
        }
    }

    private fun getChartScale(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getChartScale {
                result.success(it.value)
            }
        }
    }

    private fun setChartScale(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.setChartScale(ChartScale.values().first { it.value == arguments })
            result.success(null)
        }
    }

    private fun getEngineProperty(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.getEngineProperty(arguments) {
                result.success(it)
            }
        }
    }

    private fun setEngineProperty(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val property = arguments[0] as String
        val value = arguments[1]
        Handler(Looper.getMainLooper()).post {
            chartIQ.setEngineProperty(property, value)
            result.success(null)
        }
    }

    private fun getChartProperty(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.getChartProperty(arguments) {
                result.success(it)
            }
        }
    }

    private fun setChartProperty(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val property = arguments[0] as String
        val value = arguments[1]
        Handler(Looper.getMainLooper()).post {
            chartIQ.setChartProperty(property, value)
            result.success(null)
        }
    }

    private fun getIsInvertYAxis(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getIsInvertYAxis {
                result.success(it)
            }
        }
    }

    private fun setIsInvertYAxis(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQ.setIsInvertYAxis(arguments)
            result.success(null)
        }
    }

    private fun getIsExtendedHours(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getIsExtendedHours {
                result.success(it)
            }
        }
    }

    private fun setExtendedHours(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQ.setExtendedHours(arguments)
            result.success(null)
        }
    }

    private fun getHUDDetails(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getHUDDetails {
                result.success(gson.toJson(it))
            }
        }
    }

    private fun getTranslations(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.getTranslations(arguments) {
                result.success(gson.toJson(it))
            }
        }
    }

    private fun setLanguage(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.setLanguage(arguments)
            result.success(null)
        }
    }

    private fun setTheme(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.setTheme(ChartTheme.values().first { it.value == arguments })
            result.success(null)
        }
    }

    private fun getActiveSeries(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQ.getActiveSeries {
                result.success(gson.toJson(it))
            }
        }
    }

    private fun addSeries(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val series = gson.fromJson(arguments[0] as String, Series::class.java)
        val isComparison = arguments[1] as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQ.addSeries(series, isComparison)
            result.success(null)
        }
    }

    private fun removeSeries(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        Handler(Looper.getMainLooper()).post {
            chartIQ.removeSeries(arguments)
            result.success(null)
        }
    }

    private fun setSeriesParameter(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<String>
        val seriesId = arguments[0]
        val parameter = arguments[1]
        val value = arguments[2]
        Handler(Looper.getMainLooper()).post {
            chartIQ.setSeriesParameter(seriesId, parameter, value)
            result.success(null)
        }
    }

    private fun push(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val symbol = arguments[0] as String
        val data = gson.fromJson<List<OHLCParams>>(arguments[1] as String, object : TypeToken<List<OHLCParams>>() {}.type)
        Handler(Looper.getMainLooper()).post {
            chartIQ.push(symbol, data)
            result.success(null)
        }
    }

    private fun pushUpdate(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val data = gson.fromJson<List<OHLCParams>>(arguments[0] as String, object : TypeToken<List<OHLCParams>>() {}.type)
        val useAsLastSale = arguments[1] as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQ.pushUpdate(data, useAsLastSale)
            result.success(null)
        }
    }

    private fun isSupportingAxisLabel(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingAxisLabel(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingDeviations(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingDeviations(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingElliottWave(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingElliottWave(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingFibonacci(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingFibonacci(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingFillColor(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingFillColor(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingFont(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingFont(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingLineColor(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingLineColor(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingLineType(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingLineType(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingSettings(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingSettings(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun isSupportingVolumeProfile(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        result.success(
            chartIQDrawingManager.isSupportingVolumeProfile(
                DrawingTool.values().first { it.value == arguments })
        )
    }

    private fun clearDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.clearDrawing()
        }
        result.success(null)
    }

    private fun cloneDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.cloneDrawing()
        }
        result.success(null)
    }

    private fun deleteDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.deleteDrawing()
        }
        result.success(null)
    }

    private fun disableDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.disableDrawing()
        }
        result.success(null)
    }

    private fun enableDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val drawingTool = DrawingTool.values().first { it.value == arguments }
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.enableDrawing(drawingTool)
        }
        result.success(null)
    }

    private fun getDrawingParameters(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val drawingTool = DrawingTool.values().first { it.value == arguments }
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.getDrawingParameters(drawingTool) {
                val toReturn = gson.toJson(it)
                result.success(toReturn)
            }
        }
    }

    private fun manageLayer(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val tool = ChartLayer.values().first { it.value == arguments }
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.manageLayer(tool)
        }
        result.success(null)
    }

    private fun redoDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.redoDrawing {
                result.success(it)
            }
        }
    }

    private fun restoreDefaultDrawingConfig(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val drawingTool = DrawingTool.values().first { it.value == arguments[0] }
        val all = arguments[1] as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.restoreDefaultDrawingConfig(drawingTool, all)
        }
        result.success(null)
    }

    private fun setDrawingParameter(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val argument = arguments[0].toString()
        val argument1 = arguments[1].toString()
        val value = if (argument1 == "true" || argument1 == "false") {
            argument1.toBoolean()
        } else {
            argument1
        }
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.setDrawingParameter(argument, value)
        }
        result.success(null)
    }

    private fun setDrawingParameterByName(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val parameterName = arguments[0] as String
        val value = arguments[1].toString()
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.setDrawingParameter(parameterName, value)
        }
        result.success(null)
    }

    private fun undoDrawing(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQDrawingTool.undoDrawing {
                result.success(it)
            }
        }
    }

    private fun getStudyList(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.getStudyList {
                val toSend = gson.toJson(it)
                result.success(toSend)
            }
        }
    }

    private fun getActiveStudies(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.getActiveStudies() {
                val toSend = gson.toJson(it)
                result.success(toSend)
            }
        }
    }

    private fun removeStudy(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val study = gson.fromJson(arguments, Study::class.java)
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.removeStudy(study)
        }
        result.success(null)
    }

    private fun addStudy(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val study = gson.fromJson(arguments[0] as String, Study::class.java)
        val forClone = arguments[1] as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.addStudy(study, forClone)
        }
        result.success(null)
    }

    private fun setStudyParameter(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val study = gson.fromJson(arguments[0] as String, Study::class.java)
        val studyParameterModel =
            gson.fromJson(arguments[1] as String, StudyParameterModel::class.java)
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.setStudyParameter(study, studyParameterModel)
        }
        result.success(null)
    }

    private fun setStudyParameters(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val study = gson.fromJson(arguments[0] as String, Study::class.java)
        val studyParameterModels = gson.fromJson<List<StudyParameterModel>>(
            arguments[1] as String,
            object : TypeToken<List<StudyParameterModel>>() {}.type
        )
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.setStudyParameters(study, studyParameterModels) {
                val toSend = gson.toJson(it)
                result.success(toSend)
            }
        }
    }

    private fun getStudyParameters(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val study = gson.fromJson(arguments[0] as String, Study::class.java)
        val studyParameterType = StudyParameterType.values().first { it.name == arguments[1] }
        Handler(Looper.getMainLooper()).post {
            chartIQStudy.getStudyParameters(study, studyParameterType) {
                val listOfWrapper = LinkedList<StudyParameterWrapper>()
                it.forEach { study ->
                    when (study.javaClass) {
                        StudyParameter.Text::class.java -> {
                            val item = study as StudyParameter.Text
                            val wrapper = StudyParameterWrapper(
                                type = "Text",
                                value = gson.toJson(item),
                            )
                            listOfWrapper.add(wrapper)
                        }
                        StudyParameter.Checkbox::class.java -> {
                            val item = study as StudyParameter.Checkbox
                            val wrapper = StudyParameterWrapper(
                                type = "Checkbox",
                                value = gson.toJson(item),
                            )
                            listOfWrapper.add(wrapper)
                        }
                        StudyParameter.Select::class.java -> {
                            val item = study as StudyParameter.Select
                            val wrapper = StudyParameterWrapper(
                                type = "Select",
                                value = gson.toJson(item),
                            )
                            listOfWrapper.add(wrapper)
                        }
                        StudyParameter.Number::class.java -> {
                            val item = study as StudyParameter.Number
                            val wrapper = StudyParameterWrapper(
                                type = "Number",
                                value = gson.toJson(item),
                            )
                            listOfWrapper.add(wrapper)
                        }
                        StudyParameter.Color::class.java -> {
                            val item = study as StudyParameter.Color
                            val wrapper = StudyParameterWrapper(
                                type = "Color",
                                value = gson.toJson(item),
                            )
                            listOfWrapper.add(wrapper)
                        }
                        StudyParameter.TextColor::class.java -> {
                            val item = study as StudyParameter.TextColor
                            val wrapper = StudyParameterWrapper(
                                type = "TextColor",
                                value = gson.toJson(item),
                            )
                            listOfWrapper.add(wrapper)
                        }
                    }
                }
                val toSend = gson.toJson(listOfWrapper)
                result.success(toSend)
            }
        }
    }

    private fun toggleSignal(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val signal = gson.fromJson(arguments, Signal::class.java)
        Handler(Looper.getMainLooper()).post {
            chartIQSignal.toggleSignal(signal)
            result.success(null)
        }
    }

    private fun getActiveSignals(methodCall: MethodCall, result: MethodChannel.Result) {
        Handler(Looper.getMainLooper()).post {
            chartIQSignal.getActiveSignals {
                val toSend = gson.toJson(it)
                result.success(toSend)
            }
        }
    }

    private fun removeSignal(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as String
        val signal = gson.fromJson(arguments, Signal::class.java)
        Handler(Looper.getMainLooper()).post {
            chartIQSignal.removeSignal(signal)
            result.success(null)
        }
    }

    private fun addSignalStudy(methodCall: MethodCall, result: MethodChannel.Result) {
        val study = gson.fromJson(methodCall.arguments as String, Study::class.java)
        Handler(Looper.getMainLooper()).post {
            chartIQSignal.addSignalStudy(study.shortName) {
                val toSend = gson.toJson(it)
                result.success(toSend)
            }
        }
    }

    private fun saveSignal(methodCall: MethodCall, result: MethodChannel.Result) {
        val arguments = methodCall.arguments as List<Any>
        val signal = gson.fromJson(arguments[0] as String, Signal::class.java)
        val editMode = arguments[1] as Boolean
        Handler(Looper.getMainLooper()).post {
            chartIQSignal.saveSignal(signal, editMode)
            result.success(null)
        }
    }

    private fun initDataSource() {
        chartIQ.setDataSource(object : DataSource {
            override fun pullInitialData(
                params: QuoteFeedParams,
                callback: DataSourceCallback,
            ) {
                pullInitialDataLastCallBack.addFirst(callback)
                Handler(Looper.getMainLooper()).post {
                    eventSink?.success(
                        gson.toJson(
                            DataPullModel(
                                type = MessageType.pullInitialData.name,
                                params = params
                            )
                        )
                    )
                }
            }

            override fun pullUpdateData(
                params: QuoteFeedParams,
                callback: DataSourceCallback,
            ) {
                pullUpdateDataLastCallBack.addFirst(callback)
                Handler(Looper.getMainLooper()).post {
                    eventSink?.success(
                        gson.toJson(
                            DataPullModel(
                                type = MessageType.pullUpdateData.name,
                                params = params
                            )
                        )
                    )
                }
            }

            override fun pullPaginationData(
                params: QuoteFeedParams,
                callback: DataSourceCallback,
            ) {
                pullPaginationDataLastCallBack.addFirst(callback)
                Handler(Looper.getMainLooper()).post {
                    eventSink?.success(
                        gson.toJson(
                            DataPullModel(
                                type = MessageType.pullPaginationData.name,
                                params = params
                            )
                        )
                    )
                }
            }
        })
    }

    private fun initListeners() {
        chartIQ.addMeasureListener {
            Handler(Looper.getMainLooper()).post {
                eventSink?.success(
                    gson.toJson(
                        MeasureModel(
                            type = MessageType.measure.name,
                            measure = it
                        )
                    )
                )
            }
        }

        chartIQ.addChartAvailableListener {
            Handler(Looper.getMainLooper()).post {
                eventSink?.success(
                    gson.toJson(
                        ChartAvailableModel(
                            type = MessageType.chartAvailable.name,
                            available = it
                        )
                    )
                )
            }
        }
    }

    override fun dispose() {
        pullInitialDataLastCallBack.clear()
        pullUpdateDataLastCallBack.clear()
        pullPaginationDataLastCallBack.clear()
    }
}