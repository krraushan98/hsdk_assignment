import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/home.dart';
import '../Services/auth_provider.dart' as local_auth;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<local_auth.AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/019/813/068/non_2x/modern-medical-and-health-care-center-ayurvedic-logo-design-illustration-free-vector.jpg",
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            icon: Icon(Icons.email_outlined, color: Colors.greenAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter an email";
                            }
                            // Email validation regex
                            final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Password",
                            icon: const Icon(Icons.lock_outlined, color: Colors.greenAccent),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a password";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 characters";
                            }
                            // Password must contain at least 1 number & 1 special character
                            final passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])');
                            if (!passwordRegex.hasMatch(value)) {
                              return "Include at least 1 number & 1 special character";
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Display Error Message
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red, fontSize: 14),
                          ),

                        const SizedBox(height: 10),

                        // Sign In Button
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_globalKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                      _errorMessage = '';
                                    });

                                    try {
                                      await authProvider.signInWithEmail(
                                          _emailController.text, _passwordController.text);

                                      if (authProvider.user != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const HomePage()),
                                        );
                                      }
                                    } catch (e) {
                                      setState(() {
                                        _errorMessage = "Login failed. Please try again.";
                                      });
                                    }

                                    setState(() => _isLoading = false);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 63, 140, 203),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 13),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Sign in", style: TextStyle(fontSize: 17)),
                        ),

                        const SizedBox(height: 20),

                        // OR Divider
                        const Row(
                          children: [
                            Expanded(child: Divider(color: Color.fromARGB(255, 212, 211, 211))),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(color: Color.fromARGB(255, 133, 133, 133)),
                              ),
                            ),
                            Expanded(child: Divider(color: Color.fromARGB(255, 212, 211, 211))),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Google Sign-In Button
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  setState(() => _isLoading = true);
                                  await authProvider.signInWithGoogle();

                                  if (authProvider.user != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  } else {
                                    setState(() {
                                      _errorMessage = "Google sign-in failed. Try again.";
                                    });
                                  }
                                  setState(() => _isLoading = false);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            side: const BorderSide(color: Colors.black, width: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(
                                  "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                                ),
                                height: 45,
                                width: 45,
                              ),
                              SizedBox(width: 5),
                              Text("Continue with Google", style: TextStyle(color: Colors.black, fontSize: 17)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Sign Up Redirect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("New to Adhicine?"),
                            TextButton(
                              onPressed: () {
                                // Navigate to sign-up page
                              },
                              child: const Text("Sign Up"),
                            )
                          ],
                        ),

                        const SizedBox(height: 10), // Extra spacing at bottom
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
