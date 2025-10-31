import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuth();
  }

  Future<void> _navigateBasedOnAuth() async {
    final prefs = await SharedPrefsHelper.getInstance();
    final token = prefs.getValue<String>('token');

    await Future.delayed(const Duration(seconds: 2)); // simulate splash delay

    if (token != null && token.isNotEmpty) {
      context.router.replaceAll([const MainRoute()]);
    } else {
      context.router.replaceAll([ SignInRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ مهم جداً
      body: Center(
        child: Image.asset(Assets.images.splashBackground.path,
        width: double.infinity,
        fit: BoxFit.cover,),
      ),
    );
  }
}
