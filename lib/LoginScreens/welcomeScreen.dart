import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../components/Components.dart';
import 'LoginScreen.dart';
import 'SignUpScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
            width: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Welcome!",
                style: TextStyle(
                    color: mainColor1,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    fontFamily: "cabin"),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Login or sign up to continue",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: "cabin"),
              ),
            ),
          ),
          SizedBox(
            // height: 50,
            height: 10,
          ),
          Expanded(
            child: Center(
              child: Container(
                // height: 850,
                // width: 220,
                height: 1000,
                // width: 200,
                child: Image.asset(
                  "assets/img/Welcome.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            // height: 50,
            height: 10,

          ),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            text: "Login",
            textColor: Colors.black,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signupscreen()),
              );
            },
            text: "Signup",
            textColor: Colors.black,
          ),
          SizedBox(
            height: 25,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
