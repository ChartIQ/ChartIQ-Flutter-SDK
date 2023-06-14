import 'package:example/routes/screen_names.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: context.assets.splash.svg()),
    );
  }

  _goMain() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(ScreenNames.main);
    });
  }
}
