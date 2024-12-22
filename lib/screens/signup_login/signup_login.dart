import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
import 'package:fitmap2/screens/login/login.dart';
import 'package:fitmap2/screens/signup/signup.dart';
import 'package:fitmap2/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({super.key});

  @override
  Widget build(BuildContext context) {

   final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(CustomImages.mainBG), 
                fit: BoxFit.cover,
                opacity: 0.5
                ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height*0.15,
                  ),
                  Image.asset(
                    CustomImages.logo2,
                    width: size.width * 0.7,
                  ),
                  Text(
                    'Fit Map',
                    style: TextStyle(
                        color: CustomColors.mainBG, fontSize: size.width * 0.075),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height*0.1,
                  ),
                  mainTransparentBottom(
                    context: context,
                    text: 'Log in', 
                    function: (){
                      Navigator.push( 
                        context, 
                        MaterialPageRoute( 
                            builder: (context) => 
                                const Login()));
                    }
                    ),
                    SizedBox(
                      height: size.height*0.04,
                    ),
                    mainTransparentBottom(
                    context: context,
                    text: 'Sign up', 
                    function: (){
                      Navigator.push( 
                        context, 
                        MaterialPageRoute( 
                            builder: (context) => 
                                const Signup()));
                    }
                    ),
                    
            
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}