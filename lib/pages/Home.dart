import 'dart:ui';
import 'package:aquaticcy/Services/game_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/bottomnavbar.dart';
import 'package:aquaticcy/widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _gameIDcontroller = TextEditingController();
  final GameServices _gameservices = GameServices();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> creatinggame(BuildContext dialogContext) async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final roomcode = await _gameservices.creategame(userid);

    Navigator.pop(dialogContext);
    Navigator.pushNamed(context, '/ticcy', arguments: roomcode);
  }

  Future<bool> joininggame(String code, BuildContext joinDialogContext) async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final success = await _gameservices.joingame(code, userid);

    if (success) {
      _gameIDcontroller.clear();
      Navigator.pop(joinDialogContext);
      Navigator.pushNamed(context, '/ticcy', arguments: code);
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _gameIDcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AquaticcyAppBar(),

      endDrawer: const AquaticcyDrawer(currentPage: 'Home'),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/pixelimg1.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.3),
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
                  BoxShadow(color: Color(0xFF111921), offset: Offset(6, 6)),
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
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),

                        child: Dialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),

                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
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
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xFF111921),
                                            offset: Offset(3, 3),
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

                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            side: const BorderSide(
                                              color: Color(0xFF111921),
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
                                        onPressed: () {
                                          creatinggame(dialogcontext);
                                        },
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xFF111921),
                                            offset: Offset(3, 3),
                                          ),
                                        ],
                                      ),

                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF87CEEB,
                                          ),
                                          foregroundColor: const Color.fromARGB(
                                            255,
                                            0,
                                            0,
                                            0,
                                          ),

                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            side: const BorderSide(
                                              color: Color(0xFF111921),
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
                                        onPressed: () {
                                          Navigator.pop(dialogcontext);
                                          bool showJoinError = false;

                                          showDialog(
                                            context: context,
                                            builder: (joinDialogContext) {
                                              return StatefulBuilder(
                                                builder: (context, setDialogState) {
                                                  final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
                                                  return Stack(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    children: [
                                                      BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                              sigmaX: 4.0,
                                                              sigmaY: 4.0,
                                                            ),
                                                        child: Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                          insetPadding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 30,
                                                              ),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                0.85,
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  24,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xFFE8F0FE,
                                                                  ),
                                                              border: Border.all(
                                                                color:
                                                                    const Color(
                                                                      0xFF111921,
                                                                    ),
                                                                width: 4,
                                                              ),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Color(
                                                                    0xFF111921,
                                                                  ),
                                                                  offset:Offset( 8,8,),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'JOIN ROOM',
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                          0xFF2D3748,
                                                                        ),
                                                                        fontSize:
                                                                            32,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        letterSpacing:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Color(
                                                                          0xFF2D3748,
                                                                        ),
                                                                        size:
                                                                            32,
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.of(
                                                                          joinDialogContext,
                                                                        ).pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin:
                                                                      const EdgeInsets.only(
                                                                        top: 12,
                                                                      ),
                                                                  height: 4,
                                                                  decoration: const BoxDecoration(
                                                                    color: Color(
                                                                      0xFF2D3748,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 35,
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                      color: const Color(
                                                                        0xFF111921,
                                                                      ),
                                                                      width: 3,
                                                                    ),
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Color(
                                                                          0xFF111921,
                                                                        ),
                                                                        offset:
                                                                            Offset(
                                                                              4,
                                                                              4,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: TextField(
                                                                    controller:
                                                                        _gameIDcontroller,
                                                                    style: const TextStyle(
                                                                      color: Color(
                                                                        0xFF111921,
                                                                      ),
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      letterSpacing:
                                                                          2.0,
                                                                    ),

                                                                    decoration: InputDecoration(
                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            20,
                                                                        horizontal:
                                                                            16,
                                                                      ),
                                                                      hintText:
                                                                          'ENTER ROOM CODE...',
                                                                      hintStyle: TextStyle(
                                                                        color:
                                                                            const Color(
                                                                              0xFF111921,
                                                                            ).withValues(
                                                                              alpha: 0.5,
                                                                            ),
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        letterSpacing:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          12,
                                                                        ),
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Color(
                                                                          0xFF111921,
                                                                        ),
                                                                        offset:
                                                                            Offset(
                                                                              3,
                                                                              3,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          const Color(
                                                                            0xFF4ADE80,
                                                                          ),
                                                                      foregroundColor:
                                                                          const Color(
                                                                            0xFF111921,
                                                                          ),
                                                                      padding: const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            20,
                                                                      ),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              12,
                                                                            ),
                                                                        side: const BorderSide(
                                                                          color: Color(
                                                                            0xFF111921,
                                                                          ),
                                                                          width:
                                                                              3,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed: () async {
                                                                      final success = await joininggame(
                                                                        _gameIDcontroller
                                                                            .text,
                                                                        joinDialogContext,
                                                                      );
                                                                      if (!success) {
                                                                        setDialogState(() {
                                                                          showJoinError =
                                                                              true;
                                                                        });
                                                                        Future.delayed(
                                                                          const Duration(
                                                                            milliseconds: 600),
                                                                          () {
                                                                            if (mounted) {
                                                                              setDialogState(
                                                                                () {
                                                                                  showJoinError = false;
                                                                                },
                                                                              );
                                                                            }
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                      'ENTER',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        letterSpacing:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (showJoinError)
                                                        Positioned(
                                                          bottom: isKeyboardVisible? 350 : 200,
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        40,
                                                                    vertical: 6,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                border: Border.all(
                                                                  color: const Color(
                                                                    0xFF111921,
                                                                  ),
                                                                  width: 3,
                                                                ),
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Color(
                                                                      0xFF111921,
                                                                    ),
                                                                    offset:
                                                                        Offset(
                                                                          2,
                                                                          2,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    'ROOM NOT FOUND OR FULL',
                                                                    style: TextStyle(
                                                                      fontFamily:
                                                                          'Courier',
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
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
