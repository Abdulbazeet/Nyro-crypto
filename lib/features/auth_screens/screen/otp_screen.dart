import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyro_cryto/features/auth_screens/services/auth_service.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late final TextEditingController otpController;
  bool startCountDown = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  int count = 9;

  void _addDigit(String digit) {
    if (otpController.text.length >= 6) return;
    otpController.text += digit;
  }

  void _backspace() {
    if (otpController.text.isEmpty) return;
    otpController.text = otpController.text.substring(
      0,
      otpController.text.length - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    //   final user = ref.watch(currentUserProvider);

    final email = FirebaseAuth.instance.currentUser?.email;
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 54,
      textStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFECEEF6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Verify your email',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "We've sent an OTP to ${email ?? 'your email'}.",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 20),
                Pinput(
                  length: 6,
                  controller: otpController,
                  useNativeKeyboard: false,
                  readOnly: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme,
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.red, width: 1.5),
                    ),
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Spacer(),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                  ),

                  itemBuilder: (context, index) {
                    if (index == 9) {
                      return const SizedBox.shrink();
                    }
                    final isBackspace = index == 11;
                    final label = index == 10 ? '0' : '${index + 1}';
                    return GestureDetector(
                      onTap: () {
                        if (isBackspace) {
                          _backspace();
                        } else {
                          _addDigit(label);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECEEF6),

                          //    color: Colors.grey[300],
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: isBackspace
                              ? const Icon(Icons.backspace_outlined, size: 20)
                              : Text(
                                  label,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // Handle resend code action
                      },
                      child: startCountDown
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Resend code in ',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      fontWeight: .bold,
                                      color: Colors.black45
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'Resend code',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                fontWeight: .bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
