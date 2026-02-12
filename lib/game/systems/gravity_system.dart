import 'package:flame/components.dart';
import '../components/ship.dart';
import '../components/planet.dart';

class GravitySystem extends Component {
  final Ship ship;
  final List<Planet> planets;

  GravitySystem({required this.ship, required this.planets});

  @override
  void update(double dt) {
    super.update(dt);

    for (final planet in planets) {
      final direction = planet.position - ship.position;
      final distance = direction.length;

      // Force = Mass / (Distance^2 + Softening)
      // Softening factor of 100 prevents infinite forces at close range.
      final forceMagnitude = (planet.mass) / (distance * distance + 100);

      if (distance > 0) {
        final force = direction.normalized() * forceMagnitude;
        ship.velocity.add(force * dt);
      }
    }
  }
}
