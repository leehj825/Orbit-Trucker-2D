import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ship extends PositionComponent {
  Vector2 velocity = Vector2.zero();
  double fuel = 100.0;
  double cash = 0.0;
  bool isThrusting = false;
  double rotationSpeed = 0.0;

  static const double _thrustForce = 100.0;
  static const double _rotationRate = 3.0; // Radians per second
  final Paint _paint = Paint()..color = Colors.blue;

  Ship() : super(size: Vector2(20, 30), anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    // Draw a simple triangle pointing UP (relative to local coordinates)
    // Local (0,0) is top-left of the bounding box.
    // Center is (10, 15).
    // Tip at (10, 0).
    // Bottom Left (0, 30).
    // Bottom Right (20, 30).

    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..lineTo(0, size.y)
      ..close();

    canvas.drawPath(path, _paint);

    if (isThrusting) {
       final enginePaint = Paint()..color = Colors.orange;
       canvas.drawCircle(Offset(size.x / 2, size.y + 5), 5, enginePaint);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    angle += rotationSpeed * dt;

    if (isThrusting && fuel > 0) {
      // Vector(0, -1) is UP.
      final direction = Vector2(0, -1)..rotate(angle);
      velocity.add(direction * _thrustForce * dt);
      fuel -= dt * 5;
      if (fuel < 0) fuel = 0;
    }

    position.add(velocity * dt);
  }

  // -1 for left, 1 for right, 0 for stop
  void setRotationDirection(int dir) {
    rotationSpeed = dir * _rotationRate;
  }

  void setThrust(bool thrust) {
    isThrusting = thrust;
  }
}
