import 'package:dummy/controller/auth_controller.dart';
import 'package:dummy/view/widget/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController controller = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController(); // Date of Birth Controller
  bool isRegister = false; // Toggle between Login and Register

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define width factors based on screen width
    double widthFactor;
    if (screenWidth < 600) {
      widthFactor = 0.9; // Mobile
    } else if (screenWidth < 1024) {
      widthFactor = 0.6; // Tablet
    } else {
      widthFactor = 0.27; 
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/PNG/login_background.png",
              fit: BoxFit.cover,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/PNG/login.png",
                  height: screenHeight * 0.98,
                ),
              ),
              FractionallySizedBox(
                widthFactor: widthFactor,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0x475782C1),
                    shape: RoundedRectangleBorder(
                  
                      borderRadius: BorderRadius.circular(28.46),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Center(
                            child: Text(
                              isRegister ? 'Register' : 'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth < 600 ? 20 : 24,
                                fontFamily: 'Gilroy-Bold',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Gap(20),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Gilroy-Medium',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Gap(8),
                          CustomTextFormField(
                            controller: emailController,
                            hintText: 'username@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const Gap(20),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Gilroy-Medium',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Gap(8),
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const Gap(8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Gilroy-Medium',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Gap(20),
                          if (isRegister) ...[
                            Text(
                              'Date of Birth',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Gilroy-Medium',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Gap(8),
                            CustomTextFormField(
                              controller: dobController,
                              hintText: 'DD/MM/YYYY',
                            ),
                            const Gap(20),
                          ],
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF003465),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.11),
                                ),
                                fixedSize: const Size(250, 40),
                              ),
                              onPressed: () {
                                final email = emailController.text.trim();
                                final password =
                                    passwordController.text.trim();
                                final dob = dobController.text.trim();

                                if (email.isNotEmpty && password.isNotEmpty) {
                                  if (isRegister) {
                                    if (dob.isNotEmpty) {
                                      controller.register(
                                        email,
                                        password,
                                        dob,
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        "Please enter DOB",
                                      );
                                    }
                                  } else {
                                    controller.login(email, password);
                                  }
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Please fill in all fields",
                                  );
                                }
                              },
                              child: Text(
                                isRegister ? 'Register' : 'Sign in',
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          const Gap(16),
                          Center(
                            child: Text(
                              'or continue with',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Gilroy-Medium',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("assets/PNG/google.png"),
                              Image.asset("assets/PNG/githhub.png"),
                              Image.asset("assets/PNG/facebook.png"),
                            ],
                          ),
                          const Gap(12),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isRegister = !isRegister;
                                });
                              },
                              child: Text(
                                isRegister
                                    ? 'Already have an account? Login'
                                    : 'Don’t have an account yet? Register for free',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
