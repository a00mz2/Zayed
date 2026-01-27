// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart' as init;
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:zayed/core/functions/formatNumber.dart';

class ScrollableSalesChart extends StatefulWidget {
  final List<dynamic> growthData;

  const ScrollableSalesChart({super.key, required this.growthData});

  @override
  State<ScrollableSalesChart> createState() => _ScrollableSalesChartState();
}

class _ScrollableSalesChartState extends State<ScrollableSalesChart> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // نبدأ المتحكم بدون إزاحة أولية لأننا سنعكس اتجاه القائمة
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    double fixedDayWidth = 50.0; // زيادة العرض قليلاً لراحة العين
    double chartWidth = (widget.growthData.length * fixedDayWidth) + 80;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            reverse: false,
            child: Container(
              width: chartWidth,
              height:
                  200, // تم تقليل الارتفاع من 300 إلى 180 لتقليل المساحة العمودية
              padding: const EdgeInsets.only(
                top: 60, // تم تقليل المسافة العلوية من 30 إلى 10
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: LineChart(mainData()),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    // عكس قائمة البيانات لتبدأ من اليمين (الأقدم أولاً)
    final reversedData = widget.growthData;

    double maxCount = reversedData.isEmpty
        ? 0
        : reversedData.map((e) => (e['count'] as num).toDouble()).reduce(max);

    double maxYValue = maxCount == 0 ? 500 : maxCount;
    double sideInterval = maxYValue / 5;

    return LineChartData(
      gridData: const FlGridData(show: false),
      minY: 0,
      maxY: maxYValue,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (spot) => const Color(0xFFD81B60),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              // الوصول للبيانات الصحيحة بعد التأكد من الفهرس
              final amount = reversedData[spot.x.toInt()]['amount'];
              return LineTooltipItem(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                '${formatNumberNum(int.parse(amount.toStringAsFixed(0)))} د.ع ',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            }).toList();
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        // المحور الجانبي يظهر في اليسار في وضع RTL (أو يمكن تركه لليمين حسب الرغبة)
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: sideInterval,
            getTitlesWidget: (value, meta) {
              if (maxCount == 0) {
                List<int> defaultLabels = [0, 100, 150, 200, 350, 500];
                int labelIndex = (value / sideInterval).round();
                if (labelIndex >= 0 && labelIndex < defaultLabels.length) {
                  return Text(
                    defaultLabels[labelIndex].toString(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  );
                }
                return const SizedBox();
              }
              return Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if (index >= 0 && index < reversedData.length) {
                DateTime date = DateTime.parse(reversedData[index]['date']);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 10,
                  child: Text(
                    init.DateFormat('d MMM', 'ar').format(date),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          // رسم النقاط بالترتيب الطبيعي للقائمة
          spots: reversedData.asMap().entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value['count'].toDouble());
          }).toList(),
          isCurved: true,
          curveSmoothness: 0.2,
          preventCurveOverShooting: true,
          color: const Color(0xFFD81B60),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, xPercent, bar, index) => FlDotCirclePainter(
              radius: 4,
              color: const Color(0xFFD81B60),
              strokeWidth: 2,
              strokeColor: Colors.white,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFFD81B60).withOpacity(0.3),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
