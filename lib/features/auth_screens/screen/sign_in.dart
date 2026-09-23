import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/auth_screens/services/auth_notifier.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = true;

  @override
  void initState() {
    super.initState();

    ref.listenManual(authProvider, (previous, next) {
      next.whenOrNull(
        data: (credential) {
          if (credential == null) return;

          context.go('/main');
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
    final authNotifier = ref.watch(authProvider.notifier);
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      alignment: .center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        'N',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Nyra',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome back',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Log in to continue with your portfolio.',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
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
                      color: Colors.black,
                      fontWeight: .bold,
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
                  // SizedBox(height: 10),
                  Row(
                    mainAxisSize: .max,
                    mainAxisAlignment: .end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          textAlign: .right,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            color: Colors.black45,
                            fontWeight: .bold,
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
                              if (emailController.text.trim().isEmpty ||
                                  passwordController.text.isEmpty) {
                                return;
                              }

                              authNotifier.signIn(
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
                              'Log in',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: .bold,
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
                            text: 'Don\'t have an account? ',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              color: Colors.black45,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/sign_up');
                              },
                            text: 'Sign up',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
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
