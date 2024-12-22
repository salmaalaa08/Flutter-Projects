import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/constant/custom_images.dart';
// import 'package:fitmap2/screens/signup_login/signup_login.dart';
// import 'package:fitmap2/utils/authConstant.dart';
import 'package:flutter/material.dart';

class Userhomepage extends StatefulWidget {
  const Userhomepage({super.key});

  @override
  State<Userhomepage> createState() => _UserhomepageState();
}

class _UserhomepageState extends State<Userhomepage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.4,
              child: Image.asset(
                CustomImages.homeBg,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.6),
                colorBlendMode: BlendMode.colorBurn,
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //         icon: Icon(Icons.menu, color: CustomColors.mainBG,),
            //         iconSize: 25,
            //         onPressed: () {}
            //     ),
            //   ],
            // ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  Image.asset(CustomImages.logo2, width: size.width * 0.67),
                  const Text(
                    'Fit Map',
                    style: TextStyle(
                        color: CustomColors.mainBG,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ]),
        
        ],
      ),
    );
  }
}
