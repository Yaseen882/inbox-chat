import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? id;
  String? name;
  String? imageUrl;
  Timestamp? createdAt;
  String? email;
  String? status;

//<editor-fold desc="Data Methods">
  UsersModel({
    this.id,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.email,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'email': email,
      'status': status,
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      createdAt: map['createdAt'] as Timestamp,
      email: map['email'] as String,
      status: map['status'] as String,
    );
  }

//</editor-fold>
}
