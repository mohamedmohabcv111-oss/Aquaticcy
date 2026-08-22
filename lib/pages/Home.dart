import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/bottomnavbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AquaticcyAppBar(),

            endDrawer: const AquaticcyDrawer(),

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
                                    color: const Color(0xFFE8F0FE),

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
                                              color: Color(0xFF2D3748),
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 2.0,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Color(0xFF2D3748),
                                              size: 32,
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
                                          color: Color(0xFF2D3748),
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
                                              onPressed: () {},
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
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFF87CEEB,
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
                                              onPressed: () {},
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

            bottomNavigationBar: const AquaticcyBottomNavBar(currentIndex: 0),
    );
  }
}
