// profile_screen.dart
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_course_ecommerce_project/items/wide_button.dart';
import 'package:flutter_course_ecommerce_project/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  Uint8List? imageBytes;
  bool isLoading = true;

  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user == null) return;

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();

      if (!mounted) return;

      final data = userDoc.data();
      if (data != null) {
        if (data["photoBase64"] != null) {
          imageBytes = base64Decode(data["photoBase64"]);
        }
        _usernameController.text = data["username"] ?? "";
        setState(() {
          userData = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final bytes = await pickedFile.readAsBytes();
    setState(() => imageBytes = bytes);
  }

  Future<void> _removeImage() async {
    setState(() => imageBytes = null);
    if (user == null) return;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update({"photoBase64": null});

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile picture removed")));
    } catch (e) {
      print("Error removing profile picture: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error removing profile picture")),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update({
            "username": _usernameController.text.trim(),
            "photoBase64": imageBytes != null
                ? base64Encode(imageBytes!)
                : null,
          });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } catch (e) {
      print("Error saving profile: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error updating profile")));
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Change Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              if (imageBytes != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text("Remove Photo"),
                  onTap: () {
                    Navigator.pop(context);
                    _removeImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(91, 187, 186, 186),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: WideButton(
                color: Colors.red,
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                function: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (route) => false,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: WideButton(
                color: Colors.blue,
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                function: _saveProfile,
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Profile picture (with options)
                    Center(
                      child: GestureDetector(
                        onTap: _showImageOptions,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: imageBytes != null
                              ? MemoryImage(imageBytes!)
                              : null,
                          child: imageBytes == null
                              ? const Icon(Icons.person, size: 80)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Username
                    const Text(
                      "Username:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: "Enter your username",
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    // Email (non-editable)
                    const Text(
                      "Email:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      userData?["email"] ?? user?.email ?? "Unknown",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
