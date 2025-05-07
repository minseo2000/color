import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class TimeBasedColorWidget extends StatefulWidget {
  final Duration interval;     // 색상 변경 간격
  final int changeCount;       // 몇 번까지 색상 변경할지
  final Widget Function(Color currentColor, List<Color> historyColors) builder;

  const TimeBasedColorWidget({
    Key? key,
    required this.interval,
    required this.changeCount,
    required this.builder,
  }) : super(key: key);

  @override
  _TimeBasedColorWidgetState createState() => _TimeBasedColorWidgetState();
}

class _TimeBasedColorWidgetState extends State<TimeBasedColorWidget> {
  final Random _random = Random();
  late Color _currentColor;
  final List<Color> _colorHistory = [];
  Timer? _timer;
  int _currentCount = 0;

  @override
  void initState() {
    super.initState();
    _currentColor = _generateRandomColor();
    _colorHistory.add(_currentColor);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (_) {
      if (_currentCount >= widget.changeCount - 1) {
        _timer?.cancel();
        return;
      }
      setState(() {
        _currentColor = _generateRandomColor();
        _colorHistory.add(_currentColor);
        _currentCount++;
      });
    });
  }

  Color _generateRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      color: _currentColor,
      child: widget.builder(_currentColor, List.unmodifiable(_colorHistory)),
    );
  }
}
