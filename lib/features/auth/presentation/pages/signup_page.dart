// features/auth/presentation/pages/signup_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krishipal/features/auth/presentation/pages/login_page.dart';
import 'package:krishipal/features/auth/presentation/providers/auth_provider.dart';
import 'package:krishipal/features/auth/presentation/state/auth_state.dart';
import 'package:krishipal/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:krishipal/core/utils/snack_bar_utils.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isSubmitting = false;

  String selectedCountryCode = '+977';

  final countryCodes = [
    {'code': '+977', 'name': 'Nepal', 'flag': '🇳🇵'},
    {'code': '+91', 'name': 'India', 'flag': '🇮🇳'},
    {'code': '+1', 'name': 'USA', 'flag': '🇺🇸'},
    {'code': '+44', 'name': 'UK', 'flag': '🇬🇧'},
  ];

  @override
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    addressController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    try {
      final phoneNumber = contactController.text.trim().replaceAll(' ', '');
      final email = usernameController.text.trim().toLowerCase();

      await ref
          .read(authViewModelProvider.notifier)
          .register(
            fullName: fullNameController.text.trim(),
            email: email,
            username: email,
            password: passwordController.text,
            phoneNumber: phoneNumber,
            countryCode: selectedCountryCode,
            address: addressController.text.trim(),
          );
    } catch (e) {
      SnackbarUtils.showError(context, 'Registration failed');
      setState(() => isSubmitting = false);
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
    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.error &&
          previous?.status != AuthStatus.error) {
        SnackbarUtils.showError(context, next.errorMessage ?? 'Error');
        setState(() => isSubmitting = false);
      }

      if (next.status == AuthStatus.registered &&
          previous?.status != AuthStatus.registered) {
        SnackbarUtils.showSuccess(
          context,
          "Registration Successful!\nYou can now login with your credentials.",
        );

        setState(() => isSubmitting = false);

        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Container(height: 0, color: Colors.white),
            ),

            // Green curved header
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
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: inputStyle("Full Name"),
                      validator: (v) => v!.trim().isEmpty
                          ? "Full Name cannot be empty"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Country code + phone
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<String>(
                            value: selectedCountryCode,
                            decoration: inputStyle("Code"),
                            items: countryCodes.map((country) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: Row(
                                  children: [
                                    Text(
                                      country['flag']!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      country['code']!,
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: isSubmitting
                                ? null
                                : (value) {
                                    setState(
                                      () => selectedCountryCode = value!,
                                    );
                                  },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: contactController,
                            keyboardType: TextInputType.phone,
                            decoration: inputStyle("Contact Number"),
                            validator: (v) => v!.isEmpty
                                ? "Contact Number cannot be empty"
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address field
                    TextFormField(
                      controller: addressController,
                      decoration: inputStyle("Address"),
                      validator: (v) =>
                          v!.trim().isEmpty ? "Address cannot be empty" : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: usernameController,
                      decoration: inputStyle("Email"),
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return "Email cannot be empty";
                        if (!v.contains("@")) return "Enter a valid email";
                        return null;
                      },
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
                          onPressed: () =>
                              setState(() => hidePassword = !hidePassword),
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
                          onPressed: () => setState(
                            () => hideConfirmPassword = !hideConfirmPassword,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) return "Confirm Password is required";
                        if (v != passwordController.text)
                          return "Passwords do not match";
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            (isSubmitting ||
                                authState.status == AuthStatus.loading)
                            ? null
                            : handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B7A32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        child:
                            (isSubmitting ||
                                authState.status == AuthStatus.loading)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
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
                      onPressed: isSubmitting
                          ? null
                          : () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            ),
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
