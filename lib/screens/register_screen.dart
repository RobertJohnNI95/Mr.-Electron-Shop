// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course_ecommerce_project/items/form_input.dart';
import 'package:flutter_course_ecommerce_project/items/regex.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';
import 'package:flutter_course_ecommerce_project/screens/login_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/main_screen.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: const Text("Log in", style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),

              // Profile Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? const Icon(Icons.add_a_photo, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 30),

              FormInput(
                controller: usernameController,
                label: "Username",
                keboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please, enter your name.";
                  }
                  if (value.length < 6) {
                    return "Please, enter a valid name";
                  }
                  return null;
                },
              ),
              FormInput(
                controller: emailController,
                label: "Email",
                keboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
                    return "Please, enter your password.";
                  }
                  if (value.length < 8) {
                    return "Please, enter a strong password (min. 8 characters)";
                  }
                  return null;
                },
              ),
              FormInput(
                controller: passwordConfirmController,
                label: "Confirm Password",
                keboardType: TextInputType.visiblePassword,
                isPass: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : WideButton(
                        icon: Icon(Icons.person, color: Colors.white),
                        label: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        function: () {
                          signup();
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signup() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        print("Starting signup...");

        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          print("Got user: ${user.uid}");

          // ✅ Convert image to Base64
          String? photoBase64;
          if (_selectedImage != null) {
            final bytes = await _selectedImage!.readAsBytes();
            photoBase64 = base64Encode(bytes);
          }

          // 2️⃣ Save Firestore user profile
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({
                "username": usernameController.text.trim(),
                "email": emailController.text.trim(),
                "photoBase64": photoBase64, // <-- stored as text
                "createdAt": FieldValue.serverTimestamp(),
              });
          print("Firestore write done");

          // 3️⃣ Update FirebaseAuth display name
          await user.updateDisplayName(usernameController.text.trim());
          print("Display name updated");
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Created Successfully!')),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.routeName,
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Weak Password!')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account Already Exists!')),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Creation Failed!')),
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}
