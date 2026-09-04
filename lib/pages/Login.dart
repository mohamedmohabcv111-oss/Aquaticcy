import 'package:aquaticcy/Services/user_service.dart';
import 'package:aquaticcy/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _passwordsMatch = true;
  final UserService _userservice = UserService();
  bool newemail = true;
  bool doesitexist = true;

  Future<void> checking(String emailController) async {
    final answer = await _userservice.checkemail(emailController);

     setState(() {
      newemail = !answer;
    });
    
  }

  Future<void> checking2(String emailController) async {
    final answer = await _userservice.checkemail(emailController);

    setState(() {
      doesitexist = answer;
    });
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  Future signUp() async {
    setState(() {
      newemail = true;
    });

    if (passwordconfirmed()) {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      final userid = credential.user!.uid;

      final user = UserModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );

      await _userservice.createUser(user, userid);
    }
  }

  bool passwordconfirmed() {
    if (_passwordController.text.trim() == _confirmpassword.text.trim()) {
      setState(() {
        _passwordsMatch = true;
      });
      return true;
    } else {
      setState(() {
        _passwordsMatch = false;
      });
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 20,
            top: 35,
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  decoration: const BoxDecoration(
                    color: Color(0xFF08683A),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF044827), width: 6.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.eco, color: Color(0xFFFFAEEB), size: 48),
                      const SizedBox(height: 16),
                      const Text(
                        'START YOUR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                      const Text(
                        'ADVENTURE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),

                    child: Column(
                      children: [
                        const TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(color: Color(0xFF08683A)),
                          labelColor: Color(0xFFFFF4D1),
                          unselectedLabelColor: Color(0xFF003366),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.2,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.2,
                          ),
                          tabs: [
                            Tab(text: "SIGN UP"),
                            Tab(text: "SIGN IN"),
                          ],
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                child: Transform.translate(
                                  offset: const Offset(0, 14),

                                  child: Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Color(0xFF003366),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'NAME',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF003366),
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2EAF8),
                                          border: Border.all(
                                            color: const Color(0xFF707A6F),
                                            width: 4.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "ENTER YOUR USERNAME...",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Courier',
                                                color: Color(0xFF5A758F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color(0xFF003366),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 13),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.email_outlined,
                                            size: 20,
                                            color: Color(0xFF003366),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'EMAIL',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF003366),
                                              letterSpacing: 1.2,
                                            ),
                                          ),

                                          if (!newemail)
                                            const Text(
                                              ' - EMAIL ALREADY IN USE',
                                              style: TextStyle(
                                                fontFamily: 'Courier',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2EAF8),
                                          border: Border.all(
                                            color: const Color(0xFF707A6F),
                                            width: 4.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: TextField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ENTER YOUR EMAIL...",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Courier',
                                                color: Color(0xFF5A758F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color(0xFF003366),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 13),

                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.vpn_key_outlined,
                                            size: 20,
                                            color: Color(0xFF003366),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'PASSWORD',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF003366),
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2EAF8),
                                          border: Border.all(
                                            color: const Color(0xFF707A6F),
                                            width: 4.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: TextField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "ENTER YOUR PASSWORD...",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Courier',
                                                color: Color(0xFF5A758F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color(0xFF003366),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 13),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.vpn_key_outlined,
                                            size: 20,
                                            color: Color(0xFF003366),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'CONFIRM PASSWORD',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF003366),
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          if (!_passwordsMatch)
                                            const Text(
                                              ' - NOT MATCHING',
                                              style: TextStyle(
                                                fontFamily: 'Courier',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2EAF8),
                                          border: Border.all(
                                            color: const Color(0xFF707A6F),
                                            width: 4.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: TextField(
                                            controller: _confirmpassword,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "CONFIRM YOUR PASSWORD...",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Courier',
                                                color: Color(0xFF5A758F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color(0xFF003366),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      GestureDetector(
                                        onTap: () async {
                                          passwordconfirmed();

                                          await checking(
                                            _emailController.text.trim(),
                                          );

                                          if (newemail) {
                                            signUp();
                                          }
                                        },
                                        child: Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.07,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF08683A),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFF044827),
                                                width: 6.0,
                                              ),
                                            ),
                                          ),

                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.login,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'SIGN UP',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: -0.5,
                                                  height: 1.1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      const Text(
                                        "New here? Sign up to play.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF003366),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SingleChildScrollView(
                                child: Transform.translate(
                                  offset: const Offset(0, 40),

                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.email_outlined,
                                            size: 20,
                                            color: Color(0xFF003366),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'EMAIL',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF003366),
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          if (!doesitexist)
                                            const Text(
                                              ' - EMAIL DOES NOT EXIST',
                                              style: TextStyle(
                                                fontFamily: 'Courier',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2EAF8),
                                          border: Border.all(
                                            color: const Color(0xFF707A6F),
                                            width: 4.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: TextField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ENTER YOUR EMAIL...",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Courier',
                                                color: Color(0xFF5A758F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color(0xFF003366),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.vpn_key_outlined,
                                            size: 20,
                                            color: Color(0xFF003366),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'PASSWORD',
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF003366),
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2EAF8),
                                          border: Border.all(
                                            color: const Color(0xFF707A6F),
                                            width: 4.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: TextField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "ENTER YOUR PASSWORD...",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Courier',
                                                color: Color(0xFF5A758F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color(0xFF003366),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 50),

                                      GestureDetector(
                                        onTap: () async {
                                          passwordconfirmed();

                                          await checking2(
                                            _emailController.text.trim(),
                                          );

                                          if (doesitexist) {
                                            signIn();
                                          }
                                        },

                                        child: Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.07,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF08683A),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFF044827),
                                                width: 6.0,
                                              ),
                                            ),
                                          ),

                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.login,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'SIGN IN',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: -0.5,
                                                  height: 1.1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 50),

                                      const Text(
                                        "Welcome back, warrior! Enter your details above \n to rejoin the AQUATICCY arena.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF003366),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
