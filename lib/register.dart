import 'dart:developer';

import 'package:e_commerce_app/login.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  registration(String name, phone, address, username, password) async {
    print('Webservice');
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> Data = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
      body: Data,
    );
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        print(response.statusCode);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginPage();
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
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Register Account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Complete your details",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              name = text;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: "Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Name';
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
                              phone = text;
                            });
                          },
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your phone number";
                            } else if (value.length > 10 || value.length < 10) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: "Phone",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: textfeildcolor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          maxLines: 4,
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: "Address",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      //color: Color.fromARGB(255, 188, 189, 188),
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
                              return 'Enter Your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: textfeildcolor,
                      //color: textfeildcolor,
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
                            hintText: "password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                        //_formKey.currentState!.validate();
                        if (_formKey.currentState!.validate()) {
                          print("name = " + name.toString());
                          print("phone = " + phone.toString());
                          print("address = " + address.toString());

                          print("username = " + username.toString());
                          print("password = " + password.toString());
                          registration(
                              name!, phone, address, username, password);
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do you have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }),
                        );
                      },
                      child: Text(
                        "Login",
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
