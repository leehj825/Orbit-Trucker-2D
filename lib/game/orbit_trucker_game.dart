import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/ship.dart';
import 'components/planet.dart';
import 'systems/gravity_system.dart';

class OrbitTruckerGame extends FlameGame {
  late Ship ship;
  late Planet planetA;
  late Planet planetB;
  bool docked = false;

  // Callbacks
  final VoidCallback onDocked;

  OrbitTruckerGame({required this.onDocked});

  @override
  Future<void> onLoad() async {
    // Planets
    // Using a fixed size assumption or relative to screen.
    // Note: size might be 0 if not layout yet, but usually onLoad happens after attach.
    // Just in case, we can use a fixed world size or center.
    final centerX = size.x / 2;

    planetA = Planet(
      position: Vector2(centerX, size.y * 0.8),
      radius: 40,
      mass: 1000000
    );

    planetB = Planet(
      position: Vector2(centerX, size.y * 0.2),
      radius: 30,
      mass: 500000
    );

    // Ship starts near Planet A
    ship = Ship()..position = Vector2(centerX, size.y * 0.7);

    add(planetA);
    add(planetB);
    add(ship);

    add(GravitySystem(ship: ship, planets: [planetA, planetB]));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!docked) {
      checkLanding(planetA);
      checkLanding(planetB);
    }
  }

  void checkLanding(Planet planet) {
    final dist = ship.position.distanceTo(planet.position);
    final surfaceDist = dist - planet.radius;

    // Landing Logic: Trigger a "Docked" state if distance < threshold AND speed < safe_limit.
    if (surfaceDist < 5 && ship.velocity.length < 50) {
      docked = true;
      ship.velocity.setZero();
      ship.setThrust(false);
      ship.setRotationDirection(0);
      onDocked();
    }
  }

  // Controls
  void startThrust() => ship.setThrust(true);
  void stopThrust() => ship.setThrust(false);
  void rotateLeftStart() => ship.setRotationDirection(-1);
  void rotateRightStart() => ship.setRotationDirection(1);
  void rotateStop() => ship.setRotationDirection(0);

  void undock() {
    docked = false;
    // Push ship slightly away to avoid immediate re-dock
    // Vector pointing away from nearest planet
    // For simplicity, just up/down depending on planet
    // ship.position.add(Vector2(0, -10));
  }

  void resetGame() {
    docked = false;
    ship.position = Vector2(size.x / 2, size.y * 0.7);
    ship.velocity = Vector2.zero();
    ship.fuel = 100.0;
    ship.angle = 0;
  }
}
