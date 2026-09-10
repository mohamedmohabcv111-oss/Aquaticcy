
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:aquaticcy/widgets/audiomaster.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aquaticcy/Services/game_services.dart';
import 'package:aquaticcy/Services/user_service.dart';
import 'package:aquaticcy/models/game_model.dart';
import 'package:aquaticcy/models/user_model.dart';
import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/drawer.dart';

class Ticcy extends StatefulWidget {
  const Ticcy({super.key});

  @override
  State<Ticcy> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Ticcy> {
  final GameServices _gameservices = GameServices();
  final UserService _userservice = UserService();

  bool _gameEndHandled = false;
  bool _showCopied = false;
  bool _hasPlayedSound = false;

  UserModel? _player1Data;
  UserModel? _player2Data;

  Future<void> loadplayerdata(String player1UID, String? player2UID) async {

    if (_player1Data == null) {
      final p1 = await _userservice.getuser(player1UID);

      if (mounted) {
        setState(() {
          _player1Data = p1;
        });
      }
    }

    if (player2UID != null && _player2Data == null) {
      final p2 = await _userservice.getuser(player2UID);

      if (mounted) {
        setState(() {
          _player2Data = p2;
        });
      }
    } else if (player2UID == null && _player2Data != null) {
      if (mounted) {
        setState(() {
          _player2Data = null;
        });
      }
    }
  }

  Future<void> _handleGameEnd(String result,Map<String, dynamic> data,String roomcode,) async {
    final player1 = data['player1_uid'];
    final player2 = data['player2_uid'];

    if (result == 'draw') {
      await _gameservices.endgame(roomcode, 'draw');
      await _userservice.addDraw(player1);
      await _userservice.addDraw(player2);
    } else {
      final winnerUid = (result == 'X') ? player1 : player2;
      final loserUid = (result == 'X') ? player2 : player1;

      await _gameservices.endgame(roomcode, winnerUid);
      await _userservice.addWin(winnerUid);
      await _userservice.addLoss(loserUid);
    }
  }

  @override
  void initState() {
    super.initState();
    playGameMusic();
  }

  @override
  void dispose() {
    playMenuMusic();
    super.dispose();
  }

  TextStyle _getSymbolStyle(String symbol) {
    return TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w900,
      height: 1.0,
      color: symbol == 'X' ? const Color(0xFFFFADDC) : const Color(0xFF7DD3FC),
      shadows: const [Shadow(color: Color(0xFF111921), offset: Offset(2, 2))],
    );
  }

  @override
  Widget build(BuildContext context) {
    final roomcode = ModalRoute.of(context)!.settings.arguments as String;
    final myUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AquaticcyAppBar(),

      endDrawer: AquaticcyDrawer(currentPage: 'Ticcy', roomcode: roomcode),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/Faceoff.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.3),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: _gameservices.watchGame(roomcode),
          
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.data!.exists || snapshot.data!.data() == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.popUntil(context, (route) => route.isFirst);
              });
              return const SizedBox.shrink();
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final game = GameModel.fromMap(data);

            loadplayerdata(data['player1_uid'], data['player2_uid']);
            final mySymbol = (myUid == data['player1_uid']) ? 'X' : 'O';
            final isMyTurn = game.currentTurn == myUid;

            if (game.status == 'playing') {
              final result = _gameservices.checkWinner(game.board);
              if (result != null && !_gameEndHandled) {
                _gameEndHandled = true;
                _handleGameEnd(result, data, roomcode);
              }
            }

            Widget finishedScreen = const SizedBox.shrink();

            if (game.status == 'finished') {
              String message;
              Color messageColor;

              if (game.winner == 'draw') {
                message = "IT'S A DRAW!";
                messageColor = const Color.fromARGB(255, 222, 177, 248);
                if (!_hasPlayedSound) {
                  _hasPlayedSound = true;
                  playsound(2);
                }
              } else if (game.winner == myUid) {
                message = 'YOU WON!';
                messageColor = const Color(0xFF4ADE80);
                if (!_hasPlayedSound) {
                  _hasPlayedSound = true;
                  playsound(1);
                }
              } else {
                message = 'YOU LOST.';
                messageColor = const Color.fromARGB(255, 255, 0, 0);
                if (!_hasPlayedSound) {
                  _hasPlayedSound = true;
                  playsound(0);
                }
              }

              finishedScreen = Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Center(
                    child: Container(
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
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              color: messageColor,
                              shadows: const [
                                Shadow(
                                  color: Color(0xFF111921),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.popUntil(context, (route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                255,
                                0,
                                0,
                              ),
                              foregroundColor: const Color(0xFF111921),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.exit_to_app, size: 24),
                                SizedBox(width: 12),
                                Text(
                                  'LEAVE ROOM',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FE),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    if (_player1Data != null)
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFF111921),
                                            width: 2,
                                          ),
                                        ),
                                        child: Image.asset(
                                          _player1Data!.profilePicture,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _player1Data?.name.toUpperCase() ??
                                          'PLAYER 1',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF111921),
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFADDC),
                                  ),
                                  child: const Text(
                                    "VS",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF6B4C5A),
                                    ),
                                  ),
                                ),

                                _player2Data == null
                                    ? _buildWaitingBadge()
                                    : Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xFF111921),
                                                width: 2,
                                              ),
                                            ),
                                            child: Image.asset(
                                              _player2Data!.profilePicture,
                                              width: 55,
                                              height: 55,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            _player2Data!.name.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF111921),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F0FE),
                                  border: Border.all(
                                    color: const Color(0xFF111921),
                                    width: 4,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFF111921),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "ROOM CODE:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.0,
                                        color: Color(0xFF2D3748),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      roomcode,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2.0,
                                        color: Color(0xFF111921),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(text: roomcode),
                                        );
                                        setState(() {
                                          _showCopied = true;
                                        });
                                        Future.delayed(
                                          const Duration(milliseconds: 600),
                                          () {
                                            if (mounted) {
                                              setState(() {
                                                _showCopied = false;
                                              });
                                            }
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 20,
                                        color: Color(0xFF111921),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_showCopied)
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50),
                                    border: Border.all(
                                      color: const Color(0xFF111921),
                                      width: 3,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF111921),
                                        offset: Offset(3, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_box,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'COPIED',
                                        style: TextStyle(
                                          fontFamily: 'Courier',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 40,
                              bottom: 20,
                              left: 15,
                              right: 15,
                            ),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 9,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    final canTap =
                                        isMyTurn && game.board[index] == '';
                                    if (canTap) {
                                      final otheruid =
                                          (myUid == data['player1_uid'])
                                          ? data['player2_uid']
                                          : data['player1_uid'];

                                      _gameservices.makeMove(
                                        roomcode: roomcode,
                                        cellIndex: index,
                                        symbol: mySymbol,
                                        nextTurnUid: otheruid,
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xFF111921),
                                        width: 4,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xFF111921),
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        game.board[index],
                                        style: game.board[index].isNotEmpty
                                            ? _getSymbolStyle(game.board[index])
                                            : const TextStyle(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 25),

                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: data['player2_uid'] == null
                                    ? Colors.grey.shade300
                                    : isMyTurn
                                        ? const Color(0xFF4ADE80)
                                        : const Color(0xFFFF5252),
                              ),
                              child: Text(
                                data['player2_uid'] == null ? 'WAITING...' : isMyTurn ? 'YOUR TURN' : "OPPONENT'S TURN",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0,
                                  color: data['player2_uid'] == null
                                      ? const Color(0xFF111921)
                                      : isMyTurn
                                          ? const Color(0xFF0F7038)
                                          : const Color(0xFF5C0000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                finishedScreen,
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _buildWaitingBadge() {
  return Column(
    children: [
      Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: const Color(0xFF111921), width: 2),
        ),
        child: const Center(
          child: Icon(Icons.person_outline, size: 28, color: Color(0xFF111921)),
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'WAITING...',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Color(0xFF111921),
        ),
      ),
    ],
  );
}
