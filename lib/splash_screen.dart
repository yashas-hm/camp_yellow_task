import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController splashController;
  late final AnimationController loginController;
  late final AnimatedContainer fadeController;
  bool done = false;

  @override
  void initState() {
    splashController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    loginController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
        milliseconds: 300,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    Future.delayed(
        const Duration(
          seconds: 1,
          milliseconds: 300,
        ), () {
      splashController.forward();
    });

    splashController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        loginController.forward();
      }
    });

    loginController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          done = true;
        });
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 1,
                end: 6,
              ).animate(
                CurvedAnimation(
                  parent: splashController,
                  curve: Curves.easeInOutCirc,
                ),
              ),
              child: Container(
                height: screenSize.width / 2.5,
                width: screenSize.width / 2.5,
                decoration: const BoxDecoration(
                  color: Color(0xffffe600),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 1,
                end: 0,
              ).animate(
                CurvedAnimation(
                  parent: splashController,
                  curve: Curves.easeIn,
                ),
              ),
              child: Text(
                'Camp Yellow',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1.5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: loginController,
                curve: Curves.easeIn,
              ),
            ),
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 13.sp),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(done ? 0.0 : 40.sp),
                  bottomRight: Radius.circular(done ? 0.0 : 40.sp),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenSize.height / 8,
                  ),
                  Text(
                    'Camp Yellow',
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'Practice. Learn. Compete.',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 60.sp,
                  ),
                  SvgPicture.asset(
                    'assets/img.svg',
                    width: screenSize.width,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.sp),
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        decoration: InputDecoration(
                          counterText: null,
                          counter: null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                            borderSide: BorderSide(
                              width: 1.sp,
                              color: Colors.black,
                            ),
                          ),
                          hintText: 'Search events by area.',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                          ),
                          suffixIcon: Icon(
                            Icons.search_rounded,
                            size: 20.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: screenSize.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}