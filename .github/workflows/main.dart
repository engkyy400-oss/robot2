import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() => runApp(const MaterialApp(home: Home()));

@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Robot()));
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Aktifkan Robot'),
          onPressed: () async {
            if (!await FlutterOverlayWindow.isPermissionGranted()) {
              await FlutterOverlayWindow.requestPermission();
              return;
            }
            await FlutterOverlayWindow.showOverlay(
              height: 300,
              width: 300,
              enableDrag: true,
              overlayTitle: 'Robot Chatbot',
              overlayContent: 'Robot aktif',
              alignment: OverlayAlignment.centerLeft,
            );
          },
        ),
      ),
    );
  }
}

class Robot extends StatefulWidget {
  const Robot({super.key});
  @override
  State<Robot> createState() => _RobotState();
}

class _RobotState extends State<Robot> with SingleTickerProviderStateMixin {
  late final AnimationController c = AnimationController(
      vsync: this, duration: const Duration(seconds: 1))
    ..repeat(reverse: true);

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: c,
          builder: (_, __) => Transform.translate(
            offset: Offset(0, -12 * c.value),
            child: const Text('🤖', style: TextStyle(fontSize: 100)),
          ),
        ),
      ),
    );
  }
}
