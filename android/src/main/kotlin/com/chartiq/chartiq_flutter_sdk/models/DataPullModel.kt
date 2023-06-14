package com.chartiq.chartiq_flutter_sdk.models

import com.chartiq.sdk.model.QuoteFeedParams

data class DataPullModel(
    val type: String,
    val params: QuoteFeedParams
)
