import 'dart:async';
import 'package:firebase_message/features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';
import 'package:firebase_message/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_message/features/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../widgets/chat_widgets/k_textfield.dart';
import '../../widgets/dialog_widget.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
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

  void signUp() async {
    if (passwordConfirmed()) {
      if (validate()) {
        context.read<AuthBloc>().add(
              SignUpEvent(
                SignUpParams(
                  name: _firstNameController.text.trim(),
                  surname: _lastNameController.text.trim(),
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                ),
              ),
            );
      }
    }
  }


  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
                    "Registration",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _firstNameController,
                      hintText: 'First name',
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //last name textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _lastNameController,
                      hintText: 'Last name ',
                      isSubmitted: isSubmitted,
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
                      hintText: 'Password',
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm password',
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is Authenticated) {
                    } else if (state is AuthFailure) {
                      dialogWidget(context, state.error);

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    }
                  }, builder: (context, state) {
                    return MainButton(
                      buttonTile: 'Sign up',
                      onPressed: signUp,
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
                        'I\'m a member?',
                        style: TextStyle(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.bold,
                          ),
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
