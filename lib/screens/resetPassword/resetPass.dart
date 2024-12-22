import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
import 'package:fitmap2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isObscured1 = true;
  bool isObscured2 = true;
  final supabase = Supabase.instance.client;

  Future<void> resetPassword() async {
    final newPassword = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Passwords do not match',
          style: const TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.black87,
      )
      );
      return;
    }
    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a new password.',
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black87,
        ),
      );
      return;
    }
    try {
      final response = await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password reset successfully.',
              style: const TextStyle(color: Colors.green),
            ),
            backgroundColor: Colors.black87,
          ),
        );
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to reset password.',
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

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPassFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    confirmPassFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose the FocusNodes to free resources
    passwordFocusNode.dispose();
    confirmPassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.mainBG,
      appBar: AppBar(
        title: Text(
          'Reset Password',
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
            underlineTextFormFieldPass(
                context: context,
                keyboardType: TextInputType.visiblePassword,
                obscureText: isObscured1,
                controller: _passwordController,
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscured1 = !isObscured1; // Toggle password visibility
                    });
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color: isObscured1
                        ? CustomColors.lightGrey
                        : CustomColors.mainColor,
                  ),
                ),
              ),
            SizedBox(
              height: size.height * 0.03,
            ),
             underlineTextFormFieldPass(
                  context: context,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured2 =
                            !isObscured2; // Toggle password visibility
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: isObscured2
                          ? CustomColors.lightGrey
                          : CustomColors.mainColor,
                    ),
                  ),
                  obscureText: isObscured2),
            SizedBox(height: size.height * 0.07),
            mainBottom(
              context: context,
              function: resetPassword,
              text: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
