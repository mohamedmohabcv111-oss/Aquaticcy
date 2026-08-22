import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AquaticcyAppBar(),
      endDrawer: const AquaticcyDrawer(),

      body: const Center(
        child: Text('Leaderboard Page'),
      ),

      bottomNavigationBar: const AquaticcyBottomNavBar(currentIndex: 1),
    );
  }
}
