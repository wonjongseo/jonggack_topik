import 'dart:async';
import 'package:flutter/material.dart';

class MovingDots extends StatefulWidget {
  const MovingDots({super.key});

  @override
  State<MovingDots> createState() => _MovingDotsState();
}

class _MovingDotsState extends State<MovingDots> {
  String _dots = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _dots = '.' * ((_dots.length + 1) % 4);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('データを読み込んでいます $_dots');
  }
}
