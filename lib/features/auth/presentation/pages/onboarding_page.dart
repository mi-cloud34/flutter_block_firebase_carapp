import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(3.0, 0.0); // Sağdan başlama
            const end = Offset.zero; // Normal pozisyon
            const curve = Curves.easeInOut; // Yumuşak geçiş

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C2B34),
      body: Stack(
        children: [
  Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/onboarding.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium cars. \nEnjoy the luxury',
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Premium and prestige car daily rental. \nExperience the thrill at a lower price',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 320,
                      height: 54,
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(
                context,
                LoginPage.route(),
                (route) => false,
              );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white
                          ),
                          child: Text(
                            'Let\'s Go',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
       Align(
      alignment: Alignment.center,
      child: SpinKitCircle(
              color: Colors.white,
              size: 80.0,
            ),
    ),
        ],
      
      ),
    );
  }
}