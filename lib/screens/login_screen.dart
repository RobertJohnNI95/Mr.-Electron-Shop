// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course_ecommerce_project/items/form_input.dart';
import 'package:flutter_course_ecommerce_project/items/regex.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';
import 'package:flutter_course_ecommerce_project/screens/main_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text("Sign up", style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                FormInput(
                  controller: emailController,
                  label: "Email",
                  keboardType: TextInputType.emailAddress,
                  validator: (value) {
                    // ignore: unnecessary_null_comparison
                    if (value!.isEmpty || value == null) {
                      return "Please, enter your email address.";
                    }
                    if (!isValidEmail(value)) {
                      return "Please, enter a valid email address.";
                    }
                    return null;
                  },
                ),
                FormInput(
                  controller: passwordController,
                  label: "Password",
                  keboardType: TextInputType.visiblePassword,
                  isPass: true,
                  validator: (value) {
                    // ignore: unnecessary_null_comparison
                    if (value!.isEmpty || value == null) {
                      return "Please, enter your password.";
                    }
                    if (value.length < 8) {
                      return "Please, enter a strong password (min. 8 characters)";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : WideButton(
                          label: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          function: () {
                            login(context);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        // Sign in user
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        User? user = userCredential.user;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed In Successfully!')),
        );

        Navigator.pushReplacementNamed(
          context,
          MainScreen.routeName,
          arguments: user?.uid, // pass only UID
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // ignore: avoid_print
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // ignore: avoid_print
          print('Wrong password provided for that user.');
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Email or Password!'),
            duration: Duration(seconds: 3),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
