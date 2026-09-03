import 'dart:ui';
import 'package:aquaticcy/Services/game_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'audiomaster.dart';

class AquaticcyDrawer extends StatelessWidget {
  final String currentPage;
  final String? roomcode;

  const AquaticcyDrawer({super.key, required this.currentPage, this.roomcode});

  void signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Container(
          margin: EdgeInsets.only(
            top: 100, 
            bottom: currentPage == 'Profile' || currentPage == 'Ticcy'? 500 : 375, 
            left: 90
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0FE),
            border: Border.all(color: const Color(0xFF111921), width: 4),
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
                      color: Color(0xFF2D3748),
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Builder(
                    builder: (drawerContext) {
                      return IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFF2D3748),
                          size: 32,
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
                margin: const EdgeInsets.only(top: 12, bottom: 15),
                height: 4,
                decoration: const BoxDecoration(color: Color(0xFF2D3748)),
              ),
              SizedBox(height: currentPage == 'Profile' || currentPage == 'Ticcy'? 15 : 30),
              Column(
                children: [
                  const Audiomaster(),
                  
                  const SizedBox(height: 16),
                  if (currentPage == 'Ticcy') ...[
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (roomcode != null) {
                            final uid = FirebaseAuth.instance.currentUser?.uid;
                            if (uid != null) {
                              await GameServices().leavegame(roomcode!, uid);
                            }
                          }
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                          foregroundColor: const Color(0xFF111921),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                                color: Color(0xFF111921), width: 3),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.exit_to_app, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'LEAVE ROOM',
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
                  ] else ...[
                    if (currentPage != 'Profile') ...[
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFADDC),
                            foregroundColor: const Color(0xFF111921),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(
                                  color: Color(0xFF111921), width: 3),
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
                    ],

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
                        onPressed: () {
                          signout(context);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
