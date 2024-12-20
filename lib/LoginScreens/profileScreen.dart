import 'dart:convert';
import 'package:oirov13/Constants/api_config.dart';
import 'package:oirov13/LoginScreens/contactUs.dart';
import 'package:oirov13/LoginScreens/editProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../Constants/TextProfile.dart';
import '../Constants/colors.dart';
import 'SignUpScreen.dart';
import 'WelcomeScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String name = '';
  String email = '';
  String phoneNumber = '';
  String committee = '';

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse('${ApiConfig.apiUrl}/api/admin/user/me'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final userData = responseData['data']['user'];

          setState(() {
            name = userData['name'];
            email = userData['email'];
            phoneNumber = userData['phone_number'];
            committee = userData['committee'];
          });
        } else {
          print('Failed to fetch profile data: ${response.body}');
        }
      } catch (error) {
        print('Error fetching profile data: $error');
      }
    } else {
      print('No token found');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 45),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/img/Left.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/img/omnia.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Editprofile()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // ignore: deprecated_member_use
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            name.isEmpty ? 'Loading...' : name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "cabin"),
                          ),
                          Text(
                            email.isEmpty ? '' : email,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "cabin"),
                          ),
                          Text(
                            committee.isEmpty ? '' : committee,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "cabin"),
                          ),
                          Text(
                            phoneNumber.isEmpty ? '' : phoneNumber,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "cabin"),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  // ignore: deprecated_member_use
                                  color: mainColor1.withOpacity(0.8)),
                              child: Icon(Icons.info),
                            ),
                            title: Text(
                              Menu2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "cabin"),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  // ignore: deprecated_member_use
                                  color: mainColor1.withOpacity(0.8)),
                              child: Icon(Icons.add),
                            ),
                            title: Text(
                              Menu3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "cabin"),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signupscreen()),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  // ignore: deprecated_member_use
                                  color: mainColor1.withOpacity(0.8)),
                              child: Icon(Icons.logout),
                            ),
                            title: Text(
                              Menu4,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "cabin"),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
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
