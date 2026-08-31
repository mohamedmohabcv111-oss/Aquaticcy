import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user, String uid) async {
    await _firestore.collection('users').doc(uid).set(user.toMap());
  }

  Future<UserModel?> getuser(String uid) async {
    final document = await _firestore.collection('users').doc(uid).get();

    if (!document.exists) {
      return null;
    }

    return UserModel.fromMap(document.data()!);
  }

  Future<List<UserModel?>> getallusers() async {
    final snapshot = await _firestore.collection("users").get();
    List<UserModel?> allUsers = [];

    for (var document in snapshot.docs) {
      final user = UserModel.fromMap(document.data());
      allUsers.add(user);
    }
    return allUsers;
  }

  Future<void> changeprofilepic(String uid , String imagepath) async {
    await _firestore.collection("users").doc(uid).update({
      'profilePicture' : imagepath,
    });
  }

  Future<void> addWin(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'gamesWon': FieldValue.increment(1),
      'score': FieldValue.increment(100),
    });
  }

  Future<void> addDraw(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'gamesDrawn': FieldValue.increment(1),
      'score': FieldValue.increment(25),
    });
  }

  Future<void> addLoss(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'gamesLost': FieldValue.increment(1),
    });
  }
}
