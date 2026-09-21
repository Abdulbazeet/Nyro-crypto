// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show Container, Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  bool isHidden = true;
  bool isHidden2 = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
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
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.black,
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
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
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
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.black,
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
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
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
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    obscureText: isHidden,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHidden2 = !isHidden2;
                          });
                        },
                        icon: Icon(
                          isHidden2
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Create account',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
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
