import 'package:flutter/material.dart';
import 'package:msgr_app/login_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({Key? key}) : super(key: key);

  @override
  _SplashpageState createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
          duration: 2000,
          splash: Image.asset("images/spashscreen.PNG",
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
          ),
          splashIconSize: double.maxFinite,
          nextScreen: const Login_page(),
          splashTransition: SplashTransition.scaleTransition,
          //pageTransitionType: PageTransitionType.scale,
          backgroundColor: Color(0XFFeb6e0e),
      )
    );
  }
}
