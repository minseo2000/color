import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memory_test_game/screen/game_screen/select_result_screen.dart';

class MemorizeColorGameScreen2 extends StatefulWidget {
  final int changeCount;
  final Duration interval;
  final int currentLevel;

  const MemorizeColorGameScreen2({
    Key? key,
    required this.changeCount,
    required this.interval,
    required this.currentLevel,
  }) : super(key: key);

  @override
  State<MemorizeColorGameScreen2> createState() => _MemorizeColorGameScreen2State();
}

class _MemorizeColorGameScreen2State extends State<MemorizeColorGameScreen2> {
  final List<Color> _history = [];
  late Timer _timer;
  bool _navigated = false;
  Color _currentColor = Colors.white;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startColorSequence();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startColorSequence() {
    _generateNextColor(); // 첫 색상 먼저 보여주기

    _timer = Timer.periodic(widget.interval, (timer) {
      if (_history.length >= widget.changeCount) {
        _timer.cancel();

        Future.delayed(const Duration(milliseconds: 500), () {
          if (!_navigated) {
            _navigated = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectResultScreen(
                  correctSequence: List<Color>.from(_history),
                  currentLevel: widget.currentLevel,
                ),
              ),
            );
          }
        });
      } else {
        _generateNextColor();
      }
    });
  }

  void _generateNextColor() {
    Color newColor;
    do {
      newColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    } while (_history.contains(newColor));

    setState(() {
      _currentColor = newColor;
      _history.add(newColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor,
      body: const SizedBox.expand(
        child: Center(
          child: Text("색상을 기억하세요!", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}