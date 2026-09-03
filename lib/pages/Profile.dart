import 'package:aquaticcy/Services/user_service.dart';
import 'package:aquaticcy/models/user_model.dart';
import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/bottomnavbar.dart';
import 'package:aquaticcy/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Profile> {
  final UserService _userservice = UserService();
  UserModel? userdata;

  Future<void> _fetchusers() async {
    final firebaseuser = FirebaseAuth.instance.currentUser;
    

    if (firebaseuser != null) {
      final user = await _userservice.getuser(firebaseuser.uid);

      setState(() {
        userdata = user;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchusers();
  }

  @override
  Widget build(BuildContext context) {
    String winRateText = "0%";

    if (userdata != null) {
      final totalGames =
          userdata!.gamesWon + userdata!.gamesLost + userdata!.gamesDrawn;

      if (totalGames > 0) {
        winRateText = "${((userdata!.gamesWon / totalGames) * 100).toInt()}%";
      }
    }

    return Scaffold(
      appBar: AquaticcyAppBar(),

      endDrawer: const AquaticcyDrawer(currentPage: 'Profile'),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/pixelimg2.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.3),
              BlendMode.srcOver,
            ),
          ),
        ),
        
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
              top: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FB),
                    border: Border.all(
                      color: const Color(0xFF111921),
                      width: 4.0,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF111921), offset: Offset(4, 4)),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF111921),
                            width: 4,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF111921),
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          userdata?.profilePicture ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userdata?.name.toUpperCase() ?? "",
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color(0xFF111921),
                              ),
                            ),
                            const SizedBox(height: 12),

                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF111921),
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/choose');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B4E73),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                      color: Color(0xFF111921),
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.style,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'CHANGE SKIN',
                                      style: TextStyle(
                                        fontFamily: 'Courier',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),

                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 135, 221, 255),
                    border: Border.all(
                      color: const Color(0xFF111921),
                      width: 4.0,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF111921), offset: Offset(3, 3)),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "WIN RATE",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                                color: Color(0xFF0B597B),
                                shadows: [
                                  Shadow(
                                    color: Colors.white,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              winRateText,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF111921),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF111921),
                              width: 4.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF111921),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.trending_up,
                            size: 45,
                            color: Color(0xFF0B597B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 163, 255),
                    border: Border.all(
                      color: const Color(0xFF111921),
                      width: 4.0,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF111921), offset: Offset(3, 3)),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "SCORE",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                                color: Color.fromARGB(255, 141, 11, 153),
                                shadows: [
                                  Shadow(
                                    color: Colors.white,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userdata?.score.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF111921),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 254, 255, 255),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xFF111921),
                              width: 4.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF111921),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.sports_esports,
                            size: 45,
                            color: Color.fromARGB(255, 164, 115, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),

      bottomNavigationBar: const AquaticcyBottomNavBar(
        currentIndex: 0,
        showActive: false,
      ),
    );
  }
}
