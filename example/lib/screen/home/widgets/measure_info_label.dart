import 'dart:async';

import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:flutter/material.dart';

class MeasureInfoLabel extends StatefulWidget {
  const MeasureInfoLabel({
    Key? key,
    required this.chartIQController,
    this.drawingTool,
  }) : super(key: key);

  final ChartIQController chartIQController;
  final DrawingTool? drawingTool;

  @override
  State<MeasureInfoLabel> createState() => _MeasureInfoLabelState();
}

class _MeasureInfoLabelState extends State<MeasureInfoLabel> {
  String? info;
  late StreamSubscription<String> measureListener;

  @override
  void initState() {
    super.initState();
    measureListener =
        widget.chartIQController.addMeasureListener().listen((event) {
      setState(() {
        if (event.isEmpty) return;
        info = event;
      });
    });
  }

  @override
  void didUpdateWidget(covariant MeasureInfoLabel oldWidget) {
    if(oldWidget.drawingTool != widget.drawingTool) {
      info = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    measureListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (info == null || info!.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.8),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 30,
      ),
      child: Text(
        info!,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
