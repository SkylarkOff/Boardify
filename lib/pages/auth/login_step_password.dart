import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../components/kontai_log.dart';
import '../../providers/user_provider.dart';
import '../../routes/route_names.dart';

class LoginStepPassword extends StatefulWidget {
  final String email;

  const LoginStepPassword({super.key, required this.email});

  @override
  State<LoginStepPassword> createState() => _LoginStepPasswordState();
}

class _LoginStepPasswordState extends State<LoginStepPassword> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final success = await userProvider.login(
      widget.email,
      _passwordController.text,
    );

    if (success) {
      // Navigasi berdasarkan role
      switch (userProvider.role) {
        case 'mahasiswa':
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.mainMahasiswa,
            (Route<dynamic> route) => false,
          );

          break;
        case 'dosen':
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.mainDosen,
            (Route<dynamic> route) => false,
          );

          break;
        default:
          setState(() => _error = 'Peran pengguna tidak dikenali');
      }
    } else {
      setState(() => _error = 'Password salah');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              /// KOTAK LOGIN
              KontaiLog(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Welcome Back!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter the password associated with',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Text(
                            'your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.email,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Fitur belum tersedia'),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        errorText: _error,
                        filled: true,
                        fillColor: Colors.white,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[300],
                          ),
                          onPressed:
                              () =>
                                  setState(() => _obscureText = !_obscureText),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      label: 'Login',
                      onPressed: _isLoading ? null : _login,
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 22, 107, 182),
                      fontSize: 16,
                      borderRadius: 12,
                      icon:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color.fromARGB(255, 22, 107, 182),
                                ),
                              )
                              : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
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
