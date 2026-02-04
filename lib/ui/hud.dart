import 'package:flutter/material.dart';
import '../game/orbit_trucker_game.dart';

class HudOverlay extends StatelessWidget {
  final OrbitTruckerGame game;

  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 100)),
      builder: (context, snapshot) {
        // Safe access in case ship isn't ready, though it should be if overlay is active
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Fuel: ${game.ship.fuel.toStringAsFixed(1)}",
                style: const TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
              ),
              Text(
                "Speed: ${game.ship.velocity.length.toStringAsFixed(1)}",
                style: const TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
              ),
              Text(
                "Cash: \$${game.ship.cash.toStringAsFixed(0)}",
                style: const TextStyle(color: Colors.greenAccent, fontSize: 20, decoration: TextDecoration.none),
              ),
            ],
          ),
        );
      },
    );
  }
}
