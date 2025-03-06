import 'package:dummy/view/home_view.dart';
import 'package:dummy/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.ref();

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginView());
    } else {
      Get.offAll(() => const HomeView());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF003465),
        colorText: Colors.white,
      );
    }
  }

  Future<void> register(String email, String password, String dob) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String registrationTime = DateTime.now().toIso8601String();

        await database.child("users").child(userCredential.user!.uid).set({
          "email": email,
          "dob": dob,
          "registrationTime": registrationTime,
        });
      }
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF003465),
        colorText: Colors.white,
      );
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
