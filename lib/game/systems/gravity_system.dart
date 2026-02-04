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

      // Minimal distance to avoid infinity
      if (distance > 10) {
        // Force = Mass / Distance^2
        // We can tune this constant G. Let's assume G=10 for stronger effect or tune planet mass.
        // Prompt says: Force = (PlanetMass / Distance²)
        final forceMagnitude = (planet.mass) / (distance * distance);
        final force = direction.normalized() * forceMagnitude;
        ship.velocity.add(force * dt);
      }
    }
  }
}
