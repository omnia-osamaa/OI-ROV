import 'dart:convert';

import 'package:oirov13/Components/components.dart';
import 'package:oirov13/Constants/api_config.dart';
import 'package:oirov13/Constants/colors.dart';
import 'package:oirov13/LoginScreens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oirov13/screens/home_screen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});
  @override
  State<Signupscreen> createState() => _Signupscreen();
}

class _Signupscreen extends State<Signupscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  String? selectedDropdownValue;

  final List<String> dropdownItems = [
    'Software',
    'Electrical',
    'Mechanical',
    'Media',
    'HR',
    'PR'
  ];

  Future<void> registerUser() async {
    const String endpoint = '${ApiConfig.apiUrl}/api/admin/user/register';

    try {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPassController.text.isEmpty ||
          selectedDropdownValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token_here', 
        },
        body: json.encode({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPassController.text,
          'committee': selectedDropdownValue ??
              '', 
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/img/Left.png"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create account",
                  style: TextStyle(
                      color: mainColor1,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: "cabin"),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up to continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "cabin"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormFieldWidget(
                controller: nameController,
                labelText: "Name",
                labelColor: Colors.grey,
                prefuxIcon: Icons.person,
                textColor: Colors.white,
              ),
              const SizedBox(height: 15),
              TextFormFieldWidget(
                controller: emailController,
                labelText: "Email",
                labelColor: Colors.grey,
                prefuxIcon: Icons.email,
                textColor: Colors.white,
              ),
              const SizedBox(height: 15),
              PasswordTextFormFieldWidget(
                controller: passwordController,
                labelText: "Password",
                labelColor: Colors.grey,
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility,
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
              const SizedBox(height: 15),
              TextFormFieldWidget(
                controller: phoneController,
                labelText: "Phone Number",
                labelColor: Colors.grey,
                prefuxIcon: Icons.phone_android,
                textColor: Colors.white,
              ),
              const SizedBox(height: 15),
              DropdownWidget(
                items: dropdownItems,
                labelText: "Select committee",
                labelColor: Colors.grey,
                textColor: Colors.white,
                shade: Colors.transparent,
                selectedValue: selectedDropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDropdownValue = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: registerUser,
                text: "Sign Up",
                textColor: Colors.black,
              ),
              const SizedBox(height: 30),
              Container(
                height: 160,
                width: 300,
                child: Image.asset("assets/img/OI ROV LOGO .png"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "cabin"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: mainColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "cabin"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
