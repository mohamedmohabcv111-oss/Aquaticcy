import 'package:flutter/material.dart';

class AquaticcyBottomNavBar extends StatelessWidget {
  const AquaticcyBottomNavBar({super.key, required this.currentIndex, this.showActive = true});

  final int currentIndex;
  final bool showActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF677672), width: 3),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFFE8F0FE),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,

      onTap: (index) {
        final currentRoute = ModalRoute.of(context)?.settings.name;

        if (index == 1 && currentRoute != '/leaderboard') {
          Navigator.pushNamed(context, '/leaderboard');
        } else if (index == 0 && currentRoute != '/home') {
          if (Navigator.canPop(context)) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 130,
            height: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.sports_esports,
                  color: Color(0xFF284055),
                ),
                SizedBox(height: 4),
                Text(
                  'BATTLE',
                  style: TextStyle(
                    color: Color(0xFF284055),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          activeIcon: showActive 
          ? Container(
            width: 130,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFFFADDC),
              border: Border.all(
                color: const Color(0xFF192126),
                width: 3,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF192126),
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.sports_esports,
                  color: Color(0xFF713B5D),
                ),
                SizedBox(height: 2),
                Text(
                  'BATTLE',
                  style: TextStyle(
                    color: Color(0xFF713B5D),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
          : SizedBox(
            width: 130,
            height: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.sports_esports,
                  color: Color(0xFF284055),
                ),
                SizedBox(height: 4),
                Text(
                  'BATTLE',
                  style: TextStyle(
                    color: Color(0xFF284055),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          label: 'BATTLE',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 130,
            height: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.emoji_events,
                  color: Color(0xFF284055),
                ),
                SizedBox(height: 4),
                Text(
                  'LEADERBOARD',
                  style: TextStyle(
                    color: Color(0xFF284055),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          activeIcon: showActive 
          ? Container(
            width: 130,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFFFADDC),
              border: Border.all(
                color: const Color(0xFF192126),
                width: 3,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF192126),
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.emoji_events,
                  color: Color(0xFF713B5D),
                ),
                SizedBox(height: 2),
                Text(
                  'LEADERBOARD',
                  style: TextStyle(
                    color: Color(0xFF713B5D),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
          : SizedBox(
            width: 130,
            height: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.emoji_events,
                  color: Color(0xFF284055),
                ),
                SizedBox(height: 4),
                Text(
                  'LEADERBOARD',
                  style: TextStyle(
                    color: Color(0xFF284055),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          label: 'LEADERBOARD',
        ),
      ],
      ),
    );
  }
}
