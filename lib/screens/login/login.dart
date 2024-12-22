// ignore_for_file: unused_local_variable

import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
import 'package:fitmap2/screens/resetPassword/forgotPass.dart';
import 'package:fitmap2/screens/signup/signup.dart';
import 'package:fitmap2/utils/authConstant.dart';
import 'package:fitmap2/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool isLoading = false;
bool isObscured = true;

class _LoginState extends State<Login> {
  final FocusNode emailFocusNode = FocusNode(); // FocusNode for email
  final FocusNode passwordFocusNode = FocusNode(); // FocusNode for password

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    emailFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose the FocusNodes to free resources
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Future<String?> userlogin({
      required String email,
      required String password,
    }) async {
      try {
        final response = await client.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (response.session == null) {
          throw Exception('Invalid email or password');
        }

        return response.user?.id;
      } catch (e) {
        throw Exception('Error: ${e.toString()}');
      }
    }

    return Scaffold(
      backgroundColor: CustomColors.mainBG,
      appBar: AppBar(
        backgroundColor: CustomColors.mainBG,
        title: Text(
          'log in',
          style: TextStyle(
              fontSize: size.width * 0.045, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.08),
              Image.asset(CustomImages.logo2, width: size.width * 0.7),
              SizedBox(
                height: size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BordRadTextFormField(
                        context: context,
                        focusNode: emailFocusNode,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        obscureText: false),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFormField(
                      focusNode: passwordFocusNode, // Attach FocusNode
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: CustomColors.lightGrey,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: CustomColors.mainColor,
                            width: 2,
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w500,
                          color: passwordFocusNode.hasFocus
                              ? CustomColors.lightGrey
                              : CustomColors.gery,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: isObscured
                                ? CustomColors.lightGrey
                                : CustomColors.mainColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Focus(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              overlayColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Forget Password ?',
                              style: TextStyle(
                                color: CustomColors.gery,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    mainBottom(
                      context: context,
                      text: 'log in',
                      function: () async {
                        setState(() {
                          isLoading = true; // Start loading
                        });
                        try {
                          final userId = await userlogin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          if (userId != null) {
                            Navigator.pushReplacementNamed(context,
                                '/fitmap'); // Navigate to the next screen
                          }
                        } catch (e) {
                          context.showErrorMessege('Invalid Email or Password');
                        } finally {
                          setState(() {
                            isLoading = false; // Hide loading indicator
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.035),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'sign up',
                            style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: CustomColors.mainColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
