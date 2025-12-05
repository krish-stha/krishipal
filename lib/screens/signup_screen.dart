import 'package:flutter/material.dart';
import 'package:krishipal/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void signUp() {
    if (formKey.currentState?.validate() ?? false) {
      // TODO: sign‑up logic
      goToLogin();
    }
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFFF7F7F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.green, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0B7A32),
        elevation: 0,
        toolbarHeight: 90,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logowhite.png',
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: fullNameController,
                decoration: _fieldDecoration('Full Name'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Full Name cannot be empty'
                    : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: _fieldDecoration('Contact No'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Contact No cannot be empty'
                    : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: usernameController,
                decoration: _fieldDecoration('Username'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Username cannot be empty'
                    : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: _fieldDecoration('Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() => obscurePassword = !obscurePassword);
                    },
                  ),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Password cannot be empty' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: _fieldDecoration('Confirm Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(
                        () => obscureConfirmPassword = !obscureConfirmPassword,
                      );
                    },
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty)
                    return 'Confirm Password cannot be empty';
                  if (v != passwordController.text)
                    return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B7A32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: goToLogin,
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
