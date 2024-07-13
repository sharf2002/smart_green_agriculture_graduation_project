/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../on_boarding_screen/persentation/view/widgets/on_boarding_body.dart';


class SplashScreenBody extends StatefulWidget {
  SplashScreenBody({Key? key}) : super(key: key);

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState(){
    Future.delayed(
      Duration(seconds: 3), () {
      //if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OnBoardingBody();
            },
          ),
        );
      //}
     */
/* else {
        // Navigator to home screen
      }*//*

    },
    );
    super.initState();
  }


  Widget build(BuildContext context) {
    double widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    double heightScreen = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Smart Agricultural Green House',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/core/utiles/cache_helper.dart';
import '../../../../create_user/persentation/view_model/user_data/user_data_cubit.dart';
import '../../../../login_screen/persentation/view_model/sign_in_with_email_cubit.dart';
import '../../../../on_boarding_screen/persentation/view/widgets/on_boarding_body.dart';


class SplashScreenBody extends StatefulWidget {
  @override
  _SplashScreenBodyState createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )
      ..addStatusListener(
            (status) async {
          if (status == AnimationStatus.completed) {
            //todo check if login or not here and Navigation based on if login or not

            Future.delayed(
              Duration(seconds: 3), () async {
              if (FirebaseAuth.instance.currentUser == null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OnBoardingBody();
                    },
                  ),
                );
              }
              else if (FirebaseAuth.instance.currentUser != null){
                final uId = FirebaseAuth.instance.currentUser!.uid;
                final myUserTypeSignUp = await FirebaseFirestore.instance
                    .collection('users')
                    .doc('user $uId')
                    .get();
                final myUserTypeSignUpData = myUserTypeSignUp.data();
                final typeSignUp = myUserTypeSignUpData?['typeSignUp'];

                if (typeSignUp == "TypeSignUP.email"){
                  String email = await CacheHelper.getData(key: "email");
                  String password = await CacheHelper.getData(key: "password");

                  context
                      .read<SignInWithEmailCubit>()
                      .signInWithEmailPassword(
                      email: email,
                      password: password,
                      context: context);
                }

                else if (typeSignUp == "TypeSignUP.google"){
                  context.read<UserDataCubit>().googleData(context: context);
                }

                print("ashraf :::");
                print(FirebaseAuth.instance.currentUser?.uid);

                // CacheHelper.saveData(key: "id", value: "44");
                // String id =await CacheHelper.getData(key: "id");
                // CacheHelper.removeData(key: "id");

              }
            },
            );


            Timer(
              Duration(milliseconds: 200),
                  () {
                _controller.reset();
              },
            );
          }
        },


      );
    animation1 = Tween<double>(begin: 30, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(Duration(seconds: 4), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });



  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    double _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.teal, //todo use any background
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize * 0.95),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ), //todo use any text style
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Smart Agricultural Green House', //todo change name
                        speed: Duration(milliseconds: 130),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: false,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize,
                width: _width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(50),
                  shape: BoxShape.circle,
                ),

                //todo change logo
                child: Image.asset(
                  "assets/images/on_boarding/logo1.png",
                  //todo use any image as logo
                  height: _height * 0.6,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class PageTransition2 extends PageRouteBuilder {
  final Widget page;

  PageTransition2(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}


