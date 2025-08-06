import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oirov13/Constants/api_config.dart';
import 'package:oirov13/screens/calendarScreen.dart';

import 'achievements_screen.dart';
import 'home_screen.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  int _currentIndex = 2;

  List<Map<String, String>> originalMembers = [];
  List<Map<String, String>> filteredMembers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTeamMembers();
  }

  Future<void> _fetchTeamMembers() async {
    const String apiUrl = '${ApiConfig.apiUrl}/api/client/member';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data']['data'];

        setState(() {
          originalMembers = data
              .map((member) => {
            'name': member['name'].toString(),
            'role': member['role'].toString(),
            'image': '${ApiConfig.apiUrl}${member['image']}',


          })
              .toList();
          filteredMembers = List.from(originalMembers);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch members');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterMembers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembers = List.from(originalMembers);
      } else {
        filteredMembers = originalMembers.where((member) {
          return member['name']!.toLowerCase().contains(query.toLowerCase()) ||
              member['role']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.black,
      body: isLoading ? _buildLoadingIndicator() : _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
          title: const Text('Our Heroes', textAlign: TextAlign.center),
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

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.amber),
    );
  }

  Widget _buildBody() {
    if (filteredMembers.isEmpty) {
      return const Center(
        child: Text(
          'No members found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    } else {
      return Column(
        children: [
          _buildSearchBar(),
          _buildTeamGrid(),
        ],
      );
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: (query) => _filterMembers(query),
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

  Expanded _buildTeamGrid() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: filteredMembers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final member = filteredMembers[index];
          return _buildTeamCard(member);
        },
      ),
    );
  }

  Card _buildTeamCard(Map<String, String> member) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xff222222),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(member['image']!),
          _buildNameAndRole(member),
        ],
      ),
    );
  }

  Expanded _buildImage(String image) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Padding _buildNameAndRole(Map<String, String> member) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            member['name']!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            member['role']!,
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      backgroundColor: Colors.black,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildNavItem(context, Icons.home, const HomeScreen()),
        _buildNavItem(context, Icons.emoji_events, const AchievementsScreen()),
        _buildNavItem(context, Icons.group, const TeamScreen()),
        _buildNavItem(context, Icons.calendar_month, const Calendarr()),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      BuildContext context, IconData icon, Widget targetScreen) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        child: Icon(icon, size: 30.0),
      ),
      label: '',
    );
  }
}
