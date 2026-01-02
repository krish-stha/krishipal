import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krishipal/features/auth/presentation/pages/login_page.dart';

// Import your ViewModels and State (adjust the paths)
import 'package:krishipal/features/auth/presentation/state/auth_state.dart';
import 'package:krishipal/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:krishipal/features/batch/presentation/state/batch_state.dart';
import 'package:krishipal/features/batch/presentation/view_model/batch_viewmodel.dart';
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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  // Dropdown state
  String selectedCountryCode = '+977';
  String? selectedCity;

  final countryCodes = [
    {'code': '+977', 'name': 'Nepal', 'flag': '🇳🇵'},
    {'code': '+91', 'name': 'India', 'flag': '🇮🇳'},
    {'code': '+1', 'name': 'USA', 'flag': '🇺🇸'},
    {'code': '+44', 'name': 'UK', 'flag': '🇬🇧'},
  ];

  @override
  void initState() {
    super.initState();
    // Fetch batches for city dropdown
    Future.microtask(() {
      ref.read(batchViewmodelProvider.notifier).getAllBatches();
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleSignup() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authViewModelProvider.notifier)
          .register(
            fullName: fullNameController.text,
            email: usernameController.text.trim(),
            username: usernameController.text.trim(),
            password: passwordController.text,
            phoneNumber: '$selectedCountryCode${contactController.text}',
            batchId: selectedCity,
          );
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
    final batchState = ref.watch(batchViewmodelProvider);
    final authState = ref.watch(authViewModelProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        SnackbarUtils.showError(
          context,
          next.errorMessage ?? 'Registration failed',
        );
      } else if (next.status == AuthStatus.registered) {
        SnackbarUtils.showSuccess(
          context,
          next.errorMessage ?? 'Registration Successful',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
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
                      validator: (v) =>
                          v!.isEmpty ? "Full Name cannot be empty" : null,
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
                            onChanged: (value) {
                              setState(() => selectedCountryCode = value!);
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

                    // City dropdown
                    DropdownButtonFormField<String>(
                      value: selectedCity,
                      decoration: inputStyle(
                        batchState.status == BatchStatus.loading
                            ? 'Loading Cities...' // dynamic label text
                            : 'Choose your City',
                      ),
                      items: batchState.batches.map((batch) {
                        return DropdownMenuItem<String>(
                          value: batch.batchId,
                          child: Text(batch.batchName),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedCity = value),
                      validator: (v) =>
                          v == null ? "Please select a city" : null,
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
                        onPressed: handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B7A32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        child: authState.status == AuthStatus.loading
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
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
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
