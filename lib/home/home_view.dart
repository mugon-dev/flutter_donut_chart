import 'dart:async';

import 'package:donut_chart/home/date_item.dart';
import 'package:donut_chart/home/donut_chart_painter.dart';
import 'package:donut_chart/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  controller.open();
                },
                child: Text('open')),
            GetBuilder<HomeController>(
              builder: (_) => controller.isOpen
                  ? SizedBox(
                      width: 210,
                      child: Column(
                        children: [
                          Container(
                            width: 210,
                            height: 210,
                            color: Colors.white,
                            child: DonutChartStreamWidget(dataset: controller.dataset),
                          ),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            childAspectRatio: 4,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 40,
                            children: List.generate(
                                controller.dataset.length,
                                (index) => Row(
                                      children: [
                                        Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: controller.dataset[index].color),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(controller.dataset[index].label),
                                      ],
                                    )),
                          )
                        ],
                      ),
                    )
                  : Text('${controller.isOpen}'),
            ),
          ],
        ),
      ),
    );
  }
}

class DonutChartWidget extends StatefulWidget {
  final List<DateItem> dataset;
  const DonutChartWidget(this.dataset, {Key? key}) : super(key: key);

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  late Timer timer;
  double fullAngle = 0.0;
  double secondsToComplete = 5.0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: DonutChartPainter(widget.dataset, fullAngle),
      ),
    );
  }
}

class DonutChartStreamWidget extends StatelessWidget {
  final List<DateItem> dataset;
  const DonutChartStreamWidget({Key? key, required this.dataset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullAngle = 0.0;
    double secondsToComplete = 5.0;
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
        fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          return;
        }
      }),
      builder: (context, snapshot) => CustomPaint(
        child: Container(),
        painter: DonutChartPainter(dataset, fullAngle),
      ),
    );
  }
}
