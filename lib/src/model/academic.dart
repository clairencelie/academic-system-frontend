import 'package:academic_system/src/model/user.dart';

class Academic extends User {
  final String phoneNumber;
  final String email;
  final String address;
  final String status;

  Academic({
    required super.id,
    required super.name,
    required super.role,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.status,
  });

  factory Academic.createFromJson(Map<String, dynamic> json) {
    return Academic(
      id: json['id'].toString(),
      name: json['name'],
      role: json['role'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      address: json['address'],
      status: json['status'],
    );
  }
}
