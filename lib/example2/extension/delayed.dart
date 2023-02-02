import 'dart:ui';

extension Delayed on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}
