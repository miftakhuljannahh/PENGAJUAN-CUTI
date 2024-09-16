import 'package:flutter/material.dart';

class detailData extends StatefulWidget {
  const detailData({super.key});

  @override
  State<detailData> createState() => detailDataState();
}

class detailDataState extends State<detailData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Karyawan'),
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.only(top: 50)),
                CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('img/person.jpg'),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Ari Bukhori',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "No Telp",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '085627846192',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Devisi",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Mobile Development',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Alamat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Jl. Sadewa Jakarta pusat',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 2),
                        child: Text(
                          'Riwayat Pengajuan Cuti',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10, // Jumlah item dalam daftar
                        itemBuilder: (context, index) {
                          final data = [
                            'Cuti menikah',
                            'Cuti hajatan',
                            'Cuti melahirkan anak ke 2',
                            'Cuti kematian',
                            'Cuti sakit',
                            'Cuti hajatan',
                            'Cuti hajatan',
                            'Cuti hajatan',
                            'Cuti hajatan',
                            'Cuti hajatan',
                            'Cuti hajatan',
                            'Cuti acara keluarga',
                            'Cuti kecelakaan',
                          ];

                          final note = [
                            'disetujui',
                            'ditolak',
                            'ditolak',
                            'ditolak',
                            'disetujui',
                            'disetujui',
                            'disetujui',
                            'disetujui',
                            'disetujui',
                            'disetujui',
                          ];

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            title: Text('Pengajuan Cuti ${index + 1}'),
                            subtitle: Text(data[index]),
                            trailing: Text(note[index]),
                            onTap: () {
                              // Tambahkan aksi ketika item daftar diklik
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
