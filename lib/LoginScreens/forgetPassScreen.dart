
import 'package:flutter/material.dart';
import 'package:oirov13/Constants/colors.dart';
import 'package:oirov13/LoginScreens/OTPScreen.dart';
import '../components/Components.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _Forgetpass();
}

class _Forgetpass extends State<Forgetpass> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/img/Left.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: mainColor1,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: "cabin",
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "No worries, We got you.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: "cabin",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Image.asset(
                  "assets/img/password.png",
                  width: 300,
                  height: 300,
                ),
              ),

              const SizedBox(height: 35),

              TextFormFieldWidget(
                controller: emailController,
                labelText: "Email",
                labelColor: Colors.grey,
                prefuxIcon: Icons.email,
                textColor: Colors.white,
              ),

              const SizedBox(height: 20),

              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OTPPage()),
                  );
                },
                text: "Send Code",
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
