import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/customInput.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());

  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo/Icon
              const Icon(Icons.check_circle, size: 80, color: Color(0xFF6D5DF6)),
              const SizedBox(height: 16),

              // Title
              const Text(
                "Welcome back!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Email Input
              CustomInput(
                hint: "Email Address",
                icon: Icons.email,
                obscureText: false,
                controller: controller.emailController,
              ),
              const SizedBox(height: 16),

              // Password Input (obscure toggle)
              Obx(() => CustomInput(
                hint: "Password",
                icon: Icons.lock,
                obscureText: controller.isPasswordHidden.value,
                controller: controller.passwordController,
                suffix: IconButton(
                  icon: Icon(controller.isPasswordHidden.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: controller.togglePasswordVisibility,
                ),
              )),
              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Color(0xFF6D5DF6)),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Log in Button
              Obx(() => CustomButton(
                text: controller.isLoading.value ? "Loading..." : "Log in",
                onPressed: controller.isLoading.value ? null : controller.login,
                child: controller.isLoading.value
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                )
                    : null,
              )),
              const SizedBox(height: 24),

              const Text("or log in with"),
              const SizedBox(height: 16),

              // Social Icons
              const SocialButtons(),
              const SizedBox(height: 24),

              // Bottom Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/sign-up'); // Make sure the route is defined
                    },
                    child: const Text(
                      "Get started!",
                      style: TextStyle(
                        color: Color(0xFF6D5DF6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
