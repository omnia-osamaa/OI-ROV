import 'package:oirov13/Constants/api_config.dart';
import 'package:oirov13/screens/calendarScreen.dart';
import 'package:oirov13/screens/classroom_screen.dart';
import 'package:oirov13/screens/committes_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oirov13/screens/team_screen.dart';
import 'dart:convert';
import '../LoginScreens/ProfileScreen.dart';
import 'achievements_screen.dart';
import 'our_rov_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  String description = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Function to fetch data from the API
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('${ApiConfig.apiUrl}/api/client/home'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        isLoading = false;
        description = data['data']['data'][0]['description'];
        imageUrl = data['data']['data'][0]['image'];
      });
    } else {
      setState(() {
        isLoading = false;
        description = 'Failed to load data';
        imageUrl = '';
      });
    }
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/img/OI ROV.png",
            height: 60,
            width: 100,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon:
                  const Icon(Icons.person, color: Color(0xFFF8B300), size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildHeroAchievementsRow(),
            const Divider(color: Color(0xfff222222), thickness: 5, height: 40),
            _buildROVSection(context),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 280,
                height: 3,
                color: const Color(0xFFF8B300),
              ),
            ),
            _buildCommitteesSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, currentIndex),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            suffixIcon: Icon(Icons.search, color: Color(0xfff222222)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeroAchievementsRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSectionButton(
            title: "Achievements",
            imagePath: "assets/img/medal-.png",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AchievementsScreen()),
            ),
          ),
          Container(width: 1, height: 87, color: const Color(0xfff222222)),
          _buildSectionButton(
            title: "Our Heros",
            imagePath: "assets/img/heros.png",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TeamScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionButton(
      {required String title,
      required String imagePath,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF8B300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60, width: 60),
            const SizedBox(height: 3),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xfff222222),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildROVSection(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OurROVScreen()),
      ),
      child: Container(
        width: 300,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFF8B300), width: 2),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "${ApiConfig.apiUrl}$imageUrl",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(1), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitteesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discover More Team ..',
            style: TextStyle(
                color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            children: [
              _buildCommitteeCard(context, 'Classroom',
                  'assets/img/classroom.png', ClassroomScreen()),
              _buildCommitteeCard(context, 'Committees',
                  "assets/img/team (1).png", const CommitteesScreen()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommitteeCard(BuildContext context, String title,
      String imagePath, Widget targetScreen) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => targetScreen)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 50),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
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
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetScreen)),
        child: Icon(icon, size: 30.0),
      ),
      label: '',
    );
  }
}
