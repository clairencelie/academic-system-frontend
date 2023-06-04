import 'package:academic_system/src/model/user.dart';

class Student extends User {
  final String major;
  final String phoneNumber;
  final String email;
  final String address;
  final String semester;
  final String status;
  final String batchOf;

  Student({
    required super.id,
    required super.name,
    required super.role,
    required this.major,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.semester,
    required this.status,
    required this.batchOf,
  });

  factory Student.createFromJson(Map<String, dynamic> json) {
    // "id": "111190001",
    // "name": "Alexander Nugroho",
    // "major": "Sistem Informasi",
    // "phone_number": "081234567890",
    // "email": "alexandernugroho@example.com",
    // "address": "jakarta",
    // "semester": "1",
    // "status": "aktif",
    // "generation": "2022",
    // "role": "mahasiswa"

    return Student(
      id: json['id'].toString(),
      name: json['name'],
      role: json['role'],
      major: json['major'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      address: json['address'],
      semester: json['semester'].toString(),
      status: json['status'],
      batchOf: json['batch_of'],
    );
  }
}
