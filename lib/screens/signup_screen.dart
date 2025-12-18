import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void signUp() {
    if (formKey.currentState!.validate()) {
      goToLogin();
    }
  }

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF7F7F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),

      /// This ensures status bar is WHITE
      extendBodyBehindAppBar: true,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ---------------- WHITE SAFE TOP AREA ----------------
            SafeArea(
              bottom: false,
              child: Container(
                height: 0, // Just to push content below safe area
                color: Colors.white, // White status bar background
              ),
            ),

            /// ---------------- GREEN 3D CURVED HEADER ----------------
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0B7A32),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logowhite.png", height: 70),
                  const SizedBox(height: 10),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ---------------- FORM CARD ----------------
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 6),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: inputStyle("Full Name"),
                      validator: (v) =>
                          v!.isEmpty ? "Full Name cannot be empty" : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      decoration: inputStyle("Contact Number"),
                      validator: (v) =>
                          v!.isEmpty ? "Contact Number cannot be empty" : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: usernameController,
                      decoration: inputStyle("Username"),
                      validator: (v) =>
                          v!.isEmpty ? "Username cannot be empty" : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: inputStyle("Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                        ),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? "Password cannot be empty" : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: hideConfirmPassword,
                      decoration: inputStyle("Confirm Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            hideConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                              () => hideConfirmPassword = !hideConfirmPassword,
                            );
                          },
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) return "Confirm Password is required";
                        if (v != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B7A32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    TextButton(
                      onPressed: goToLogin,
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
