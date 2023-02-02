import 'dart:math' show pi;

import 'package:animated_builder_and_transform/example2/extension/delayed.dart';
import 'package:flutter/material.dart';

import 'custom_clipper.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState(); // for animations need state full widget
}

class _ExampleTwoState extends State<ExampleTwo> with TickerProviderStateMixin {
  late AnimationController _counterClokWiseAnimationController;
  late Animation<double> _counterClokWiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    _counterClokWiseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClokWiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2.0),
    ).animate(
      CurvedAnimation(
        parent: _counterClokWiseAnimationController,
        curve: Curves.bounceOut,
      ),
    );
    // flip animaton

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    // status listener
    _counterClokWiseAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut,
          ),
        );

        _flipController
          ..reset
          ..forward();
      }
    });

    _flipController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _counterClokWiseRotationAnimation = Tween<double>(
                  begin: _counterClokWiseRotationAnimation.value,
                  end: _counterClokWiseRotationAnimation.value + -(pi / 2))
              .animate(
            CurvedAnimation(
              parent: _counterClokWiseAnimationController,
              curve: Curves.bounceOut,
            ),
          );
          _counterClokWiseAnimationController
            ..reset
            ..forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _counterClokWiseAnimationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClokWiseAnimationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
        body: SafeArea(
      child: AnimatedBuilder(
        animation: _counterClokWiseAnimationController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(
                _counterClokWiseRotationAnimation.value,
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // center the row
              children: [
                _buildBlueCircle(),
                _buildYellowCircle(),
              ],
            ),
          );
        },
      ),
    ));
  }

  AnimatedBuilder _buildBlueCircle() {
    return AnimatedBuilder(
      animation: _flipController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..rotateY(
              _flipAnimation.value,
            ),
          child: ClipPath(
            clipper: HalfCircleClipper(side: CircleSide.left),
            child: Container(
              color: const Color(0xff0057b7),
              height: 100,
              width: 100,
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder _buildYellowCircle() {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..rotateY(
              _flipAnimation.value,
            ),
          alignment: Alignment.centerLeft,
          child: ClipPath(
            clipper: HalfCircleClipper(side: CircleSide.right),
            child: Container(
              color: const Color(0xffffd700),
              height: 100,
              width: 100,
            ),
          ),
        );
      },
    );
  }
}

enum CircleSide {
  left,
  right,
}
