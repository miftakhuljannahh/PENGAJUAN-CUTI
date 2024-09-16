// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:project_admin/detail.dart';
import 'package:project_admin/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataKaryawan extends StatefulWidget {
  const DataKaryawan({Key? key}) : super(key: key);

  @override
  State<DataKaryawan> createState() => DataKaryawanState();
}

class DataKaryawanState extends State<DataKaryawan> {
  final dataStream = supabase.from('admin').stream(primaryKey: ['id']);

  Future<void> createData(String nama, String devisi) async {
    await supabase.from('admin').insert({'nama': nama, 'devisi': devisi});
  }

  Future<void> updateData(String id, String nama, String devisi) async {
    await supabase
        .from('admin')
        .update({'nama': nama, 'devisi': devisi}).eq('id', id);
  }

  Future<void> deleteData(String id) async {
    await supabase.from('admin').delete().eq('id', id);
  }

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _devisiController = TextEditingController();

  final TextEditingController searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 8, 16, 12),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    hintText: "Search Here",
                  ),
                ),
              )
            : const Text(
                "Data Karyawan",
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
                if (!isSearchClicked) {
                  searchController.clear();
                  searchText = '';
                }
              });
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: StreamBuilder(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }
          final admin = snapshot.data!;
          List<Map<String, dynamic>> filteredAdmin = [];

          if (searchText.isEmpty) {
            filteredAdmin = List.from(admin);
          } else {
            filteredAdmin = admin.where((data) {
              final nama = data['nama']?.toString().toLowerCase() ?? '';
              final devisi = data['devisi']?.toString().toLowerCase() ?? '';
              return nama.contains(searchText.toLowerCase()) ||
                  devisi.contains(searchText.toLowerCase());
            }).toList();
          }

          return ListView.builder(
            itemCount: filteredAdmin.isEmpty
                ? 0
                : filteredAdmin.length * 2 -
                    1, // Menambahkan 1 elemen tambahan untuk setiap garis bawah
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return Divider(); // Mengembalikan garis bawah
              }
              final dataIndex =
                  index ~/ 2; // Menghitung indeks aktual dari data
              final data = filteredAdmin[dataIndex];
              final dataId = data['id'].toString();

              return ListTile(
                title: InkWell(
                  onTap: () {
                    // Aksi yang akan dijalankan saat kolom nama ditekan

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            detailData(), // Ganti dengan halaman selanjutnya
                      ),
                    );
                  },
                  child: Text(data['nama'] ?? "data null"),
                ),
                subtitle: Text(data['devisi'] ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Edit Data'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    initialValue: data['nama'],
                                    decoration: InputDecoration(
                                      labelText: 'Nama',
                                    ),
                                    onFieldSubmitted: (value) async {
                                      await updateData(
                                        dataId,
                                        value,
                                        data['devisi'],
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: data['devisi'],
                                    decoration: InputDecoration(
                                      labelText: 'Devisi',
                                    ),
                                    onFieldSubmitted: (value) async {
                                      await updateData(
                                        dataId,
                                        data['nama'] ?? "data null",
                                        value,
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool deleteConfirmed = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Hapus"),
                              content: const Text('Are you Sure'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('yes'),
                                ),
                              ],
                            );
                          },
                        );
                        if (deleteConfirmed) {
                          await deleteData(dataId);
                        }
                      },
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: const Text('Tambahkan Data'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(labelText: 'Nama'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama harus diisi';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _devisiController,
                        decoration: InputDecoration(labelText: 'Devisi'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Devisi harus diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await createData(
                              _namaController.text,
                              _devisiController.text,
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
