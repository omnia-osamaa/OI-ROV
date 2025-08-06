import 'dart:developer';
import 'package:oirov13/Constants/api_config.dart';
import 'package:oirov13/screens/calendarScreen.dart';
import 'package:oirov13/screens/team_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_screen.dart';
import 'our_rov_screen.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<AchievementCard> _allAchievements = [];
  List<AchievementCard> _filteredAchievements = [];

  @override
  void initState() {
    super.initState();
    _fetchAchievements();
    _searchController.addListener(_filterAchievements);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchAchievements() async {
    log("Fetching achievements...");
    const url = '${ApiConfig.apiUrl}/api/client/achievement';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log("Response data: $data");
        final List<dynamic> achievementsData = data['data']['data'];

        setState(() {
          _allAchievements = achievementsData.map((achievement) {
            return AchievementCard(
              title: achievement['name'],
              date: _formatDate(achievement['date']),
              location: achievement['location'],
              imagePath: achievement['image'],
              achievement: achievement['rank'],
              members : achievement['members']
            );
          }).toList();
          _filteredAchievements = _allAchievements;
        });
      } else {
        log("Error: ${response.statusCode}");
      }
    } catch (error) {
      log("Network error: $error");
    }
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.day} ${_monthName(parsedDate.month)}, ${parsedDate.year}";
    } catch (e) {
      log("Date parsing error: $e");
      return date; 
    }
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  void _filterAchievements() {
    setState(() {
      _filteredAchievements = _allAchievements
          .where((achievement) =>
      achievement.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          achievement.achievement.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/Ellipse 1805.png'),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 2 - 35,
                  child: Image.asset(
                    'assets/img/Group 196.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Image.asset(
                'assets/img/OI ROV.png',
                width: 120,
                height: 70,
              ),
              const Spacer(),
            ],
          ),
          _buildSearchBar(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredAchievements.length,
              itemBuilder: (context, index) {
                return _filteredAchievements[index];
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 1),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _searchController,
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

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            break;
          case 1:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AchievementsScreen()));
            break;
          case 2:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const TeamScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const OurROVScreen()));
            break;
        }
      },
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

class AchievementCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String imagePath;
  final String achievement;
  final String members;


  const AchievementCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.imagePath,
    required this.members,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xff222222),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF8B300), width: 1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      offset: const Offset(0, 5),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: Image.network(
                  "${ApiConfig.apiUrl}/storage/$imagePath",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF8B300), width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF8B300),
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Color(0xFFF8B300)),
                        const SizedBox(width: 5),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.group, color: Color(0xFFF8B300)),
                        const SizedBox(width: 5),
                        Text(
                          members, 
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.military_tech,
                            color: Color(0xFFF8B300)),
                        const SizedBox(width: 5),
                        Text(
                          achievement,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
