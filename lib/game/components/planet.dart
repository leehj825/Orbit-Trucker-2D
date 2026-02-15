import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Planet extends PositionComponent {
  final double mass;
  final double radius;
  final Paint _paint;

  Planet({
    required Vector2 position,
    required this.radius,
    this.mass = 100000.0,
  }) : _paint = Paint()..color = Colors.green,
       super(position: position, size: Vector2.all(radius * 2), anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), radius, _paint);
  }
}
