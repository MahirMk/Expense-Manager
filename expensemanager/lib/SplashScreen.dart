import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  start() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder:(context)=>HomePage())
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000),(){
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Lottie.network(
        //     'https://assets10.lottiefiles.com/packages/lf20_njhsezni.json'
        // ),
        child: Image.asset("img/Expense Manager Icon.png",width: 300,),
      ),
    );
  }
}
