import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';
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

    // Ship starts between planets, facing Planet A (Down/180 degrees)
    ship = Ship()
      ..position = Vector2(centerX, size.y * 0.5)
      ..angle = pi;

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

    // Find nearest planet to launch from
    final distA = ship.position.distanceTo(planetA.position);
    final distB = ship.position.distanceTo(planetB.position);
    final nearestPlanet = distA < distB ? planetA : planetB;

    // Vector pointing away from planet center
    final direction = (ship.position - nearestPlanet.position).normalized();

    // Set position to be safely outside landing threshold (radius + 5 + buffer)
    // Buffer = 20 pixels
    final safeDistance = nearestPlanet.radius + 25.0;
    ship.position = nearestPlanet.position + (direction * safeDistance);

    // Give a small initial velocity away from the planet to prevent immediate re-docking
    ship.velocity = direction * 60.0;
  }

  void resetGame() {
    docked = false;
    ship.position = Vector2(size.x / 2, size.y * 0.5);
    ship.velocity = Vector2.zero();
    ship.fuel.value = 100.0;
    ship.angle = pi;
  }
}
