import 'package:aquaticcy/Services/user_service.dart';
import 'package:aquaticcy/widgets/appbar.dart';
import 'package:aquaticcy/widgets/bottomnavbar.dart';
import 'package:aquaticcy/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Choose> {
  final UserService _userservice = UserService();
  String? selectedImagePath;
  bool isSaved = false;

  void settingprofile(String imagePath) {
    setState(() {
      selectedImagePath = imagePath;
    });
  }

  Future<void> savechoice() async {
    
    if (selectedImagePath != null) {
      final firebaseuser = FirebaseAuth.instance.currentUser;
      if (firebaseuser != null) {
        
        setState(() {
          isSaved = true;
        });

        await _userservice.changeprofilepic(firebaseuser.uid,selectedImagePath!,);

        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            setState(() {
              isSaved = false;
            });
          }
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AquaticcyAppBar(),
      endDrawer: const AquaticcyDrawer(currentPage: 'Choose'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/pixelimg4.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.3),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 45,
            top: 25,
            right: 45,
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "CHOOSE YOUR\nCHARACTER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: Color(0xFF111921),
                  shadows: [Shadow(color: Colors.white, offset: Offset(2, 2))],
                ),
              ),
              const SizedBox(height: 45),

              Row(
                children: [
                  _buildCharacterCard('ZORO', 'assets/images/zoro.png'),
                  _buildCharacterCard('LUFFY', 'assets/images/luffy.png'),
                  _buildCharacterCard('NOT NAMI', 'assets/images/notnami.png'),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  _buildCharacterCard('NARUTO', 'assets/images/naruto.png'),
                  _buildCharacterCard('SASUKE', 'assets/images/Sasuke.png'),
                  _buildCharacterCard('KNIGHT', 'assets/images/knight.png'),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  _buildCharacterCard('JINBE', 'assets/images/Jinbe.png'),
                  _buildCharacterCard('ALIEN GIRL', 'assets/images/girl.png'),
                  _buildCharacterCard('CHOPPER', 'assets/images/chopper.png'),
                ],
              ),

              const SizedBox(height: 50),

              Container(
                width: 200,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Color(0xFF111921), offset: Offset(4, 4)),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    savechoice();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 127, 207, 253),
                    foregroundColor: const Color(0xFF111921),
                    padding: const EdgeInsets.symmetric(vertical: 14), 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Color(0xFF111921), width: 3),
                    ),
                  ),
                  child: const Text(
                    'SAVE CHOICE',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),

              if (isSaved)
                const SizedBox(height: 10), 

              if (isSaved)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6), 
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50), 
                    border: Border.all(color: const Color(0xFF111921), width: 3),
                    boxShadow: const [
                      BoxShadow(color: Color(0xFF111921), offset: Offset(2, 2)),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_box, color: Colors.white, size: 14),
                      SizedBox(width: 8),
                      Text(
                        'SAVED SUCCESSFULLY',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AquaticcyBottomNavBar(
        currentIndex: 0,
        showActive: false,
      ),
    );
  }

  Widget _buildCharacterCard(String name, String imagePath) {
    bool isSelected = selectedImagePath == imagePath;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color(0xFF111921), offset: Offset(4, 4)),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            settingprofile(imagePath);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? const Color(0xFFFFADDC)
                : const Color(0xFFE8F0FE),
            foregroundColor: const Color(0xFF111921),
            padding: const EdgeInsets.all(8.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Color(0xFF111921), width: 3),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF111921), width: 2),
                ),
                child: Image.asset(
                  imagePath,
                  height: 55,
                  width: 55,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
