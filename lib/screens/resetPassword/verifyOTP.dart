import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
import 'package:fitmap2/screens/resetPassword/resetPass.dart';
import 'package:fitmap2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtpPage extends StatefulWidget {
  final String email;

  VerifyOtpPage({required this.email});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _otpController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter the OTP.',
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black87,
        ),
      );
      return;
    }
    try {
      final response = await supabase.auth.verifyOTP(
        token: otp,
        type: OtpType.recovery,
        email: widget.email,
      );
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'OTP verified successfully.',
              style: const TextStyle(color: Colors.green),
            ),
            backgroundColor: Colors.black87,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResetPasswordPage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid OTP. Please try again.',
              style: const TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.black87,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
  Future<void> resendOtp() async {
    try {
      await supabase.auth.resetPasswordForEmail(widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'A new OTP has been sent to your email.',
            style: const TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.black87,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error resending OTP: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.mainBG,
      appBar: AppBar(
        title: Text(
          'Verify OTP',
          style: TextStyle(
              fontSize: size.width * 0.045, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.mainBG,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            CustomImages.backArrow,
            width: size.width * 0.03,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            Text(
              'OTP Email Verification',
              style: TextStyle(
                  fontSize: size.width * 0.065, fontWeight: FontWeight.w800),
            ),
            Text(
              'Please insert the OTP sent in the Email',
              style: TextStyle(
                  fontSize: size.width * 0.04, color: CustomColors.gery),
            ),
            SizedBox(height: size.height * 0.05),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.none,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeColor: CustomColors.mainColor,
                inactiveColor: CustomColors.lightGrey,
                selectedColor: CustomColors.gery,
              ),
              
              enableActiveFill: false,
              controller: _otpController,
              onCompleted: (v) {
                // Trigger OTP verification when all fields are filled
                verifyOtp();
              },
              onChanged: (value) {
                // Handle changes if necessary
              },
              beforeTextPaste: (text) {
                // Allow pasting
                return true;
              },
            ),
            Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t receive code ?',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.035),
                        ),
                        TextButton(
                          onPressed: resendOtp,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'resend',
                            style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: CustomColors.mainColor),
                          ),
                        )
                      ],
                    ),
            SizedBox(height: size.height * 0.04),
            mainBottom(
              context: context,
              function: verifyOtp,
              text: 'Verify OTP',
            ),
          ],
        ),
      ),
    );
  }
}
