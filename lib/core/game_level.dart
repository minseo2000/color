class GameLevel {
  final int changeCount;
  final Duration interval;

  GameLevel({required this.changeCount, required this.interval});
}

// 예시: 10개 레벨 정의
final List<GameLevel> gameLevels = [
  GameLevel(changeCount: 3, interval: Duration(milliseconds: 2500)), // Level 1
  GameLevel(changeCount: 4, interval: Duration(milliseconds: 2400)), // Level 2
  GameLevel(changeCount: 5, interval: Duration(milliseconds: 2200)), // Level 3
  GameLevel(changeCount: 6, interval: Duration(milliseconds: 2000)), // Level 4
  GameLevel(changeCount: 7, interval: Duration(milliseconds: 1800)), // Level 5
  GameLevel(changeCount: 8, interval: Duration(milliseconds: 1600)), // Level 6
  GameLevel(changeCount: 9, interval: Duration(milliseconds: 1400)), // Level 7
  GameLevel(changeCount: 10, interval: Duration(milliseconds: 1200)), // Level 8
  GameLevel(changeCount: 12, interval: Duration(milliseconds: 1000)), // Level 9
  GameLevel(changeCount: 15, interval: Duration(milliseconds: 800)), // Level 10
];
