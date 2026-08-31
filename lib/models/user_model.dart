import 'package:flutter/cupertino.dart';

class UserModel {
  final String name;
  final String email;
  final String profilePicture;
  final int gamesWon;
  final int gamesLost;
  final int gamesDrawn;
  final int score;

  UserModel({
    required this.name,
    required this.email,
    this.profilePicture = 'assets/warroir.png',
    this.gamesWon = 0,
    this.gamesLost = 0,
    this.gamesDrawn = 0,
    this.score = 0,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'gamesWon': gamesWon,
      'gamesLost': gamesLost,
      'gamesDrawn': gamesDrawn,
      'score': score,
    };
  }

 
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profilePicture'] ?? 'assets/warroir.png',
      gamesWon: map['gamesWon'] ?? 0,
      gamesLost: map['gamesLost'] ?? 0,
      gamesDrawn: map['gamesDrawn'] ?? 0,
      score: map['score'] ?? 0,
    );
  }
  
}
