import Flutter
import UIKit
import ChartIQ

public class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    public init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private let decoder = JSONDecoder()
    private var сhartIqWrapperView: ChartIqWrapperView
    private var chartIQView: ChartIQView? = nil
    private var methodChannel: FlutterMethodChannel
    private var eventSink: FlutterEventSink? = nil
    private var pullInitialDataLastCallBack: [(([ChartIQ.ChartIQData]) -> Void)] = []
    private var pullUpdateDataLastCallBack: [(([ChartIQ.ChartIQData]) -> Void)] = []
    private var pullPaginationDataLastCallBack: [(([ChartIQ.ChartIQData]) -> Void)] = []
    private let drawingManager = ChartIQDrawingManager()
    private var url: String? = nil
    private var readyWasSend = false

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        сhartIqWrapperView = ChartIqWrapperView()
        methodChannel = FlutterMethodChannel(name: "plugins.com.chartiq.chart_flutter_sdk/chartiqwebview_\(viewId)",
                                             binaryMessenger: messenger!)
        super.init()
        makeMethodsHandler()
        FlutterEventChannel(name: "plugins.com.chartiq.chart_flutter_sdk/chartiqwebview_events_\(viewId)", binaryMessenger: messenger!)
            .setStreamHandler(self)
        self.chartIQView = сhartIqWrapperView.chartIQView
        self.chartIQView?.dataSource = self
        self.chartIQView?.delegate = self
        if let args, let dictionary = args as? [String: String], let url = dictionary["url"] {
            self.url = url
        }
    }
    
    func view() -> UIView {
        return сhartIqWrapperView
    }

    private func makeMethodsHandler() {
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            let method = call.method
            print("makeMethodsHandler " + method)
            switch method {
            case "start":
                self.start(methodCall: call, result: result)
                break
            case "changeAvailability":
                self.changeAvailability(methodCall: call, result: result)
                break
            case "pullInitialData":
                self.pullInitialData(methodCall: call, result: result)
                break
            case "pullUpdateData":
                self.pullUpdateData(methodCall: call, result: result)
                break
            case "pullPaginationData":
                self.pullPaginationData(methodCall: call, result: result)
                break
            case "setTheme":
                self.setTheme(methodCall: call, result: result)
                break
            case "getSymbol":
                self.getSymbol(methodCall: call, result: result)
                break
            case "getPeriodicity":
                self.getPeriodicity(methodCall: call, result: result)
                break
            case "getInterval":
                self.getInterval(methodCall: call, result: result)
                break
            case "getTimeUnit":
                self.getTimeUnit(methodCall: call, result: result)
                break
            case "isCrosshairsEnabled":
                self.isCrosshairsEnabled(methodCall: call, result: result)
                break
            case "getChartType":
                self.getChartType(methodCall: call, result: result)
                break
            case "getTranslations":
                self.getTranslations(methodCall: call, result: result)
                break
            case "setLanguage":
                self.setLanguage(methodCall: call, result: result)
                break
            case "getChartAggregationType":
                self.getChartAggregationType(methodCall: call, result: result)
                break
            case "disableCrosshairs":
                self.disableCrosshairs(methodCall: call, result: result)
                break
            case "enableCrosshairs":
                self.enableCrosshairs(methodCall: call, result: result)
                break
            case "getHUDDetails":
                self.getHUDDetails(methodCall: call, result: result)
                break
            case "setSymbol":
                self.setSymbol(methodCall: call, result: result)
                break
            case "setDataMethod":
                self.setDataMethod(methodCall: call, result: result)
                break
            case "setPeriodicity":
                self.setPeriodicity(methodCall: call, result: result)
                break
            case "setAggregationType":
                self.setAggregationType(methodCall: call, result: result)
                break
            case "setChartStyle":
                self.setChartStyle(methodCall: call, result: result)
                break
            case "setChartType":
                self.setChartType(methodCall: call, result: result)
                break
            case "setRefreshInterval":
                self.setRefreshInterval(methodCall: call, result: result)
                break
            case "getChartScale":
                self.getChartScale(methodCall: call, result: result)
                break
            case "setChartScale":
                self.setChartScale(methodCall: call, result: result)
                break
            case "getEngineProperty":
                self.getEngineProperty(methodCall: call, result: result)
                break
            case "setEngineProperty":
                self.setEngineProperty(methodCall: call, result: result)
                break
            case "getChartProperty":
                self.getChartProperty(methodCall: call, result: result)
                break
            case "setChartProperty":
                self.setChartProperty(methodCall: call, result: result)
                break
            case "getIsInvertYAxis":
                self.getIsInvertYAxis(methodCall: call, result: result)
                break
            case "setIsInvertYAxis":
                self.setIsInvertYAxis(methodCall: call, result: result)
                break
            case "getIsExtendedHours":
                self.getIsExtendedHours(methodCall: call, result: result)
                break
            case "setExtendedHours":
                self.setExtendedHours(methodCall: call, result: result)
                break
            case "getActiveSeries":
                self.getActiveSeries(methodCall: call, result: result)
                break
            case "addSeries":
                self.addSeries(methodCall: call, result: result)
                break
            case "removeSeries":
                self.removeSeries(methodCall: call, result: result)
                break
            case "setSeriesParameter":
                self.setSeriesParameter(methodCall: call, result: result)
                break
            case "push":
                self.push(methodCall: call, result: result)
                break
            case "pushUpdate":
                self.pushUpdate(methodCall: call, result: result)
                break
                // DrawingManager
            case "isSupportingFillColor":
                self.isSupportingFillColor(methodCall: call, result: result)
                break
            case "isSupportingLineColor":
                self.isSupportingLineColor(methodCall: call, result: result)
                break
            case "isSupportingLineType":
                self.isSupportingLineType(methodCall: call, result: result)
                break
            case "isSupportingSettings":
                self.isSupportingSettings(methodCall: call, result: result)
                break
            case "isSupportingFont":
                self.isSupportingFont(methodCall: call, result: result)
                break
            case "isSupportingAxisLabel":
                self.isSupportingAxisLabel(methodCall: call, result: result)
                break
            case "isSupportingDeviations":
                self.isSupportingDeviations(methodCall: call, result: result)
                break
            case "isSupportingFibonacci":
                self.isSupportingFibonacci(methodCall: call, result: result)
                break
            case "isSupportingElliottWave":
                self.isSupportingElliottWave(methodCall: call, result: result)
                break
            case "isSupportingVolumeProfile":
                self.isSupportingVolumeProfile(methodCall: call, result: result)
                break
            case "isSupportingShowCallOut":
                self.isSupportingShowCallOut(methodCall: call, result: result)
                break
                // DrawingTool
            case "disableDrawing":
                self.disableDrawing(methodCall: call, result: result)
                break
            case "clearDrawing":
                self.clearDrawing(methodCall: call, result: result)
                break
            case "enableDrawing":
                self.enableDrawing(methodCall: call, result: result)
                break
            case "setDrawingParameterByName":
                self.setDrawingParameterByName(methodCall: call, result: result)
                break
            case "setDrawingParameter":
                self.setDrawingParameter(methodCall: call, result: result)
                break
            case "getDrawingParameters":
                self.getDrawingParameters(methodCall: call, result: result)
                break
            case "deleteDrawing":
                self.deleteDrawing(methodCall: call, result: result)
                break
            case "cloneDrawing":
                self.cloneDrawing(methodCall: call, result: result)
                break
            case "manageLayer":
                self.manageLayer(methodCall: call, result: result)
                break
            case "undoDrawing":
                self.undoDrawing(methodCall: call, result: result)
                break
            case "redoDrawing":
                self.redoDrawing(methodCall: call, result: result)
                break
            case "restoreDefaultDrawingConfig":
                self.restoreDefaultDrawingConfig(methodCall: call, result: result)
                break
                // Study
            case "getStudyList":
                self.getStudyList(methodCall: call, result: result)
                break
            case "getActiveStudies":
                self.getActiveStudies(methodCall: call, result: result)
                break
            case "removeStudy":
                self.removeStudy(methodCall: call, result: result)
                break
            case "addStudy":
                self.addStudy(methodCall: call, result: result)
                break
            case "setStudyParameter":
                self.setStudyParameter(methodCall: call, result: result)
                break
            case "getStudyParameters":
                self.getStudyParameters(methodCall: call, result: result)
                break
            case "setStudyParameters":
                self.setStudyParameters(methodCall: call, result: result)
                break
                // Signal
            case "addSignalStudy":
                self.addSignalStudy(methodCall: call, result: result)
                break
            case "saveSignal":
                self.saveSignal(methodCall: call, result: result)
                break
            case "getActiveSignals":
                self.getActiveSignals(methodCall: call, result: result)
                break
            case "toggleSignal":
                self.toggleSignal(methodCall: call, result: result)
                break
            case "removeSignal":
                self.removeSignal(methodCall: call, result: result)
                break
            default:
                result(nil)
            }
        })
    }
    
    private func start(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        result(nil)
    }

    private func changeAvailability(methodCall: FlutterMethodCall, result: FlutterResult) {
        let availability = methodCall.arguments as! Bool
        chartIQView?.isUserInteractionEnabled = availability
        result(nil)
    }

    private func pullInitialData(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let jsonData = arguments.data(using: .utf8)!
        var items: [ChartIQ.ChartIQData] = []
        let jsonArray = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        if let jsonArray {
            for item in jsonArray {
                items.append(ChartIQ.ChartIQData(dictionary: item))
            }
        }
        pullInitialDataLastCallBack[0](items)
        pullInitialDataLastCallBack.removeFirst()
        result(nil)
    }

    private func pullUpdateData(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let jsonData = arguments.data(using: .utf8)!
        var items: [ChartIQ.ChartIQData] = []
        let jsonArray = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        if let jsonArray {
            for item in jsonArray {
                items.append(ChartIQ.ChartIQData(dictionary: item))
            }
        }
        pullUpdateDataLastCallBack[0](items)
        pullUpdateDataLastCallBack.removeFirst()
        result(nil)
    }

    private func pullPaginationData(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let jsonData = arguments.data(using: .utf8)!
        var items: [ChartIQ.ChartIQData] = []
        let jsonArray = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        if let jsonArray {
            for item in jsonArray {
                items.append(ChartIQ.ChartIQData(dictionary: item))
            }
        }
        pullPaginationDataLastCallBack[0](items)
        pullPaginationDataLastCallBack.removeFirst()
        result(nil)
    }

    private func getSymbol(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.symbol ?? "")
    }

    private func getPeriodicity(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.periodicity ?? 0)
    }

    private func getInterval(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.interval ?? "tick")
    }

    private func getTimeUnit(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.timeUnit?.stringValue ?? "null")
    }

    private func isCrosshairsEnabled(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.isCrosshairsEnabled() ?? false)
    }

    private func getChartType(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.chartType.displayName)
    }

    private func getTranslations(methodCall: FlutterMethodCall, result: FlutterResult) {
        let translations = chartIQView?.getTranslations(methodCall.arguments as! String)
        let data = try! JSONSerialization.data(withJSONObject: translations ?? [:], options: .prettyPrinted)
        let stringValue = String(data: data, encoding: .utf8)
        result(stringValue)
    }

    private func setLanguage(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.setLanguage(methodCall.arguments as! String)
        result(nil)
    }

    private func disableDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.disableDrawing()
        result(nil)
    }

    private func getChartAggregationType(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.chartAggregationType?.displayName)
    }

    private func disableCrosshairs(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.enableCrosshairs(false)
        result(nil)
    }

    private func enableCrosshairs(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.enableCrosshairs(true)
        result(nil)
    }

    private func getHUDDetails(methodCall: FlutterMethodCall, result: FlutterResult) {
        if let hud = chartIQView?.getHudDetails() {
            result(hud.toJSONString())
        } else {
            result(ChartIQCrosshairHUD(price: "", volume: "", open: "", high: "", close: "", low: "").toJSONString())
        }
    }

    private func setSymbol(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.loadChart(methodCall.arguments as! String)
        result(nil)
    }

    private func setDataMethod(methodCall: FlutterMethodCall, result: FlutterResult) {
        if let arguments = methodCall.arguments as? [String] {
            let dataMethod = arguments[0]
            let symbol = arguments[1]
            switch dataMethod {
            case "PUSH":
                chartIQView?.setDataMethod(.push)
                break
            case "PULL":
                chartIQView?.setDataMethod(.pull)
                break
            default:
                break
            }
            chartIQView?.loadChart(symbol)
        }
        result(nil)
    }

    private func setPeriodicity(methodCall: FlutterMethodCall, result: FlutterResult) {
        if let arguments = methodCall.arguments as? [Any] {
            let period = arguments[0] as! Int
            let interval = arguments[1] as! String
            let timeUnitString = arguments[2] as! String
            let timeUnit: ChartIQTimeUnit = ChartIQTimeUnit.init(stringValue: timeUnitString.lowercased())!
            chartIQView?.setPeriodicity(period, interval: interval, timeUnit: timeUnit)
        }
        result(nil)
    }

    private func setAggregationType(methodCall: FlutterMethodCall, result: FlutterResult) {
        let aggregationTypeString = methodCall.arguments as! String
        let aggregationType = ChartIQChartAggregationType(stringValue: aggregationTypeString)!
        chartIQView?.setAggregationType(aggregationType)
        result(nil)
    }

    private func setChartStyle(methodCall: FlutterMethodCall, result: FlutterResult) {
        if let arguments = methodCall.arguments as? [String] {
            let obj = arguments[0]
            let attribute = arguments[1]
            let value = arguments[2]
            chartIQView?.setChartStyle(obj, attribute: attribute, value: value)
        }
        result(nil)
    }

    private func setChartType(methodCall: FlutterMethodCall, result: FlutterResult) {
        let aggregationTypeString = methodCall.arguments as! String
        let aggregationType: ChartIQChartType = ChartIQChartType.init(stringValue: aggregationTypeString)!
        chartIQView?.setChartType(aggregationType)
        result(nil)
    }
    
    private func setTheme(methodCall: FlutterMethodCall, result: FlutterResult) {
        switch methodCall.arguments as! String {
        case "day":
            chartIQView?.setTheme(.day)
            break
        case "night":
            chartIQView?.setTheme(.night)
            break
        case "none":
            chartIQView?.setTheme(.none)
            break
        default:
            break
        }
        result(nil)
    }

    private func setRefreshInterval(methodCall: FlutterMethodCall, result: FlutterResult) {
        let refreshInterval = methodCall.arguments as! Int
        chartIQView?.setRefreshInterval(refreshInterval)
        result(nil)
    }

    private func getChartScale(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.getChartScale())
    }

    private func setChartScale(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.setScale(ChartIQScale.init(stringValue: methodCall.arguments as! String)!)
        result(nil)
    }

    private func getEngineProperty(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.getEngineProperty(methodCall.arguments as! String) ?? "")
    }

    private func setEngineProperty(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let property = arguments[0] as! String
        let value = arguments[1]
        chartIQView?.setEngineProperty(property, value: value)
        result(nil)
    }

    private func getChartProperty(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.getChartProperty(methodCall.arguments as! String) ?? "")
    }

    private func setChartProperty(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let property = arguments[0] as! String
        let value = arguments[1]
        chartIQView?.setChartProperty(property, value: value)
        result(nil)
    }

    private func getIsInvertYAxis(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.isInvertYAxis)
    }

    private func setIsInvertYAxis(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! Bool
        chartIQView?.setInvertYAxis(arguments)
        result(nil)
    }

    private func getIsExtendedHours(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.isExtendedHours)
    }

    private func setExtendedHours(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! Bool
        chartIQView?.setExtendHours(arguments)
        result(nil)
    }

    private func getActiveSeries(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.getActiveSeries().toJSONString())
    }

    private func addSeries(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let seriesString = arguments[0] as! String
        let isComparison = arguments[1] as! Bool
        let json = seriesString.convertToDictionary()!
        let series: ChartIQSeries = ChartIQSeries(symbolName: json["symbolName"] as! String, color: UIColor(hexString: json["color"] as! String))
        chartIQView?.addSeries(series, isComparison: isComparison)
        result(nil)
    }

    private func removeSeries(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        chartIQView?.removeSeries(arguments)
        result(nil)
    }

    private func setSeriesParameter(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [String]
        let symbolName = arguments[0]
        let parameterName = arguments[1]
        let value = arguments[2]
        chartIQView?.setSeriesParameter(symbolName, parameterName: parameterName, value: value)
        result(nil)
    }

    private func push(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [String]
        let symbol = arguments[0]
        let dataString = arguments[1]
        chartIQView?.push(symbol, jsonString: dataString)
        result(nil)
    }

    private func pushUpdate(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let data = arguments[0] as! String
        let useAsLastSale = arguments[1] as! Bool
        let jsonData = data.data(using: .utf8)!
        var items: [ChartIQ.ChartIQData] = []
        let jsonArray = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
        if let jsonArray {
            for item in jsonArray {
                items.append(ChartIQ.ChartIQData(dictionary: item))
            }
        }
        chartIQView?.pushUpdate(items, useAsLastSale: useAsLastSale)
        result(nil)
    }

    private func isSupportingFillColor(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingFillColor(drawing))
    }

    private func isSupportingLineColor(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingLineColor(drawing))
    }

    private func isSupportingLineType(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingLineType(drawing))
    }

    private func isSupportingSettings(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingSettings(drawing))
    }

    private func isSupportingFont(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingFont(drawing))
    }

    private func isSupportingAxisLabel(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingAxisLabel(drawing))
    }

    private func isSupportingDeviations(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingDeviations(drawing))
    }

    private func isSupportingFibonacci(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingFibonacci(drawing))
    }

    private func isSupportingElliottWave(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingElliottWave(drawing))
    }

    private func isSupportingVolumeProfile(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingVolumeProfile(drawing))
    }
    
    private func isSupportingShowCallOut(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(drawingManager.isSupportingShowCallout(drawing))
    }

    private func clearDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.clearDrawing()
        result(nil)
    }

    private func enableDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        chartIQView?.enableDrawing(drawing)
        result(nil)
    }

    private func setDrawingParameterByName(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [String]
        let parameterName = arguments[0]
        let value = arguments[1]
        chartIQView?.setDrawingParameter(parameterName, value: value)
        result(nil)
    }

    private func setDrawingParameter(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let parameterName = arguments[0] as! String
        let value = arguments[1]
        chartIQView?.setDrawingParameter(parameterName, value: value)
        result(nil)
    }

    private func getDrawingParameters(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        let drawing = ChartIQDrawingTool.init(stringValue: arguments)!
        result(chartIQView?.getDrawingParameters(drawing)?.toJSONString())
    }

    private func deleteDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.deleteDrawing()
        result(nil)
    }

    private func cloneDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        chartIQView?.cloneDrawing()
        result(nil)
    }

    private func manageLayer(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        switch arguments {
        case "top":
            chartIQView?.manageLayerDrawing(.top)
            break
        case "up":
            chartIQView?.manageLayerDrawing(.up)
            break
        case "back":
            chartIQView?.manageLayerDrawing(.back)
            break
        case "bottom":
            chartIQView?.manageLayerDrawing(.bottom)
            break
        default:
            break
        }
        result(nil)
    }

    private func undoDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.undoDrawing())
    }

    private func redoDrawing(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.redoDrawing())
    }

    private func restoreDefaultDrawingConfig(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let drawingString = arguments[0] as! String
        let all = arguments[1] as! Bool
        let drawing = ChartIQDrawingTool.init(stringValue: drawingString)!
        chartIQView?.restoreDefaultDrawingConfig(drawing, all: all)
        result(nil)
    }

    private func getStudyList(methodCall: FlutterMethodCall, result: FlutterResult) {
        let data = chartIQView?.getAllStudies()
        result(data?.toJSONString())
    }

    private func getActiveStudies(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.getActiveStudies().toJSONString())
    }
    
    private func addStudy(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let jsonData = arguments[0] as! String
        let forClone = arguments[1] as! Bool
        let studyData = jsonData.convertToDictionary()
        let study = studyData?.toChartIQStudy()
        if let study = study {
            do {
                try chartIQView?.addStudy(study, forClone: forClone)
                result(nil)
            } catch let error {
                print(error)
                result(nil)
            }
        }
        result(nil)
    }
    
    private func removeStudy(methodCall: FlutterMethodCall, result: FlutterResult) {
        let jsonData = methodCall.arguments as! String
        let studyData = jsonData.convertToDictionary()
        let study = studyData?.toChartIQStudy()
        if let study = study {
            chartIQView?.removeStudy(study)
        }
        result(nil)
    }
    
    private func getStudyParameters(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as? [Any]
        if let studyString = arguments?[0] as? String,
           let studyData = studyString.convertToDictionary(),
           let study = studyData.toChartIQStudy(),
           let parameterString = arguments?[1] as? String {
            
            var parameterType: ChartIQStudyParametersType = .inputs;
            switch parameterString {
            case "Inputs":
                parameterType = .inputs
                break
            case "Outputs":
                parameterType = .outputs
                break
            case "Parameters":
                parameterType = .parameters
                break
            default: break
            }
            let parameters = chartIQView?.getStudyParameters(study, type: parameterType)
            if let arrayOfRawParams = parameters as? [[String:Any]]{
                let arrayOfParams = arrayOfRawParams.compactMap { $0.toFlutterStudyParameter() }
                result(arrayOfParams.toJsonString())
                return
            }
        }
        result(nil)
    }
    
    private func setStudyParameter(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let studyData = (arguments[0] as! String).convertToDictionary()
        let study = (studyData?.toChartIQStudy())!
        
        if let newParameter = (arguments[1] as? String)?.convertToDictionary() {
            chartIQView?.setStudyParameter(
                study.fullName,
                key: newParameter["fieldName"] as! String,
                value: newParameter["fieldSelectedValue"] as! String
            )
        }
        result(nil)
    }
    
    private func setStudyParameters(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        let studyData = (arguments[0] as! String).convertToDictionary()
        let study = (studyData?.toChartIQStudy())!
        
        if let dataToChange = (arguments[1] as? String)?.JSONParseArray() {
            var dictionary: [String:String] = [:]
            for item in dataToChange {
                if let itemDictionary = item as? [String:String] {
                    dictionary[itemDictionary["fieldName"]!] = itemDictionary["fieldSelectedValue"]
                }
            }
            if let toReturn = chartIQView?.setStudyParameters(study, parameters: dictionary) {
                result(toReturn.toJSONString())
                return
            }
        }
        result(nil)
    }
    
    //MARK: Signal
    private func addSignalStudy(methodCall: FlutterMethodCall, result: FlutterResult) {
        if let arguments = methodCall.arguments as? String,
           let studyData = arguments.convertToDictionary(),
           let study = studyData.toChartIQStudy() {
            result(chartIQView?.addSignalStudy(study)?.toJSONString())
            return
        }
        
        result(nil)
    }
    
    private func saveSignal(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! [Any]
        
        if let isEdit = arguments[1] as? Bool,
           let signalString = (arguments[0] as? String),
           let signalData = signalString.convertToDictionary(),
           let signal = signalData.toChartIQSignal() {
            chartIQView?.saveSignal(signal, isEdit: isEdit)
        }
        
        result(nil)
    }
    
    private func getActiveSignals(methodCall: FlutterMethodCall, result: FlutterResult) {
        result(chartIQView?.getActiveSignals().toJSONString())
    }
    
    private func toggleSignal(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        if let signalData = arguments.convertToDictionary(),
           let signal = signalData.toChartIQSignal() {
            chartIQView?.toggleSignal(signal)
        }
        result(nil)
    }
    
    private func removeSignal(methodCall: FlutterMethodCall, result: FlutterResult) {
        let arguments = methodCall.arguments as! String
        if let signalData = arguments.convertToDictionary(),
           let signal = signalData.toChartIQSignal() {
            chartIQView?.removeSignal(signal)
        }
        result(nil)
    }
}

extension FLNativeView: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let url = self.url {
                self.сhartIqWrapperView.url = url
            }
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}

extension FLNativeView: ChartIQDataSource {
    func pullInitialData(by params: ChartIQ.ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQ.ChartIQData]) -> Void) {
        print("pullInitialData SDK")
        if (!readyWasSend) {
            readyWasSend = true
            let modelReady = DataPullModel(type: .chartReady, params: nil)
            self.eventSink!(modelReady.toJSONString())
        }
        self.pullInitialDataLastCallBack.append(completionHandler)
        let model = DataPullModel(type: .pullInitialData, params: params)
        self.eventSink!(model.toJSONString())
    }

    func pullUpdateData(by params: ChartIQ.ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQ.ChartIQData]) -> Void) {
        print("pullUpdateData SDK")
        self.pullUpdateDataLastCallBack.append(completionHandler)
        let model = DataPullModel(type: .pullUpdateData, params: params)
        self.eventSink!(model.toJSONString())
    }

    func pullPaginationData(by params: ChartIQ.ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQ.ChartIQData]) -> Void) {
        print("pullPaginationData SDK")
        self.pullPaginationDataLastCallBack.append(completionHandler)
        let model = DataPullModel(type: .pullPaginationData, params: params)
        self.eventSink!(model.toJSONString())
    }
}

extension FLNativeView: ChartIQDelegate {
    func chartIQViewDidFinishLoading(_ chartIQView: ChartIQ.ChartIQView) {
        print("chartIQViewDidFinishLoading")
        chartIQView.setDataMethod(.pull)
        chartIQView.setVoiceoverFields(default: true)
        let model = ChartAvailableModel(type: .chartAvailable, available: true)
        self.eventSink!(model.toJSONString())
    }

    func chartIQView(_ chartIQView: ChartIQView, didUpdateMeasure measure: String) {
        let model = MeasureModel(measure: measure)
        self.eventSink!(model.toJSONString())
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func JSONParseArray() -> [Any]? {
        if let data = self.data(using: .utf8){
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)  as? [AnyObject] {
                    return array
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension [String: Any] {
    public func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
              let stringValue = String(data: data, encoding: .utf8) else { return "" }
        return stringValue
    }
}


