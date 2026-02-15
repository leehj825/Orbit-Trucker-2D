import 'package:flutter/material.dart';
import '../game/orbit_trucker_game.dart';

class HudOverlay extends StatelessWidget {
  final OrbitTruckerGame game;

  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: game.ship.fuel,
      builder: (context, fuel, child) {
        return ValueListenableBuilder<double>(
          valueListenable: game.ship.cash,
          builder: (context, cash, _) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Fuel: ${fuel.toStringAsFixed(1)}",
                    style: const TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
                  ),
                  Text(
                    "Speed: ${game.ship.velocity.length.toStringAsFixed(1)}",
                    style: const TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
                  ),
                  Text(
                    "Cash: \$${cash.toStringAsFixed(0)}",
                    style: const TextStyle(color: Colors.greenAccent, fontSize: 20, decoration: TextDecoration.none),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
