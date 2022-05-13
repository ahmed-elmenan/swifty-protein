import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
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
            home: SignIn(),
            routes: {
              '/sign-in': (context) => SignIn(),
            },
          );
        }
      },
    );
  }
}

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  LocalAuthentication auth = LocalAuthentication();

  bool? _canCheckBiometric;

  List<BiometricType>? _availableBiometrics;

  String authorized = "Not Authorized";

  Future _checkBiometric() async {
    bool? canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        _canCheckBiometric = canCheckBiometric;
      });
    }
  }

  Future _getAvailableBiometrics() async {
    List<BiometricType>? availableBiometric;
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  Future _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: "scan your finger to authenticate",
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: false));
    } on PlatformException catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        authorized = authenticated ? "Authorized" : "Failed";
        if (authenticated) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
        }
        print(authorized);
      });
    }
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometrics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () => _authenticate(), child: const Text("sign in"))),
    );
  }
}

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Text("Home"),
      ),
    );
  }
}
