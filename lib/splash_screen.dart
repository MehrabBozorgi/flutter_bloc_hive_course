import 'package:flutter/material.dart';
import 'package:flutter_bloc_hive_project/todo_feature/screens/show_todo_screen.dart';
import 'package:flutter_bloc_hive_project/tools/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  goHome() async {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = _controller.drive(Tween(begin: 0.0, end: 1.0));
    _controller.forward().then(
          (value) => Navigator.pushReplacementNamed(context, ShowTodoScreen.screenId),
        );
  }

  @override
  void initState() {
    super.initState();
    goHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Text(
            'اپلیکیشن انجام وظایف',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
