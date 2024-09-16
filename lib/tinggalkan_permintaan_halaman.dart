import 'package:flutter/material.dart';
import 'package:project_admin/user_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:signature/signature.dart';
import 'dart:convert';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jenisCutiController = TextEditingController();
  final _tanggalMulaiController = TextEditingController();
  final _tanggalSelesaiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final supabase = Supabase.instance.client;
  final SignatureController _signatureController =
      SignatureController(penStrokeWidth: 2, penColor: Colors.black);

  @override
  void dispose() {
    _nameController.dispose();
    _jenisCutiController.dispose();
    _tanggalMulaiController.dispose();
    _tanggalSelesaiController.dispose();
    _deskripsiController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  Future<void> _submitLeaveRequest() async {
    if (_formKey.currentState!.validate()) {
      final signature = await _signatureController.toPngBytes();
      if (signature == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide a signature')),
        );
        return;
      }
      final signatureBase64 = base64Encode(signature);

      final response = await supabase
          .from('leave_requests')
          .insert({
            'user_id': supabase.auth.currentUser?.id,
            'name': _nameController.text,
            'jenis_cuti': _jenisCutiController.text,
            'tanggal_mulai': _tanggalMulaiController.text,
            'tanggal_selesai': _tanggalSelesaiController.text,
            'deskripsi': _deskripsiController.text,
            'tanda_tangan': signatureBase64,
          })
          .select()
          .single();

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Leave request submitted successfully')),
        );
        // Navigate back to UserHomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit leave request')),
        );
      }
    }
  }

  void _clearSignature() {
    setState(() {
      _signatureController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengajuan Cuti'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _jenisCutiController.text.isNotEmpty
                    ? _jenisCutiController.text
                    : null,
                decoration: InputDecoration(labelText: 'Jenis Cuti'),
                items: ['Melahirkan', 'Menikah', 'Kematian', 'Hajatan']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _jenisCutiController.text = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the leave type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tanggalMulaiController,
                decoration: InputDecoration(labelText: 'Tanggal Mulai'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _tanggalMulaiController.text =
                          pickedDate.toString().split(' ')[0];
                      _tanggalSelesaiController.text = pickedDate
                          .add(Duration(days: 5))
                          .toString()
                          .split(' ')[0];
                    });
                  }
                },
              ),
              TextFormField(
                controller: _tanggalSelesaiController,
                decoration: InputDecoration(labelText: 'Tanggal Selesai'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end date';
                  }
                  return null;
                },
                readOnly: true, // Make it read-only to prevent user changes
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Tanda Tangan:', style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 150,
                child: Signature(
                  controller: _signatureController,
                  backgroundColor: Colors.grey[200]!,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submitLeaveRequest,
                    child: Text('Kirim'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _clearSignature,
                    child: Text('Hapus Tanda Tangan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200]!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
