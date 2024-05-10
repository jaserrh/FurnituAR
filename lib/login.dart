import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/home_screen.dart';
import 'package:furniture_app/mybuttom.dart';
import 'package:furniture_app/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  //signIn
  Future signIn() async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (user.user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("error sign in "),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error occured"),
        backgroundColor: Colors.red,
      ));
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
            SizedBox(
              height: 40,
            ),
            Container(
              height: 150,
              child: Image.asset('images/Mobile login-rafiki.png'),
            ),
            SizedBox(
              height: 50,
            ),

            //text
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 40,
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
                    hintText: "Username",
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(174, 0, 0, 0))),
              ),
            ),
            SizedBox(
              height: 10,
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
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(174, 0, 0, 0))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //buttom
            Mybuttom(
              onTap: () async {
                await signIn();
              },
            ),
            const SizedBox(
              height: 10,
            ),

            //text
            const Text('or continue with'),
            const SizedBox(
              height: 10,
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
                  child: Image.asset('images/R.png'),
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
                  child: Image.asset('images/OIP.jpeg'),
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
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
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
