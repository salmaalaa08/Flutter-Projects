import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
import 'package:fitmap2/screens/resetPassword/verifyOTP.dart';
import 'package:fitmap2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> sendPasswordResetEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your email address.',
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black87,
        ),
      );
      return;
    }
    try {
      await supabase.auth.resetPasswordForEmail(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset OTP sent to $email.',
            style: const TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.black87,
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyOtpPage(email: email)),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid email address',
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black87,
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
        title: Text('Forgot Password',
            style: TextStyle(
                fontSize: size.width * 0.045, fontWeight: FontWeight.w800)),
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
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: size.width * 0.065, fontWeight: FontWeight.w800),
            ),
            Text(
              'Please enter your email',
              style: TextStyle(
                  fontSize: size.width * 0.04, color: CustomColors.gery),
            ),
            SizedBox(height: size.height * 0.05),
            underlineTextFormField(
                context: context,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                labelText: 'Email'),
            SizedBox(height: size.height * 0.07),
            mainBottom(
              context: context,
              function: sendPasswordResetEmail,
              text: 'Send OTP',
            ),
          ],
        ),
      ),
    );
  }
}
