import 'package:animated_builder_and_transform/example2/extension/to_path.dart';
import 'package:flutter/material.dart';

import 'example2.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircleClipper({
    required this.side,
  });

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
