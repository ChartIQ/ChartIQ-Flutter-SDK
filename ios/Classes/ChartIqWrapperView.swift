//
//  ChartIqWrapperView.swift
//  chartiq_flutter_sdk
//
//  Created by user on 6/27/23.
//

import ChartIQ

class ChartIqWrapperView: UIView {
    internal var chartIQView: ChartIQView!

    @objc var url: String = "" {
        didSet {
            chartIQView.setChartIQUrl(url)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        chartIQView = ChartIQView(frame: frame)

        setUpChart()
    }

    func setUpChart() {
        chartIQView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(chartIQView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
