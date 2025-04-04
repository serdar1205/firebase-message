import 'dart:developer';
import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:firebase_message/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_message/features/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/chat_widgets/k_textfield.dart';
import '../../widgets/dialog_widget.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSubmitted = false;

  bool validate() {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (!isSubmitted) {
      setState(() {
        isSubmitted = true;
      });
    }
    return isValid;
  }

  Future signIn() async {
    if (validate()) {
      context.read<AuthBloc>().add(SignInEvent(AuthParams(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to chat app!",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _passwordController,
                      obscureText: true,
                      hintText: 'Password',
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  //sign in button
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: AppColors.darkGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                    log('$state', name: 'state');
                    if (state is Authenticated) {
                    } else if (state is AuthFailure) {
                      dialogWidget(context, state.error);

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    }
                  }, builder: (context, state) {
                    return MainButton(
                      buttonTile: 'Sign in',
                      onPressed: signIn,
                      isLoading: state is AuthLoading,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: AppColors.darkGreen),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
