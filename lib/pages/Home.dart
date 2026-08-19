import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: const Color(0xFF076735),
              foregroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 70,

              shape: const Border(
                bottom: BorderSide(color: Color(0xFF044824), width: 8),
              ),

              title: Padding(
                padding: const EdgeInsets.all(22),

                child: Row(
                  children: [
                    const Icon(Icons.grid_view_outlined, size: 32),
                    const SizedBox(width: 12),

                    const Text(
                      'AQUATICCY',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            endDrawer: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Drawer(
                backgroundColor: Colors.transparent,
                elevation: 0,
                width: MediaQuery.of(context).size.width * 0.85,

                child: Container(
                  margin: const EdgeInsets.only(
                    top: 100,
                    bottom: 450,
                    left: 90,
                  ),
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFF0F7038),
                    border: Border.all(
                      color: const Color(0xFF111921),
                      width: 4,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF111921), offset: Offset(8, 8)),
                    ],
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'OPTIONS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Color(0xFF111921),
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (drawerContext) {
                              return IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 32,
                                  shadows: [
                                    Shadow(
                                      color: Color(0xFF111921),
                                      offset: Offset(3, 3),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(drawerContext).pop();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 24),
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF111921),
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [

                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFADDC),
                                foregroundColor: const Color(0xFF111921),
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(color: Color(0xFF111921), width: 3),
                                ),
                              ),
                              
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'PROFILE',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF111921),
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(color: Color(0xFF111921), width: 3),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.logout, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'LOGOUT',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/pixelimg1.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withValues(alpha: 0.5),
                    BlendMode.srcOver,
                  ),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF111921),
                          offset: Offset(6, 6),
                        ),
                      ],
                    ),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F7038),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Color(0xFF111921), width: 4),
                        ),

                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 40),
                      ),

                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'START',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Color(0xFF111921),
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            'FIND OPPONENT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF5DB37E),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),

                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogcontext) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 4.0,
                                sigmaY: 4.0,
                              ),

                              child: Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),

                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  padding: const EdgeInsets.all(24),

                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F7038),

                                    border: Border.all(
                                      color: const Color(0xFF111921),
                                      width: 4,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF111921),
                                        offset: Offset(8, 8),
                                      ),
                                    ],
                                  ),

                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'CHOOSE',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 2.0,
                                              shadows: [
                                                Shadow(
                                                  color: Color(0xFF111921),
                                                  offset: Offset(3, 3),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 32,
                                              shadows: [
                                                Shadow(
                                                  color: Color(0xFF111921),
                                                  offset: Offset(3, 3),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(dialogcontext).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 12),
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF111921),
                                              offset: Offset(3, 3),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 35),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(4, 4),
                                                ),
                                              ],
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFFFFADDC,
                                                ),
                                                foregroundColor: const Color(
                                                  0xFF111921,
                                                ),

                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                    ),

                                                shape:
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      side: BorderSide(
                                                        color: Color(
                                                          0xFF111921,
                                                        ),
                                                        width: 3,
                                                      ),
                                                    ),
                                              ),
                                              child: const Text(
                                                'CREATE GAME',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 2.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 16),

                                          Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFF111921),
                                                  offset: Offset(4, 4),
                                                ),
                                              ],
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                      255,
                                                      255,
                                                      255,
                                                      255,
                                                    ),
                                                foregroundColor:
                                                    const Color.fromARGB(
                                                      255,
                                                      0,
                                                      0,
                                                      0,
                                                    ),

                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                    ),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      side: BorderSide(
                                                        color: Color(
                                                          0xFF111921,
                                                        ),
                                                        width: 3,
                                                      ),
                                                    ),
                                              ),
                                              child: const Text(
                                                'JOIN GAME',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 2.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            bottomNavigationBar: Container(
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

                items: [
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      width: 130,
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_esports,
                            color: const Color(0xFF284055),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'BATTLE',
                            style: const TextStyle(
                              color: Color(0xFF284055),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    activeIcon: Container(
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
                        children: [
                          Icon(
                            Icons.sports_esports,
                            color: const Color(0xFF713B5D),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'BATTLE',
                            style: const TextStyle(
                              color: Color(0xFF713B5D),
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

                        children: [
                          Icon(
                            Icons.emoji_events,
                            color: const Color(0xFF284055),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'LEADERBOARD',
                            style: const TextStyle(
                              color: Color(0xFF284055),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    activeIcon: Container(
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
                        children: [
                          Icon(
                            Icons.emoji_events,
                            color: const Color(0xFF713B5D),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'LEADERBOARD',
                            style: const TextStyle(
                              color: Color(0xFF713B5D),
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
            ),
          );
        },
      ),
    );
  }
}
