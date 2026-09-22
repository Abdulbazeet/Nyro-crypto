// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/auth_screens/services/auth_notifier.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  bool isHidden = true;
  bool isHidden2 = true;
  bool isChecked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    ref.listenManual(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (credential) {
          if (credential == null) return;

          context.go('/otp');
        },
        error: (error, stackTrace) {
          AppUtils.bar(
            text: error.toString(),
            context: context,
            color: Colors.red,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 40),

                  Text(
                    'Create your account',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Start practicing with a fresh portfolio.',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(height: 30),

                  // name
                  Text(
                    'Full name',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: .w500,
                    ),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: usernameController,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: .bold,
                    ),
                    keyboardType: .name,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Alex Scott',
                      hintStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),

                  // email
                  SizedBox(height: 20),
                  Text(
                    'Email',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: .w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: .bold,

                      color: Colors.black,
                    ),
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'you@example.com',
                      hintStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),

                  //password
                  SizedBox(height: 20),
                  Text(
                    'Password',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: .w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: .bold,
                    ),
                    obscureText: isHidden,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        icon: Icon(
                          isHidden
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),

                      filled: true,
                      hintText: '*********',
                      hintStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),

                  //confirm password
                  SizedBox(height: 20),
                  Text(
                    'Confirm password',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: .w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPasswordController,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: .bold,
                    ),
                    obscureText: isHidden2,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHidden2 = !isHidden2;
                          });
                        },
                        icon: Icon(
                          isHidden2
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),

                      filled: true,
                      hintText: '*********',
                      hintStyle: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisSize: .max,
                    // crossAxisAlignment: .start,
                    mainAxisAlignment: .start,

                    children: [
                      Checkbox(
                        value: isChecked,

                        activeColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // fillColor: MaterialStateProperty.all(
                        //   Colors.grey.shade300,
                        // ),
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        side: BorderSide(color: Colors.black45),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'I agree to the ',
                                style: TextStyle(color: Colors.black45),
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: .bold,

                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(color: Colors.black45),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: .bold,
                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: authState.isLoading
                          ? null
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                    ),
                    child: ElevatedButton(
                      onPressed: authState.isLoading
                          ? null
                          : () {
                              if (usernameController.text.trim().isEmpty ||
                                  emailController.text.trim().isEmpty ||
                                  passwordController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                return;
                              }

                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return;
                              }

                              if (!isChecked) {
                                return;
                              }

                              authNotifier.signUp(
                                username: usernameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: authState.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Create account',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account?  ',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/sign_in');
                              },
                            text: 'Log in',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: .bold,
                            ),
                          ),
                        ],
                      ),
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
