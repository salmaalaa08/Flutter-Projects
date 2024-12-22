import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
import 'package:fitmap2/screens/login/login.dart';
import 'package:fitmap2/utils/authConstant.dart';
import 'package:fitmap2/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

enum Gender { male, female }

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPassController = TextEditingController();
  bool isObscured1 = true;
  bool isObscured2 = true;
  Gender? selectedGender;
  DateTime? selectedDate;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<bool> createUser({
    required final String email,
    required final String password,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
    );
    if (response.user != null) {
      return true;
    } else {
      return false;
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
        backgroundColor: CustomColors.mainBG,
        title: Text(
          'sign up',
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
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.01),
              Center(
                child: Image.asset(CustomImages.logo2, width: size.width * 0.6),
              ),
              SizedBox(height: size.height * 0.02),
              underlineTextFormField(
                  context: context,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  labelText: 'Name'),
              SizedBox(
                height: size.height * 0.02,
              ),
              underlineTextFormField(
                  context: context,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  labelText: 'Email'),
              SizedBox(
                height: size.height * 0.02,
              ),
              underlineTextFormFieldPass(
                context: context,
                keyboardType: TextInputType.visiblePassword,
                obscureText: isObscured1,
                controller: passwordController,
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
                height: size.height * 0.02,
              ),
              underlineTextFormFieldPass(
                  context: context,
                  keyboardType: TextInputType.visiblePassword,
                  controller: comfirmPassController,
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
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () =>
                    selectDate(context), // Trigger the date picker on tap
                child: Row(
                  children: [
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                          : "Select Date of Birth",
                      style: TextStyle(
                        color: CustomColors.gery,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                        width: size.width *
                            0.02), // Add spacing between text and icon if needed
                    const Icon(Icons.calendar_today, color: CustomColors.gery),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Select Gender:',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: CustomColors.gery,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<Gender>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Male',
                        style: TextStyle(
                          color: selectedGender == Gender.male
                              ? CustomColors
                                  .mainColor // Use mainColor when selected
                              : CustomColors.gery, // Use grey when not selected
                        ),
                      ),
                      value: Gender.male,
                      groupValue: selectedGender,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => states.contains(MaterialState.selected)
                              ? CustomColors.mainColor
                              : CustomColors.gery),
                      activeColor: CustomColors
                          .mainColor, // Color of the selected radio button
                      onChanged: (Gender? value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Female',
                        style: TextStyle(
                          color: selectedGender == Gender.female
                              ? CustomColors
                                  .mainColor // Use mainColor when selected
                              : CustomColors.gery, // Use grey when not selected
                        ),
                      ),
                      value: Gender.female,
                      groupValue: selectedGender,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => states.contains(MaterialState.selected)
                              ? CustomColors.mainColor
                              : CustomColors.gery),
                      activeColor: CustomColors
                          .mainColor, // Color of the selected radio button
                      onChanged: (Gender? value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Center(
                  child: mainBottom(
                      context: context,
                      text: 'sign up',
                      function: () async {
                        final userValue = await createUser(
                            email: emailController.text,
                            password: passwordController.text);
                        if (userValue == true) {
                          Navigator.pushReplacementNamed(context, '/signin');
                          context.showErrorMessege('Success');
                        }
                      })),
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
                              builder: (context) => const Login()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // No background color
                      overlayColor: Colors.transparent, // No press effect
                      padding: EdgeInsets
                          .zero, // Optional: removes any default padding
                    ),
                    child: Text(
                      'log in',
                      style: TextStyle(
                          fontSize: size.width * 0.035,
                          color: CustomColors.mainColor),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
