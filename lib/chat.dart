import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chat extends StatelessWidget {
  const chat({super.key});
  void signInOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signInOut, icon: Icon(Icons.logout))
      ]),
      body: const Center(
        child: Text("Welcome"),
      ),
    );
  }
}
