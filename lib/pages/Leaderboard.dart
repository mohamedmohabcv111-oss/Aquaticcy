import 'package:aquaticcy/Services/user_service.dart';
import 'package:aquaticcy/models/user_model.dart';
import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/bottomnavbar.dart';
import 'package:aquaticcy/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final UserService _userservice = UserService();
  List<UserModel?> allFetchedUsers = [];

  Future<void> _fetchallusers() async {
    final users = await _userservice.getallusers();

    users.sort((a, b) => b!.score.compareTo(a!.score));

    setState(() {
      allFetchedUsers = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchallusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AquaticcyAppBar(),
      endDrawer: const AquaticcyDrawer(currentPage: 'Leaderboard'),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/pixelimg3.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.3),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30 , right: 30 , top: 10),
          child: Column(
            children: [
            Container(
              width: double.infinity,
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F5FA),
                border: Border.all(color: const Color(0xFF0B5D34), width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF05331C),
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF0B5D34), size: 35),
                  SizedBox(width: 12),
                  Text(
                    'TOP TACTICS',
                    style: TextStyle(
                      color: Color(0xFF0B5D34),
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                itemCount: allFetchedUsers.length > 10
                    ? 10
                    : allFetchedUsers.length,
                itemBuilder: (context, index) {
                  final user = allFetchedUsers[index];
                  if (user == null) return const SizedBox();

                  Color bgColor;
                  Color borderColor;
                  Color textColor;

                  if (index == 0) {
                    bgColor = const Color(0xFFF7ACCF);
                    borderColor = const Color(0xFF753351);
                    textColor = const Color(0xFF753351);
                  } else if (index == 1) {
                    bgColor = const Color(0xFF8AF0AC);
                    borderColor = const Color(0xFF135328);
                    textColor = const Color(0xFF135328);
                  } else if (index == 2) {
                    bgColor = const Color(0xFF91D7F9);
                    borderColor = const Color(0xFF153F4F);
                    textColor = const Color(0xFF153F4F);
                  } else {
                    bgColor = const Color(0xFFE6EEF6);
                    borderColor = const Color(0xFF808587);
                    textColor = const Color(0xFF424A53);
                  }

                  String winRateText = "0";
                  final totalGames =
                      user.gamesWon + user.gamesLost + user.gamesDrawn;

                  if (totalGames > 0) {
                    winRateText = "${((user.gamesWon / totalGames) * 100)}%";
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 23),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(color: borderColor, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: borderColor,
                          offset: const Offset(4, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 2),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(user.profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Win Rate: $winRateText%',
                                style: TextStyle(
                                  color: textColor.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                'Score: ${user.score}',
                                style: TextStyle(
                                  color: textColor.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 1st Place Star Icon
                        if (index == 0)
                          Icon(Icons.star, color: borderColor, size: 32),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),

      bottomNavigationBar: const AquaticcyBottomNavBar(currentIndex: 1),
    );
  }
}
