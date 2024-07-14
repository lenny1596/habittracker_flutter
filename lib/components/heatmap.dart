import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class Heatmap extends StatelessWidget {
  final DateTime? startDate;
  final Map<DateTime, int>? datasets;

  const Heatmap({
    super.key,
    required this.startDate,
    required this.datasets,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: datasets,
      textColor: Colors.white,
      defaultColor: Theme.of(context).colorScheme.secondary,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 30,
      colorMode: ColorMode.color,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
    );
  }
}
