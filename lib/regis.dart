import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_admin/login.dart';
// import 'package:project_admin/home.dart';
import 'package:project_admin/main.dart';
import 'package:project_admin/regis.dart';

class regis extends StatefulWidget {
  @override
  State<regis> createState() => _regis();
}

class _regis extends State<regis> {
  TextEditingController cUser = TextEditingController();
  TextEditingController cPass = TextEditingController();
  TextEditingController cMail = TextEditingController();
  // final formkey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) return "Please enter a valid Email";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(238, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Form(
            // key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset("img/login.png", width: 250, height: 250),
                Text(
                  "Register",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Text(
                  "Create an account",
                  style: TextStyle(color: Color(0xff000000), fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 50,
                // ),
                // TextFormField(
                //   controller: cUser,
                //   decoration: InputDecoration(
                //     labelText: "Username",
                //     border: OutlineInputBorder(),
                //     prefixIcon: Icon(Icons.email),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "User Masih Kosong";
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                TextFormField(
                  controller: cMail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                  // onChanged: (value) {
                  //   setState(() {
                  //     _email = value;
                  //   });
                  // },
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
                      final sm = ScaffoldMessenger.of(context);
                      final supabase = Supabase.instance.client;
                      final AuthResponse = await supabase.auth
                          .signUp(password: cPass.text, email: cMail.text);

                      sm.showSnackBar(SnackBar(
                          content: Text(
                              'Logged in: ${AuthResponse.user!.email!} ')));
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      // try {
                      //   final email = cMail.text.trim();
                      //   final password = cPass.text.trim();
                      //   final username = cUser.text.trim();

                      //   await Supabase.instance.client.auth.signUp(
                      //       password: cPass.text.trim(),
                      //       email: cMail.text.trim(),
                      //       data: {'username': cUser.text.trim()});
                      //   if (mounted) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //             content: Text("Berhasil Mendaftar")));
                      //   }
                      // } catch (erorr) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content: Text("Berhasil Mendaftar")));
                      // }

                      // String tUser = "mifta";
                      // String tPass = "12345";
                      // String tMail = "mifta@gmail.com";
                      // if (formkey.currentState!.validate()) {
                      //   if (cUser.text == tUser &&
                      //       cPass.text == tPass &&
                      //       cMail.text == tMail) {
                      //     //perintah utk memanggil halaman baru
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => home(),
                      //     ));
                      //     //Navigator.pushAndRemoveUntil(
                      //     //  context,
                      //     //MaterialPageRoute(
                      //     //builder: (context) => const cutikhusus(),
                      //     //),
                      //     //  (route) => false);
                      //   } else {
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) {
                      //           return AlertDialog(
                      //             title: Text("Konfirmasi Login"),
                      //             content:
                      //                 Text("User atau Password Masih salah"),
                      //             actions: [
                      //               ElevatedButton(
                      //                   onPressed: () {
                      //                     // cUser.text = '';
                      //                     // cPass.text = '';
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                   child: Text('Ok'))
                      //             ],
                      //           );
                      //         });
                      //   }
                      //   ;
                      // }
                    },
                    child: Text(
                      "Regis",
                      style: TextStyle(color: Colors.white),
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

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:tes_login/cutikhusus.dart';
// import 'package:tes_login/login.dart';
// import 'package:tes_login/regis.dart';

// class regis extends StatefulWidget {
//   @override
//   State<regis> createState() => _regis();
// }

// class _regis extends State<regis> {
//   TextEditingController cUser = TextEditingController();
//   TextEditingController cMail = TextEditingController();
//   TextEditingController cPass = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   // final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   String _user = " ";
//   String _email = " ";
//   String _password = "";
//   void _handleSignUp() async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: _email,
//         password: _password,
//       );
//       print('User Registered: ${userCredential.user!.email}');
//     } catch (e) {
//       print('Erorr During Registration:$e');
//     }
//   }

//   String? validateEmail(String? email) {
//     RegExp emailRegex = RegExp(r'^[\w-\.]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
//     final isEmailValid = emailRegex.hasMatch(email ?? '');
//     if (!isEmailValid) return "Please enter a valid Email";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(238, 255, 255, 255),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 10),
//                 Image.asset("images/login.png", width: 250, height: 250),
//                 Text(
//                   "Register",
//                   style: TextStyle(
//                     color: Color(0xff000000),
//                     fontSize: 30,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Create Your Account",
//                   style: TextStyle(color: Color(0xff000000), fontSize: 15),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 50),
//                 TextFormField(
//                   controller: cUser,
//                   decoration: InputDecoration(
//                     labelText: "Username",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Username is required";
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _user = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: cMail,
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Username is required";
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _email = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   obscureText: true,
//                   controller: cPass,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Password is required";
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _password = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   width: double.infinity,
//                   height: 60,
//                   margin: EdgeInsets.symmetric(horizontal: 2),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF0000EF)),
//                     onPressed: () {
//                       if (_formkey.currentState!.validate()) {
//                         _handleSignUp();
//                       }
//                       // String tUser = "mifta";
//                       // String tEmail = "mifta@gmail.com";
//                       // String tPass = "12345";
//                       // if (formKey.currentState!.validate()) {
//                       //   if (cUser.text == tUser &&
//                       //       cPass.text == tPass &&
//                       //       cMail.text == tEmail) {
//                       //     Navigator.push(
//                       //         context,
//                       //         MaterialPageRoute(
//                       //             builder: (context) => LoginPage()));
//                       //   }
//                       //   showDialog(
//                       //       context: context,
//                       //       builder: (context) {
//                       //         return AlertDialog(
//                       //           title: Text("Registration Confirmation"),
//                       //           content: Text("Registration Successful"),
//                       //           actions: [
//                       //             TextButton(
//                       //                 onPressed: () {
//                       //                   cUser.text = '';
//                       //                   cMail.text = '';
//                       //                   cPass.text = '';
//                       //                   Navigator.of(context).pop();
//                       //                 },
//                       //                 child: Text('Ok'))
//                       //           ],
//                       //         );
//                       //       });
//                       // }
//                     },
//                     child:
//                         Text("Sign Up", style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
