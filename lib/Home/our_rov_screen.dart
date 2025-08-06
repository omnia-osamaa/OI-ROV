import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oirov13/Constants/api_config.dart';

class OurROVScreen extends StatefulWidget {
  const OurROVScreen({super.key});

  @override
  _OurROVScreenState createState() => _OurROVScreenState();
}

class _OurROVScreenState extends State<OurROVScreen> {
  bool isLoading = true;
  String errorMessage = '';
  String name = '';
  String description = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchROVData();
  }

  Future<void> fetchROVData() async {
    final response = await http.get(Uri.parse('${ApiConfig.apiUrl}/api/client/about'));

    if (response.statusCode == 200) {
      // Parse the response body
      final data = json.decode(response.body);

      setState(() {
        name = data['data']['data'][0]['name'];
        description = data['data']['data'][0]['description'];
        imageUrl = data['data']['data'][0]['image'];
        isLoading = false;
      });

      // Debug print for image URL
      print('Image URL: $imageUrl');
    } else {
      setState(() {
        errorMessage = 'Failed to load data';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSection(context),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        name, 
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description, 
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildTopSection(BuildContext context) {
  return Stack(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.height * 0.3,
        child: imageUrl.isNotEmpty
            ? Image.network(
                '${ApiConfig.apiUrl}$imageUrl',
                fit: BoxFit.cover, 
              )
            : Container(color: Colors.grey),
      ),
      Positioned(
        top: 10,
        left: 10,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ],
  );
}
}
