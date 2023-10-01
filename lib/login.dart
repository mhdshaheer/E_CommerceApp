import 'dart:developer';

import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/register.dart';
import 'package:e_commerce_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  login(String? username, password) async {
    print(username);
    final Map<String, dynamic> LoginData = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse("http://bootcamp.cyralearnings.com/login.php"),
      body: LoginData,
    );
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        print(response.statusCode);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 150),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Login with your username and password",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: textfeildcolor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: "Username",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: textfeildcolor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: "Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: maincolor,
                      ),
                      onPressed: () {
                        _formKey.currentState!.validate();
                        if (_formKey.currentState!.validate()) {
                          log("username = " + username.toString());
                          log("password = " + password.toString());

                          login(username, password);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return RegisterPage();
                          }),
                        );
                      },
                      child: Text(
                        "Go to Register",
                        style: TextStyle(
                          fontSize: 16,
                          color: maincolor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
