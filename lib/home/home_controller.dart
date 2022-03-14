import 'package:donut_chart/home/date_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const double total = 5910000;
  List<DateItem> dataset = [
    DateItem(value: 2436102 / total, label: '교통비', color: const Color(0xFFF38181)),
    DateItem(value: 1430811 / total, label: '식비', color: const Color(0xFF7BE3D0)),
    DateItem(value: 960375 / total, label: '난방비 지원', color: const Color(0xFFE3FFC1)),
    DateItem(value: 643599 / total, label: '의료비', color: const Color(0xFFFCE38A)),
    DateItem(value: 329187 / total, label: '의류비', color: const Color(0xFFAADCD8)),
    DateItem(value: 108153 / total, label: '주거비', color: const Color(0xFF97BFB4)),
  ];

  bool _isOpen = false;
  bool get isOpen => _isOpen;
  void open() {
    _isOpen = !_isOpen;
    update();
  }
}
