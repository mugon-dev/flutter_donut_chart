import 'dart:math';

import 'package:donut_chart/home/date_item.dart';
import 'package:flutter/material.dart';

final linePaint = Paint()
  ..color = Colors.white
  ..strokeWidth = 1.0
  ..style = PaintingStyle.stroke;
final midPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;

class DonutChartPainter extends CustomPainter {
  final List<DateItem> dataset;
  final double fullAngle;
  DonutChartPainter(this.dataset, this.fullAngle);

  @override
  void paint(Canvas canvas, Size size) {
    //compute center
    final c = Offset(size.width / 2.0, size.height / 2.0);

    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);

    //시작 각도
    var startAngle = 0.0;

    for (var data in dataset) {
      final sweepAngle = data.value * fullAngle * pi / 180.0;
      //각 영역 색칠
      drawSectors(data, canvas, rect, startAngle, sweepAngle);
      //각 영역의 구분선
      drawLines(radius, startAngle, c, canvas);
      //각 영역이 서로 밀접하게 압축되도록 sweepAngle를 추가하여 시작 각도 업데이트
      startAngle += sweepAngle;
    }
    // draw mid circle
    canvas.drawCircle(c, radius * 0.3, midPaint);
  }

  void drawLines(double radius, double startAngle, Offset c, Canvas canvas) {
    final dx = radius / 2.0 * cos(startAngle);
    final dy = radius / 2.0 * sin(startAngle);
    final p2 = c + Offset(dx, dy);
    canvas.drawLine(c, p2, linePaint);
  }

  double drawSectors(DateItem data, Canvas canvas, Rect rect, double startAngle, double sweepAngle) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = data.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    return sweepAngle;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
