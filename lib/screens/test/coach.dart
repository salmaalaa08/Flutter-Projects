import 'package:flutter/material.dart';

class Coach extends StatelessWidget {
  const Coach({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Coach'),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}