import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/Auth.dart';
import 'package:furniture_app/login.dart';
import 'package:furniture_app/mybuttom.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  //signIn
  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Auth()));
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            //image
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 150,
              child: Image.asset('images/Sign up-rafiki.png'),
            ),
            const SizedBox(
              height: 50,
            ),

            //text
            const Text(
              'Create an Account!',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            //textfeild username

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    fillColor: Colors.grey[50],
                    filled: true,
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Color.fromARGB(174, 0, 0, 0))),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            //textfeild password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    fillColor: Colors.grey[50],
                    filled: true,
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Color.fromARGB(174, 0, 0, 0))),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _confirmpasswordController,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    fillColor: Colors.grey[50],
                    filled: true,
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(color: Color.fromARGB(174, 0, 0, 0))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //sign in buttom
            Mybuttom1(
              onTap: signUp,
            ),
            const SizedBox(
              height: 10,
            ),

            //text
            const Text('or continue with'),
            const SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //google
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Image.asset("images/R.png"),
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                //facebook
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Image.asset("images/OIP.jpeg"),
                  height: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('not a member ?'),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                        color: Color.fromARGB(255, 86, 138, 250), fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
