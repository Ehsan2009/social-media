import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.submit,
    required this.isAuthenticating,
    required this.isLogin,
  });

  final void Function() submit;
  final bool isAuthenticating;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submit,
      child: Container(
        width: 370,
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(16),
        ),
        child:  
            isAuthenticating
                ? const CircularProgressIndicator()
                : Text(
                  isLogin ? 'Login' : 'Sign Up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
      ),
    );
  }
}
