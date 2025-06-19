import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/custom_button.dart';
import '../../../components/kontai_log.dart';
import '../../../services/auth_service.dart';
import '../../../routes/route_names.dart';
import 'login_step_password.dart';

class LoginStepEmail extends StatefulWidget {
  const LoginStepEmail({super.key});

  @override
  State<LoginStepEmail> createState() => _LoginStepEmailState();
}

class _LoginStepEmailState extends State<LoginStepEmail> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _checkEmail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final isRegistered = await AuthService.checkEmail(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      if (isRegistered) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => LoginStepPassword(email: _emailController.text.trim()),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = e.toString().replaceAll('Exception: ', ''));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              /// KOTAK LOGIN
              KontaiLog(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // default kiri
                  children: [
                    // Bagian TENGAH
                    Center(
                      child: Column(
                        children: const [
                          Text(
                            'Sign in to Boardify',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Welcome back! Please sign in to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),

                    Center(
                      child: CustomButton(
                        label: 'Continue with Google',
                        icon: SvgPicture.asset(
                          'lib/assets/icons/google.svg',
                          height: 24,
                        ),
                        fontSize: 18,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          // TODO: Handle Google Sign-In
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Center(
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Bagian FORM (kiri)
                    const Text(
                      'Email address or username',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(153, 0, 0, 0),
                        ),
                        errorText: _error,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomButton(
                      label: _isLoading ? '' : 'Continue',
                      onPressed: _isLoading ? null : _checkEmail,
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 22, 107, 182),
                      fullWidth: true,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      icon:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : null,
                    ),
                  ],
                ),
              ),

              /// BAGIAN BAWAH (luar kontainer)
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.register);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Secured by Clerk',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
