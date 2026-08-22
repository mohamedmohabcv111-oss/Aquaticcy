import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreService {
  //get collections
  final CollectionReference Users = FirebaseFirestore.instance.collection(
    'users',
  );

  //create
  
  //read:getting user info for profile page and for leaderboard

  //update:for alaot of things
}
