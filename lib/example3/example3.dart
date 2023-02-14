import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  final size = 100.0;
  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([_xController, _yController, _zController]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateY(_animation.evaluate(_xController))
                    ..rotateX(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      // ön yüz (front)
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..translate(Vector3(0, 0, -size)),
                        child: Container(
                          height: size,
                          width: size,
                          color: CupertinoColors.systemPurple,
                        ),
                      ),

                      // left side
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2.0),
                        child: Container(
                          height: size,
                          width: size,
                          color: CupertinoColors.systemRed,
                        ),
                      ),

                      // right side
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-pi / 2.0),
                        child: Container(
                          height: size,
                          width: size,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      Container(
                        height: size,
                        width: size,
                        color: CupertinoColors.systemGreen,
                      ),
                      // arka yüz (back)

                      // üst yüz (top)
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi / 2.0),
                        child: Container(
                          height: size,
                          width: size,
                          color: CupertinoColors.activeOrange,
                        ),
                      ),

                      // alt yüz (bottom)

                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2.0),
                        child: Container(
                          height: size,
                          width: size,
                          color: CupertinoColors.tertiarySystemFill,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
