//
//  ViewController.swift
//  CandleChartSample
//
//  Created by mithril1992 on 2023/03/26.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var candleStickChart: CandleStickChartView?

    override func viewDidLoad() {
        super.viewDidLoad()

        candleStickChart?.setup()
        candleStickChart?.data = self.createChartData()
        candleStickChart?.resetViewPortOffsets()
    }

    private func createChartData() -> CandleChartData {
        let data = CandleChartData()

        let dataSet = CandleChartDataSet()

        dataSet.neutralColor = .gray
        dataSet.increasingColor = .green
        dataSet.increasingFilled = true
        dataSet.decreasingColor = .red
        dataSet.decreasingFilled = true
        dataSet.shadowColorSameAsCandle = true

        var lastClose = round(Double.random(in: 300...500))

        for i in 0...240 {
            let changeRatio = Double.random(in: -0.05...0.05)

            let close = round(Double(lastClose) * (1.0 + changeRatio))
            let open = round(close * (Double.random(in: -0.05...0.05) + 1))
            let high = round(Swift.max(open, close) * (1 + Double.random(in: 0...0.02)))
            let low = round(Swift.min(open, close) * (1 + Double.random(in: 0...0.2)))

            let entry = CandleChartDataEntry(
                x: Double(i),
                shadowH: high,
                shadowL: low,
                open: open,
                close: close
            )
            dataSet.append(entry)
            dataSet.axisDependency = .left
            lastClose = close
        }

        data.append(dataSet)

        return data
    }


}

private extension CandleStickChartView {
    func setup() {
        self.pinchZoomEnabled = false
        self.autoScaleMinMaxEnabled = true
        self.doubleTapToZoomEnabled = false
        self.rightAxis.enabled = false
        self.xAxis.labelPosition = .bottom

        self.highlightPerTapEnabled = false
        self.highlightPerDragEnabled = false

        self.xAxis.axisMinimum = 0
        self.xAxis.axisMaximum = 240
        self.setVisibleXRange(minXRange: 60, maxXRange: 60)
        self.notifyDataSetChanged()
    }
}
