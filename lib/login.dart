import 'package:flutter/material.dart';
import 'package:project_admin/home.dart';
import 'package:project_admin/regis.dart';
import 'package:project_admin/user_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController cMail = TextEditingController();
  final TextEditingController cPass = TextEditingController();
  final supabase = Supabase.instance.client;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) return "Please enter a valid Email";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(238, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image.asset("img/login.png", width: 250, height: 250),
                Text(
                  "Hello",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome Back",
                  style: TextStyle(color: Color(0xff000000), fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: cMail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email Masih Kosong";
                    }
                    return validateEmail(value);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: cPass,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Masih Kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0000EF),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final sm = ScaffoldMessenger.of(context);
                        try {
                          final AuthResponse = await supabase.auth
                              .signInWithPassword(
                                  password: cPass.text, email: cMail.text);

                          if (AuthResponse.user != null) {
                            sm.showSnackBar(SnackBar(
                                content: Text(
                                    'Logged in: ${AuthResponse.user!.email!} ')));
                            // Check the email and navigate accordingly
                            if (AuthResponse.user!.email ==
                                'megyuvmi@gmail.com') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => home()),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserHomePage()),
                              );
                            }
                          }
                        } on AuthException catch (e) {
                          sm.showSnackBar(SnackBar(
                              content: Text('Failed to log in: ${e.message}')));
                        } catch (e) {
                          sm.showSnackBar(SnackBar(
                              content: Text('An unexpected error occurred')));
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tidak punya akun?",
                      style: TextStyle(color: Colors.black26, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => regis()));
                      },
                      child: Text(
                        "Daftar Sekarang",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
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
