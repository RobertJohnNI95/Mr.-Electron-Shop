import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course_ecommerce_project/items/form_input.dart';
import 'package:flutter_course_ecommerce_project/items/regex.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter your email.")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return; // screen might have been popped while waiting

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent!")),
      );

      Navigator.pop(context); // go back to login after sending
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            const Text(
              "Enter your email and we'll send you a reset link.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
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
            /*
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            */
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Go Back.", style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Container(
                    margin: EdgeInsets.all(10),
                    child: WideButton(
                      icon: Icon(Icons.mail, color: Colors.white),
                      label: Text(
                        "Send Reset Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      function: () {
                        if (formKey.currentState!.validate()) {
                          resetPassword();
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
