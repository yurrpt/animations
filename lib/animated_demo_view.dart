import 'dart:math' show pi;

import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter/material.dart';

class AnimatedDemoView extends StatefulWidget {
  const AnimatedDemoView({Key? key}) : super(key: key);
  @override
  State<AnimatedDemoView> createState() => _AnimatedDemoViewState();
}

class _AnimatedDemoViewState extends State<AnimatedDemoView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /*
    0.0 = 0 derece / 0 degress
    0.5 = 180 derece / 180 degress
    1.0 = 360 derece / 360 degress

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemBlue.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: CupertinoColors.systemBlue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
