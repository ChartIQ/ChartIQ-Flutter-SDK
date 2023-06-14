package com.chartiq.chartiq_flutter_sdk

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class ChartIQWebViewFactory constructor(
    private val messenger: BinaryMessenger,
    private val activity: Activity?
): PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val url = (args as HashMap<String, String>)["url"]!!
        return ChartIQWebView(context, messenger, viewId, activity, url)
    }
}