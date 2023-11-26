import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobile_tp/themes_and_componants/responsive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import '../themes_and_componants/noty_text_Style.dart';
import 'home_screen.dart';

class SplahsScreen extends StatefulWidget {
  const SplahsScreen({Key? key}) : super(key: key);

  @override
  State<SplahsScreen> createState() => _SplahsScreenState();
}

class _SplahsScreenState extends State<SplahsScreen> {
  @override
  Widget build(BuildContext context) {
    callInitWidthHeight(context);
    return AnimatedSplashScreen(
      splash: SplashScreenContent(),
      splashIconSize: 400,
      nextScreen: HomeScreen(),
      duration: 2200,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
Widget SplashScreenContent(){
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/imgs/noteB.png"),width: getNewWidth(220),height: getNewHeight(220),color:nColor),
              SizedBox(height: getNewHeight(15),),
              Text("NOTY",style: notyTextStyle
              )
            ],
          ),
        ),
      ),
    ),
  );
}

callInitWidthHeight(context)async{
  await initWidthHeight(context);
}