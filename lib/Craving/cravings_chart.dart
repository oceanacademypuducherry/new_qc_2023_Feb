import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SFM/Get_X_Controller/cravings_controller.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class CravingsChart extends StatelessWidget {
  final CravingsController _cravingsController = Get.find<CravingsController>();

  CravingsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SfCartesianChart(
          onZooming: (val) {
            print(val);
          },
          series: <ChartSeries>[
            // Renders spline chart

            SplineSeries(
              xAxisName: "Times",
              yAxisName: "Strong",
              legendItemText: "Cravings",
              initialSelectedDataIndexes: const [0],
              isVisibleInLegend: true,
              splineType: SplineType.monotonic,
              dataSource: [
                const {"strong": 0},
                ..._cravingsController.cravingsData
              ],
              xValueMapper: (data, index) => index,
              yValueMapper: (data, _) => data['strong'],
            )
          ],
        ));
  }
}
