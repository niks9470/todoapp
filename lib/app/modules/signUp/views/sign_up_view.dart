import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/customInput.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpView({super.key});

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
              const Icon(Icons.person_add_alt, size: 80, color: Color(0xFF6D5DF6)),
              const SizedBox(height: 16),

              const Text(
                "Create Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Email
              CustomInput(
                hint: "Email Address",
                icon: Icons.email,
                controller: controller.emailController,
              ),
              const SizedBox(height: 16),

              // Password
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
              const SizedBox(height: 24),

              // Sign Up Button
              Obx(() => CustomButton(
                text: controller.isLoading.value ? "Loading..." : "Sign Up",
                onPressed: controller.isLoading.value ? null : controller.signUp,
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

              const Text("or sign up with"),
              const SizedBox(height: 16),

              const SocialButtons(),
              const SizedBox(height: 24),

              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Or Get.toNamed('/signin') if using named routes
                    },
                    child: const Text(
                      "Log in!",
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
