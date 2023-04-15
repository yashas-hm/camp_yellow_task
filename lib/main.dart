 import 'package:campyellow/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Resize(
      builder: () => MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
      allowtextScaling: false,
      size: const Size(390, 844),
    );
  }
}
