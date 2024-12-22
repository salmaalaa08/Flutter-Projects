import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [client] for Supabase instance
final client = Supabase.instance.client;



/// small gap
const smallGap = SizedBox(
  height: 15,
);

/// large gap
const largeGap = SizedBox(
  height: 30,
);

/// custom SnackBar
extension ShowSnackBar on BuildContext {
  void showErrorMessege(String messege) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        messege,
        style: const TextStyle(color: Colors.redAccent),
      ),
      backgroundColor: Colors.grey,
    ));
  }
}
