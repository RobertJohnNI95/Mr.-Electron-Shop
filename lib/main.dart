import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_course_ecommerce_project/screens/login_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/main_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/password_reset_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: unused_local_variable
  final bgImage = const AssetImage('assets/bg1.jpg');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static final AssetImage _bgImage = const AssetImage('assets/bg1.jpg');

  @override
  Widget build(BuildContext context) {
    precacheImage(_bgImage, context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
        MainScreen.routeName: (context) => MainScreen(),
      },
      builder: (context, child) {
        // Wrap all screens in a shared background
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: _bgImage, fit: BoxFit.cover),
          ),
          child: child, // all screens rendered here
        );
      },
    );
  }
}
