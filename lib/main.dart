import 'package:flutter/material.dart';
import 'package:swifty_protein/splash_screen.dart';

void main() {
  runApp(const SwiftyProtein());
}

class SwiftyProtein extends StatelessWidget {
  const SwiftyProtein({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: SplashScreen());
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'roboto_regular'),
            home: const SignIn(),
            routes: {
              '/sign-in': (context) => const SignIn(),
            },
          );
        }
      },
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("sign in")),
    );
  }
}
