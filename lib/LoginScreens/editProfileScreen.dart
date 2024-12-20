
import 'package:flutter/material.dart';
import 'package:oirov13/Components/components.dart';
import 'package:oirov13/Constants/colors.dart';
import 'package:oirov13/LoginScreens/profileScreen.dart';
class Editprofile extends StatefulWidget {
  const Editprofile({super.key});
  @override
  State<Editprofile> createState() => _Editprofile();
}

class _Editprofile extends State<Editprofile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController uploadphotoController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: mainColor1,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: "cabin"),
                ),
              ),
              const SizedBox(height: 70),
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
              TextFormFieldWidget(
                controller: uploadphotoController,
                labelText: "Phone Number",
                labelColor: Colors.grey,
                prefuxIcon: Icons.phone,
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
              const SizedBox(height: 50),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                text: "Save",
                textColor: Colors.black,
              ),
              const SizedBox(height: 30),
              Container(
                height: 160,
                width: 300,
                child: Image.asset("assets/img/OI ROV LOGO .png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
