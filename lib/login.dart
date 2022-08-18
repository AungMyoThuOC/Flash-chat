import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPass = true;
  bool valid = false;

  bool submit = false;

  bool check = false;

  bool isLoading = false;

  final _fromKey = GlobalKey<FormState>();

  TextEditingController userCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.teal,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.voice_chat,
      //       ),
      //     )
      //   ],
      // ),
      body: Form(
        key: _fromKey,
        child: Center(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/lognig.jpg'), fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Text(
                  //   'Welcome to this Webside!',
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  // ),
                  // ClipRRect(
                  //   child: Container(
                  //     height: 200,
                  //     decoration: const BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage('images/'),
                  //         fit: BoxFit.fill,
                  //       )
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.amber,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.help_center,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                  Image(
                    width: 360,
                    height: 320,
                    image: AssetImage('images/chat.gif'),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.amber),
                    cursorColor: Colors.white,
                    controller: userCont,
                    validator: (user) {
                      if (user == null || user.isEmpty) {
                        return "Username can't be blank";
                      } else if (user.length < 6) {
                        return "Username  should be more than 6 word";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.amber),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.amber),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.amber,
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.amber),
                    cursorColor: Colors.white,
                    controller: passCont,
                    obscuringCharacter: "*",
                    obscureText: showPass,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Password can't be blank";
                      } else if (password.length < 6) {
                        return "Password should be 6 word";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.amber),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(color: Colors.amber),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.amber,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPass = !showPass;
                              });
                            },
                            splashRadius: 5,
                            icon: showPass
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.amber,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.amber,
                                  ))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await Future.delayed(const Duration(seconds: 3));
                              setState(() {
                                isLoading = false;
                              });
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final String? username =
                                  prefs.getString('username');
                              final String? password =
                                  prefs.getString("password");
                              final loginValidate =
                                  _fromKey.currentState!.validate();

                              if (loginValidate) {
                                try {
                                  final _auth = FirebaseAuth.instance;

                                  UserCredential currentUser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: userCont.text,
                                          password: passCont.text);
                                } catch (e) {
                                  print(e.toString());
                                } finally {
                                  Navigator.pushReplacementNamed(
                                      context, '/chat');
                                }
                              }
                              if (userCont.text == username &&
                                  passCont.text == password) {
                                // Navigator.pushNamed(context, '/chat');
                                // Navigator.pushReplacementNamed(
                                //     context, "/chat");
                                userCont.clear();
                                passCont.clear();
                              } else {
                                if (userCont.text.isNotEmpty &&
                                    passCont.text.isNotEmpty) {
                                  var snackBar = const SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                    content: Text("Invalid email or password"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Container();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(235, 229, 60, 60)),
                            child: (isLoading)
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1.5,
                                    ),
                                  )
                                : const Text("LogIN")),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do you have an account?",
                        style: TextStyle(color: Colors.white60),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/chat');
                          },
                          child: const Text(
                            'Signin',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
