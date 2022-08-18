import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showpass = true;
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
      //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
      //   elevation: 0.0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.live_help,
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
                    image: AssetImage('images/registerbg.webp'),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.amber,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: (){},
                  //       icon: Icon(Icons.arrow_back)
                  //     )
                  //   ],
                  // ),
                  Image(
                    width: 300,
                    height: 300,
                    image: AssetImage('images/chatbot.png'),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.amber),
                    cursorColor: Colors.white,
                    controller: userCont,
                    validator: (user) {
                      if (user == null || user.isEmpty) {
                        return "Username can't be blank";
                      } else if (user.length < 6) {
                        return "Username should be more than 6 word";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.amber),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.amber),
                        prefixIcon: Icon(
                          Icons.email,
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
                    obscureText: showpass,
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
                        labelStyle: TextStyle(color: Colors.amber),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(color: Colors.amber),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.amber,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showpass = !showpass;
                              });
                            },
                            splashRadius: 5,
                            icon: showpass
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
                    height: 30,
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
                          final usernameValid = _fromKey.currentState!.validate();
                          if (usernameValid) {
                            try {
                              final _auth = FirebaseAuth.instance;
              
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: userCont.text,
                                      password: passCont.text);
                            } catch (e) {
                              print(e);
                            }
                          }
                          setState(() {
                            submit = true;
                          });
                          if (_fromKey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('userValue', userCont.text);
                            prefs.setString('passValue', passCont.text);
                            setState(() {
                              Navigator.pushNamed(context, '/login');
                              userCont.clear();
                              passCont.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(235, 229, 60, 60)),
                        child: (isLoading)
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
                                ),
                              )
                            : const Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do you have an account?",
                        style: TextStyle(color: Colors.white60),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'login',
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
