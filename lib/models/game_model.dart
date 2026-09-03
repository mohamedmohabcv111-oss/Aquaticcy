import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String player1Uid;
  final String? player2Uid;
  final List<String> board;
  final String currentTurn;
  final String status;
  final String? winner;

  GameModel({
    required this.player1Uid,
    this.player2Uid,
    this.board = const ['', '', '', '', '', '', '', '', ''],
    required this.currentTurn,
    this.status = 'waiting',
    this.winner,
  });

  Map<String, dynamic> toMap() {
    return {
      'player1_uid': player1Uid,
      'player2_uid': player2Uid,
      'board': board,
      'currentTurn': currentTurn,
      'status': status,
      'winner': winner,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      player1Uid: map['player1_uid'] ?? '',
      player2Uid: map['player2_uid'],
      board: List<String>.from(
        map['board'] ?? const ['', '', '', '', '', '', '', '', ''],
      ),
      currentTurn: map['currentTurn'] ?? '',
      status: map['status'] ?? 'waiting',
      winner: map['winner'],
    );
  }
}
