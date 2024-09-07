import 'dart:async';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/presentation/home/home_page.dart';
import 'package:aquacall/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isLogged = preferences.getBool('isLogged');
    if (isLogged == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => AppCubit(),
            child: const HomePage(),
          ),
        ),
      );
    } else {
      await preferences.setBool('isLogged', true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => AppCubit(),
            child: const LoginPage(),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 3500), () {
      checkLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(AssetConstants.splashAnimation,
            height: MediaQuery.of(context).size.height * 0.15),
      ),
    );
  }
}
