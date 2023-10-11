// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gocar/showscar.dart';
import 'package:gocar/uploadcar.dart';
// import 'package:gocar/signup.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => ShowCarRentals()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo2.png'),
            // Icon(
            //   Icons.car_rental,
            //   size: 120,
            //   color: Colors.white,
            // ),
            // Text(
            //   'logo'.tr(),
            //   style: TextStyle(
            //     fontSize: 90,
            //     color: Colors.white,
            //   ),
            // )
          ],
        ),
      ),
    ));
  }
}
