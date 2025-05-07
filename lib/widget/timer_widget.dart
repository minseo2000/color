import 'dart:async';
import 'dart:ui';

class GameTimer {
  final int durationSeconds;
  final void Function(int remainingSeconds)? onTick;
  final VoidCallback? onTimeout;

  Timer? _timer;
  int _remainingSeconds = 0;

  GameTimer({
    this.durationSeconds = 10,
    this.onTick,
    this.onTimeout,
  });

  void start() {
    _remainingSeconds = durationSeconds;

    _timer?.cancel(); // 기존 타이머 취소
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _remainingSeconds--;

      // 매 초마다 콜백 실행
      if (onTick != null) onTick!(_remainingSeconds);

      if (_remainingSeconds <= 0) {
        timer.cancel();
        if (onTimeout != null) onTimeout!();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    stop();
    _remainingSeconds = durationSeconds;
  }

  int get remainingSeconds => _remainingSeconds;

  bool get isRunning => _timer?.isActive ?? false;
}
