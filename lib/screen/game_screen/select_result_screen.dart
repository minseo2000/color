import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/game_level.dart';
import '../home_screen.dart';
import 'memorize_color_game_screen2.dart';

class SelectResultScreen extends StatefulWidget {
  final List<Color> correctSequence;
  final int currentLevel;

  const SelectResultScreen({
    Key? key,
    required this.correctSequence,
    required this.currentLevel,
  }) : super(key: key);

  @override
  State<SelectResultScreen> createState() => _SelectResultScreenState();
}

class _SelectResultScreenState extends State<SelectResultScreen> {
  late List<Color> _colorButtons;
  final List<Color> _userSelected = [];

  @override
  void initState() {
    super.initState();
    _colorButtons = List<Color>.from(widget.correctSequence);
  }

  void _onColorSelected(Color color) {
    if (_userSelected.contains(color)) return;

    setState(() {
      _userSelected.add(color);
    });

    if (_userSelected.length == widget.correctSequence.length) {
      bool isCorrect = true;
      for (int i = 0; i < widget.correctSequence.length; i++) {
        if (_userSelected[i] != widget.correctSequence[i]) {
          isCorrect = false;
          break;
        }
      }

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Text(isCorrect ? '정답입니다!' : '틀렸습니다.'),
          content: isCorrect ? const Text('다음 단계로 넘어가시겠습니까?') : null,
          actions: [
            if (isCorrect)
              TextButton(
                onPressed: () {
                  if (widget.currentLevel + 1 < gameLevels.length) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MemorizeColorGameScreen2(
                          changeCount: gameLevels[widget.currentLevel + 1].changeCount,
                          interval: gameLevels[widget.currentLevel + 1].interval,
                          currentLevel: widget.currentLevel + 1,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                child: const Text('다음 단계', style: TextStyle(color: Colors.black),),
              ),
            TextButton(
              onPressed: () {
                if (isCorrect) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                } else {
                  setState(() {
                    _userSelected.clear();
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(isCorrect ? '홈으로 가기' : '다시 시도', style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildColorButton(Color color) {
    final bool isSelected = _userSelected.contains(color);

    return Container(
      width: 100.0,
      height: 60.0,
      margin: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: isSelected
              ? const BorderSide(color: Colors.black, width: 3.0)
              : BorderSide.none,
        ),
        onPressed: isSelected ? null : () => _onColorSelected(color),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white)
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                '순서에 맞게 색상을 고르세요!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _colorButtons.map(_buildColorButton).toList(),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                onPressed: () {
                  setState(() {
                    _userSelected.clear();
                  });
                },
                child: const Text('다시 선택하기', style: TextStyle(color: Colors.black),),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                  );
                },
                child: const Text('다시 시작하기', style: TextStyle(color: Colors.black),),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
