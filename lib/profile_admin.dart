import 'package:project_admin/DataKaryawan.dart';
import 'package:project_admin/detail.dart';
import 'package:project_admin/home.dart';
import 'package:flutter/material.dart';
import 'package:project_admin/login.dart';

class profile_admin extends StatefulWidget {
  const profile_admin({Key? key}) : super(key: key);

  @override
  State<profile_admin> createState() => profile_adminState();
}

class profile_adminState extends State<profile_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: const Text('Home'),
      //         onTap: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => home()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: const Text('Data Karyawan'),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => DataKaryawan()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.calendar_today),
      //         title: const Text('Pengajuan Cuti'),
      //         onTap: () {
      //           // Kode untuk mengaktifkan fitur drawer
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: const Text('Log Out'),
      //         onTap: () {
      //           showDialog(
      //             context: context,
      //             builder: (context) => AlertDialog(
      //               actions: [
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pop();
      //                     Navigator.pushReplacement(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => LoginPage()),
      //                     );
      //                   },
      //                   child: const Text("Oke"),
      //                 )
      //               ],
      //               title: const Text("Log Out"),
      //               contentPadding: const EdgeInsets.all(20.0),
      //               content: const Text("this is close flutter"),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('img/profilee.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Davin Anggara',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Admin 1',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('Davinang@gmail.com'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('086462109367'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                leading: Icon(Icons.calendar_month),
                title: Text('Bandung, 19-01-1995'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Jl. Sadewa no 13 Semarang timur '),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text("Oke"),
                        )
                      ],
                      title: const Text("Log Out"),
                      contentPadding: const EdgeInsets.all(20.0),
                      content: const Text("Apakah Anda Yakin  Ingin Keluar?"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
