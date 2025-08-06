import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oirov13/Constants/api_config.dart';
import 'package:oirov13/Constants/colors.dart';
import 'package:http/http.dart' as http;

class CommitteesScreen extends StatefulWidget {
  const CommitteesScreen({super.key});

  @override
  _CommitteesScreenState createState() => _CommitteesScreenState();
}

class _CommitteesScreenState extends State<CommitteesScreen> {
  List<Map<String, String>> committees = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchCommittees();
  }

  Future<void> _fetchCommittees() async {
    final url = '${ApiConfig.apiUrl}/api/client/rov';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final fetchedData = responseData['data']['data'] as List;

        setState(() {
          committees = fetchedData.map((committee) {
            return {
              'image':
                  '${ApiConfig.apiUrl}/storage/${committee['image']?.toString() ?? ''}',
              'title': committee['title']?.toString() ?? 'No Title',
              'description':
                  committee['description']?.toString() ?? 'No Description',
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load committees');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCommittees = committees
        .where((committee) => committee['title']!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredCommittees.length,
                itemBuilder: (context, index) {
                  final committee = filteredCommittees[index];
                  return GestureDetector(
                    onTap: () =>
                        _showCommitteeDetailsDialog(context, committee),
                    child: Card(
                      color: const Color(0xff222222),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor1, width: 1), 
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildImage(committee['image']!),
                            const SizedBox(height: 8.0),
                            _buildTitle(committee['title']!),
                            const SizedBox(height: 4.0),
                            _buildDescription(committee['description']!),
                            const SizedBox(height: 2.0),
                            TextButton(
                              onPressed: () =>
                                  _showCommitteeDetailsDialog(context, committee),
                              child: Text(
                                'Read More',
                                style: TextStyle(color: mainColor1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
        child: AppBar(
          title: const Text('Committees', textAlign: TextAlign.center),
          backgroundColor: const Color(0xFFF8B300),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search',
            suffixIcon: Icon(Icons.search, color: Color(0xfff222222)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Image.network(
        imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: mainColor1,
        ),
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showCommitteeDetailsDialog(
      BuildContext context, Map<String, String> committee) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: mainColor2,
          title: Center(
            child: Text(
              committee['title']!,
              style: TextStyle(color: mainColor1,fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
            committee['description']!,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
              style: TextStyle(color: mainColor1,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
