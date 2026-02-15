import 'package:flutter/material.dart';
import '../game/orbit_trucker_game.dart';

class MarketMenu extends StatelessWidget {
  final OrbitTruckerGame game;

  const MarketMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "MARKET",
                style: TextStyle(color: Colors.white, fontSize: 24, decoration: TextDecoration.none)
              ),
              const SizedBox(height: 20),

              ValueListenableBuilder<double>(
                valueListenable: game.ship.cash,
                builder: (context, cash, _) {
                  return Text(
                    "Cash: \$${cash.toStringAsFixed(0)}",
                    style: const TextStyle(color: Colors.white, fontSize: 18, decoration: TextDecoration.none)
                  );
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   game.ship.fuel.value = 100.0;
                   // game.ship.cash.value -= 10;
                },
                child: const Text("Refuel (Free)")
              ),
              const SizedBox(height: 10),
               ElevatedButton(
                onPressed: () {
                   game.ship.cash.value += 50;
                },
                child: const Text("Sell Cargo (+\$50)")
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  game.undock();
                  game.overlays.remove('MarketMenu');
                },
                child: const Text("LAUNCH", style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
