import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/orbit_trucker_game.dart';
import 'ui/hud.dart';
import 'ui/market_menu.dart';

void main() {
  runApp(const MaterialApp(home: OrbitTruckerApp()));
}

class OrbitTruckerApp extends StatefulWidget {
  const OrbitTruckerApp({super.key});

  @override
  State<OrbitTruckerApp> createState() => _OrbitTruckerAppState();
}

class _OrbitTruckerAppState extends State<OrbitTruckerApp> {
  late OrbitTruckerGame _game;

  @override
  void initState() {
    super.initState();
    _game = OrbitTruckerGame(onDocked: _onDocked);
  }

  void _onDocked() {
    _game.overlays.add('MarketMenu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: _game,
            overlayBuilderMap: {
              'HUD': (context, OrbitTruckerGame game) => HudOverlay(game: game),
              'MarketMenu': (context, OrbitTruckerGame game) => MarketMenu(game: game),
            },
            initialActiveOverlays: const ['HUD'],
          ),

          // On-screen Controls
          Positioned(
            bottom: 40,
            left: 20,
            child: Row(
              children: [
                _ControlBtn(
                  icon: Icons.rotate_left,
                  onDown: () => _game.rotateLeftStart(),
                  onUp: () => _game.rotateStop()
                ),
                const SizedBox(width: 20),
                _ControlBtn(
                  icon: Icons.rotate_right,
                  onDown: () => _game.rotateRightStart(),
                  onUp: () => _game.rotateStop()
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 40,
            right: 20,
            child: _ControlBtn(
              icon: Icons.local_fire_department,
              label: "THRUST",
              color: Colors.redAccent,
              onDown: () => _game.startThrust(),
              onUp: () => _game.stopThrust()
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlBtn extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onDown;
  final VoidCallback onUp;
  final Color color;

  const _ControlBtn({
    required this.icon,
    this.label,
    required this.onDown,
    required this.onUp,
    this.color = Colors.white54,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onDown(),
      onTapUp: (_) => onUp(),
      onTapCancel: () => onUp(),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: label != null
          ? Column(children: [Icon(icon, size: 30), Text(label!, style: const TextStyle(fontWeight: FontWeight.bold))])
          : Icon(icon, size: 40),
      ),
    );
  }
}
