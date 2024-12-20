import 'package:flutter/material.dart';
import 'package:oirov13/Constants/colors.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUs();
}

class _ContactUs extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), 
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/img/Left.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Contact us",
              style: TextStyle(
                color: mainColor1,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: "cabin",
              ),
            ),

            const SizedBox(height: 50),

            launchButton(
              title: 'WhatsApp',
              icon: Icons.phone,
              onPressed: () async {
                Uri uri = Uri.parse('tel:+201094221157');
                if (!await launcher.launchUrl(uri)) {
                  debugPrint("Could not launch the uri");
                }
              },
            ),
            launchButton(
              title: 'Facebook',
              icon: Icons.language,
              onPressed: () {
                launcher.launchUrl(
                  Uri.parse('https://www.facebook.com/OIROV?mibextid=ZbWKwL'),
                  mode: launcher.LaunchMode.externalApplication,
                );
              },
            ),
            launchButton(
              title: 'Linked In',
              icon: Icons.message,
              onPressed: () => launcher.launchUrl(
                Uri.parse(
                    'https://www.linkedin.com/company/101669390/admin/inbox/'),
              ),
            ),
            launchButton(
              title: 'Email',
              icon: Icons.email,
              onPressed: () async {
                Uri uri = Uri.parse(
                  'mailto:oirovteam@gmail.com?subject=Hello&body=Welcome in Oi-ROV',
                );
                if (!await launcher.launchUrl(uri)) {
                  debugPrint("Could not launch the uri");
                }
              },
            ),

            const SizedBox(height: 30),

            // Logo
            Center(
              child: Container(
                height: 160,
                width: 300,
                child: Image.asset("assets/img/OI ROV LOGO .png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget launchButton({
    required String title,
    required IconData icon,
    required Function() onPressed,
    Color iconColor = Colors.white,
  }) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: mainColor1.withOpacity(0.8), width: 2),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: mainColor1),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
