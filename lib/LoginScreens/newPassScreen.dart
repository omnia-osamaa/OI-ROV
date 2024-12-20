import 'package:flutter/material.dart';
import 'package:oirov13/Constants/colors.dart';
import '../components/Components.dart';
import 'LoginScreen.dart';

class Newpassscreen extends StatefulWidget {
  const Newpassscreen({super.key});

  @override
  State<Newpassscreen> createState() => _Newpassscreen();
}

class _Newpassscreen extends State<Newpassscreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), 
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
                "Set New Password",
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
                "Create an unique password",
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
                "assets/img/npassword.png",
                width: 300,
                height: 300,
              ),
            ),

            const SizedBox(height: 30),

            PasswordTextFormFieldWidget(
              controller: passwordController,
              labelText: "Password",
              labelColor: Colors.grey,
              suffixIcon: Icons.visibility,
              prefixIcon: Icons.lock,
              textColor: Colors.white,
            ),
            const SizedBox(height: 15),
            PasswordTextFormFieldWidget(
              controller: confirmPassController,
              labelText: "Confirm Password",
              labelColor: Colors.grey,
              suffixIcon: Icons.visibility,
              prefixIcon: Icons.lock,
              textColor: Colors.white,
            ),
            const SizedBox(height: 25),

            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              text: "Signup",
              textColor: Colors.black,
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                "Reset a password later?",
                style: TextStyle(
                  color: mainColor1,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "cabin",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
