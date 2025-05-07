import 'package:flutter/material.dart';

class AnimatedCountdown extends StatefulWidget {
  final List<String> countdownNumbers;
  final VoidCallback? onFinished;

  const AnimatedCountdown({
    super.key,
    required this.countdownNumbers,
    this.onFinished,
  });

  @override
  State<AnimatedCountdown> createState() => _AnimatedCountdownState();
}

class _AnimatedCountdownState extends State<AnimatedCountdown> {
  int _currentIndex = 0;
  bool _animated = false;

  final Duration _duration = const Duration(milliseconds: 500);
  final Curve _curve = Curves.elasticOut;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _runStep();
  }

  void _runStep() {
    if (_currentIndex >= widget.countdownNumbers.length) {
      widget.onFinished?.call();
      return;
    }

    setState(() {
      _animated = false;
    });

    // 애니메이션 시작 후 잠깐 delay 주고 재생
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animated = true;
      });
    });

    // 다음 숫자로 넘어감
    Future.delayed(_duration + const Duration(milliseconds: 600), () {
      setState(() {
        _currentIndex += 1;
        _animated = false;
      });
      _runStep();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= widget.countdownNumbers.length) {
      return const SizedBox.shrink();
    }

    return AnimatedScale(
      scale: _animated ? 1.0 : 0.1,
      duration: _duration,
      curve: _curve,
      child: TweenAnimationBuilder<Color?>(
        duration: _duration,
        curve: _curve,
        tween: ColorTween(
          begin: Colors.grey,
          end: Colors.yellow,
        ),
        builder: (context, color, child) {
          return Text(
            widget.countdownNumbers[_currentIndex],
            style: TextStyle(
              fontSize: 60,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}

