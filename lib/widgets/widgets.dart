import 'package:fitmap2/constant/custom_colors.dart';
import 'package:flutter/material.dart';

Widget mainTransparentBottom(
        {required BuildContext context,
        required String text,
        required VoidCallback function}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
          border: Border.all(
              color: CustomColors.mainColor,
              width: MediaQuery.of(context).size.width * 0.005),
          borderRadius: BorderRadius.circular(40)),
      child: MaterialButton(
        onPressed: function,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Text(
          text,
          style: TextStyle(
              color: CustomColors.mainBG,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w400),
        ),
      ),
    );

Widget mainBottom({
  required BuildContext context,
  required String text,
  required VoidCallback function,
}) => Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: CustomColors.mainColor, 
        border: Border.all(
          color: CustomColors.mainColor,
          width: MediaQuery.of(context).size.width * 0.005,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: MaterialButton(
        onPressed: function,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: CustomColors.mainBG,
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );

Widget BordRadTextFormField ({
  required BuildContext context,
  required FocusNode focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required bool obscureText
}) => TextFormField(
                      focusNode: focusNode, // Attach FocusNode
                      controller: controller,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
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
                        labelText: labelText,
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w500,
                          color: focusNode.hasFocus
                              ? CustomColors.lightGrey // Light grey when focused
                              : CustomColors.gery, // Grey when not focused
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                      ),
                    );

Widget BordRadTextFormFieldPass({
  required BuildContext context,
  required FocusNode focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required bool obscureText,
  required Widget suffixIcon,
}) => TextFormField(
                      focusNode: focusNode, // Attach FocusNode
                      controller: controller,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
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
                        labelText: labelText,
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w500,
                          color: focusNode.hasFocus
                              ? CustomColors.lightGrey
                              : CustomColors.gery,
                        ),
                        suffixIcon: suffixIcon,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                      ),
                    );

Widget underlineTextFormField ({
  required BuildContext context,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String labelText,
}) => TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                cursorColor: CustomColors.mainColor,
                decoration: InputDecoration(
                    labelText: labelText,
                    floatingLabelStyle: TextStyle(
                        color: CustomColors.gery, fontSize: MediaQuery.of(context).size.width * 0.04),
                    labelStyle: TextStyle(
                        color: CustomColors.gery, fontSize: MediaQuery.of(context).size.width * 0.04),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.lightGrey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: CustomColors.mainColor,
                      width: 1,
                    ))),
              );

Widget underlineTextFormFieldPass ({
  required BuildContext context,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String labelText,
  required Widget suffixIcon,
  required bool obscureText,
}) => TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                cursorColor: CustomColors.mainColor,
                decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    labelText: labelText,
                    floatingLabelStyle: TextStyle(
                        color: CustomColors.gery, fontSize: MediaQuery.of(context).size.width * 0.04),
                    labelStyle: TextStyle(
                        color: CustomColors.gery, fontSize: MediaQuery.of(context).size.width * 0.04),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.lightGrey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: CustomColors.mainColor,
                      width: 1,
                    ))),
              );