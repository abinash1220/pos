import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/views/auth_view/login_view.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/views/home_view/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    redirectToNext();
  }

 redirectToNext() async {
    final prefs = await SharedPreferences.getInstance();

    var auth_token = prefs.getString("auth_token");
    print("Auth token ");
    print(auth_token);

    if (auth_token != null && auth_token != "null") {
      await Future.delayed(Duration(seconds: 2));
      Get.offAll(HomePageWithNavigation());
    } else {
      await Future.delayed(Duration(seconds: 2));
      Get.offAll(LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/icons/pos_logo.png"),
      ),
    );
  }
}
