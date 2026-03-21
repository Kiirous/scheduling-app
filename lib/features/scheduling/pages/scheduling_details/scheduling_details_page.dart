import 'package:flutter/material.dart';

class SchedulingDetailsPage extends StatefulWidget {
  const SchedulingDetailsPage({super.key, required this.schedulingId});

  final String schedulingId;

  @override
  State<SchedulingDetailsPage> createState() => _SchedulingDetailsPageState();
}

class _SchedulingDetailsPageState extends State<SchedulingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.schedulingId)));
  }
}
