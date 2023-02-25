import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class CravingsChart extends StatelessWidget {
  final CravingsController _cravingsController = Get.find<CravingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SfCartesianChart(
          series: <ChartSeries>[
            // Renders spline chart

            SplineSeries(
                xAxisName: "Day",
                yAxisName: "Strong",
                legendItemText: "Cravings",
                initialSelectedDataIndexes: const [0],
                isVisibleInLegend: true,
                splineType: SplineType.monotonic,
                dataSource: _cravingsController.cravingsData.value,
                xValueMapper: (data, _) => data['day'],
                yValueMapper: (data, _) => data['strong'])
          ],
        ));
  }
}
