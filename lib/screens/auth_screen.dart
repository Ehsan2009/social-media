import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/components/custom_text_field.dart';
import 'package:social_media/components/user_image_picker.dart';
import 'package:social_media/services/auth_services.dart';
import 'package:social_media/services/user_services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  var enteredName = '';
  var enteredEmail = '';
  var enteredPassword = '';
  File? _selectedImage;
  var isLogin = false;
  var isAuthenticating = false;
  var passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    bool validate = formKey.currentState!.validate();

    if (!validate) {
      return;
    }

    formKey.currentState!.save();

    try {
      setState(() {
        isAuthenticating = true;
      });

      final authServices = AuthServices();
      final userServices = UserServices();

      if (isLogin) {
        await authServices.signIn(
          enteredEmail.trim(),
          enteredPassword.trim(),
        );
      } else {
        final profileUrl =
            await userServices.getUserProfileUrl(_selectedImage!, 'profiles');

        await authServices.signUp(
          enteredEmail.trim(),
          enteredPassword.trim(),
        );

        await userServices.addUser(
          enteredName.trim(),
          enteredEmail.trim(),
          profileUrl,
        );
      }

      if (mounted) {
        context.go('/');
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')),
        );

        setState(() {
          isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: isLogin ? height / 5 : 34, right: 24, left: 24),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // lock icon
                  Icon(
                    Icons.lock_open_outlined,
                    size: 120,
                    color: Colors.grey[500],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    isLogin
                        ? 'Welcome back you\'ve been missed!'
                        : 'Let\'t create an account for you',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // user image picker
                  if (!isLogin)
                    UserImagePicker(
                      onPickImage: (pickedImage) {
                        _selectedImage = pickedImage;
                      },
                      source: ImageSource.camera,
                      boxRadius: 80,
                    ),

                  const SizedBox(height: 24),

                  // Name TextFormFields
                  CustomTextField(
                    hintText: 'Enter name',
                    validator: (value) {
                      if (value!.isEmpty || value.trim().length < 4) {
                        return 'Please enter atleast 4 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredName = value!;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Email TextFormFields
                  CustomTextField(
                    hintText: 'Enter email',
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredEmail = value!.trim();
                    },
                  ),

                  const SizedBox(height: 16),

                  // password TextFormFields
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Enter password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.trim().length < 6) {
                        return 'Please enter a valid password with atleast 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      enteredPassword = value!;
                    },
                  ),

                  if (isLogin) const SizedBox(height: 8),

                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),

                  if (!isLogin) const SizedBox(height: 16),

                  // password confirm TextFormFields
                  if (!isLogin)
                    CustomTextField(
                      hintText: 'Confirm password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value != passwordController.text) {
                          return 'Password is not correct';
                        }
                        return null;
                      },
                    ),

                  const SizedBox(height: 24),

                  // submit button
                  GestureDetector(
                    onTap: submit,
                    child: Container(
                      width: 370,
                      height: 75,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: isAuthenticating
                          ? const CircularProgressIndicator()
                          : Text(
                              isLogin ? 'Login' : 'Sign Up',
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // switching between login and sign up modes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin ? 'Not a member' : 'Already a member?',
                        style: GoogleFonts.roboto(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin ? 'Register now' : 'Login now',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
