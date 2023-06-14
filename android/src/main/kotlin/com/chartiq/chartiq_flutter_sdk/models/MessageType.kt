package com.chartiq.chartiq_flutter_sdk.models

enum class MessageType {
    pullInitialData,
    pullUpdateData,
    pullPaginationData,
    chartAvailable,
    measure
}