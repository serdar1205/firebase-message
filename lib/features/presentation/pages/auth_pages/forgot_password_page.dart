import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../widgets/chat_widgets/k_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link snet! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Enter your email and we will send you a password reset link',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: KTextField(
              controller: _emailController,
              hintText: "Email",
              isSubmitted: false,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: passwordReset,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'Reset password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
