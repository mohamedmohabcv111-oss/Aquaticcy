import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../models/game_model.dart';

class GameServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateroomcode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String code = '';

    for (int i = 0; i < 4; i++) {
      int randomposition = Random().nextInt(chars.length);
      code = code + chars[randomposition];
    }

    return code;
  }


  Future<String> creategame(String myuid) async {
    final roomcode = generateroomcode();

    final newGame = GameModel(player1Uid: myuid, currentTurn: myuid);

    await _firestore.collection('games').doc(roomcode).set(newGame.toMap());

    return roomcode;
  }




  Future<bool> joingame(String roomcode, String myuid) async {
    final docpointer = _firestore.collection("games").doc(roomcode);
    final document = await docpointer.get();

    if (!document.exists) {
      return false;
    }

    final data = GameModel.fromMap(document.data()!);

    if (data.player2Uid != null) {
      return false;
    }

    await docpointer.update({'player2_uid': myuid, 'status': 'playing'});

    return true;
  }



  Future<void> makeMove({required String roomcode,required int cellIndex, required String symbol,required String nextTurnUid,}) async {
    final docpointer = _firestore.collection('games').doc(roomcode);
    final doc = await docpointer.get();

    final game = GameModel.fromMap(doc.data()!);
    final board = game.board;

    board[cellIndex] = symbol;

    await docpointer.update({'board': board, 'currentTurn': nextTurnUid});
  }

  String? checkWinner(List<String> board) {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      final a = board[pattern[0]];
      final b = board[pattern[1]];
      final c = board[pattern[2]];

      if (a != '' && a == b && b == c) {
        return a;
      }
    }

    if (!board.contains('')) {
      return 'draw';
    }

    return null;
  }

  Future<void> leavegame(String roomcode, String uid) async {
    final docpointer = _firestore.collection("games").doc(roomcode);
    final doc = await docpointer.get(); 

    if (!doc.exists) return;

    final data = GameModel.fromMap(doc.data()!);
   
    
    if (data.player1Uid == uid) {
      await docpointer.delete();

    } else if (data.player2Uid == uid) {
    
      await docpointer.update({
        'player2_uid': null,
        'status': 'waiting',
        'board' : null
      });
    }
  }

  Future<void> endgame(String roomcode, String? uid) async {
    await _firestore.collection("games").doc(roomcode).update({
      'status': "finished",
      'winner': uid,
    });
  }

  Stream<DocumentSnapshot> watchGame(String roomcode) {
    return _firestore.collection('games').doc(roomcode).snapshots();
  }
}
