import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({Key? key}) : super(key: key);

  @override
  State<PengajuanCuti> createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> leaveRequests = [];
  final TextEditingController searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
  }

  Future<void> _fetchLeaveRequests() async {
    try {
      final response = await supabase.from('leave_requests').select();
      setState(() {
        leaveRequests = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch leave requests: $error')),
      );
    }
  }

  Future<void> _updateLeaveRequestStatus(String id, String status) async {
    try {
      await supabase
          .from('leave_requests')
          .update({'status': status}).eq('id', id);
      _fetchLeaveRequests(); // Refresh the data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $status')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $error')),
      );
    }
  }

  void _showLeaveRequestDetails(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Pengajuan Cuti'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama: ${request['name'] ?? ''}'),
              Text('Tanggal Mulai: ${request['tanggal_mulai'] ?? ''}'),
              Text('Tanggal Selesai: ${request['tanggal_selesai'] ?? ''}'),
              Text('Jenis Cuti: ${request['jenis_cuti'] ?? ''}'),
              Text('Deskripsi: ${request['deskripsi'] ?? ''}'),
              Text('Status: ${request['status'] ?? ''}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                "Data Pengajuan Cuti",
                style: TextStyle(color: Colors.black),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color.fromARGB(255, 182, 228, 232)),
                  columnSpacing: 26,
                  columns: [
                    DataColumn(
                        label: Text(
                      'Nama',
                    )),
                    DataColumn(label: Text('Tanggal Diajukan')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: leaveRequests
                      .where((request) => request['tanggal_mulai']
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .map((request) => DataRow(cells: [
                            DataCell(
                              InkWell(
                                onTap: () {
                                  _showLeaveRequestDetails(request);
                                },
                                child: Text(request['name'] ?? ''),
                              ),
                            ),
                            DataCell(Text(request['tanggal_mulai'] ?? '')),
                            DataCell(Text(request['status'] ?? '')),
                            DataCell(
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  _updateLeaveRequestStatus(
                                      request['id'], value);
                                },
                                itemBuilder: (BuildContext context) {
                                  return ['accept', 'decline', 'pending']
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ]))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
