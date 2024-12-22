import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/screens/login/login.dart';
import 'package:fitmap2/screens/signup/signup.dart';
import 'package:fitmap2/screens/signup_login/signup_login.dart';
import 'package:fitmap2/utils/authConstant.dart';
import 'package:fitmap2/widgets/bottomNavigatorBar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{

  // supabase setup
  
  await Supabase.initialize(
    url: 'https://ohjgrvmponlknkgutgli.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9oamdydm1wb25sa25rZ3V0Z2xpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5MjM3MzMsImV4cCI6MjA0OTQ5OTczM30.5VwZuMQm_ceF01694eyrFK0lHmwdhB_gHdT7incVSLk',
  );



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      color: CustomColors.mainBG,
      debugShowCheckedModeBanner: false,
      initialRoute: client.auth.currentSession != null? "/fitmap" : "/", 
      routes: {
        '/':(context) => const SignupLogin(),
        '/signin': (context) => const Login(),
        '/signup':(context) => const Signup(),
        '/fitmap': (context) => BottomNavigatorBar(),
      },
    );
  }
}