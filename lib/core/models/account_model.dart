// Esta clase sera el encargado de guardar como objeto los datos de usuario.

import 'dart:convert';

class AccountModel {
  final String uid;
  final String email;
  final String photoURL;
  final String name;
  final String phoneNumber;

  AccountModel(
      {required this.phoneNumber,
      required this.email,
      required this.photoURL,
      required this.name,
      required this.uid});

  Map<String, Object> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'name': name,
    };
  }

  factory AccountModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return AccountModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoURL: snapshot['photoURL'],
      phoneNumber: snapshot['phone'],
      name: snapshot['name'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  String toQRString() {
    return '''
    {
      "uid" : "$uid",
      "email" : "$email",
      "photoURL" : "$photoURL",
      "phoneNumber" : "$phoneNumber",
      "name" : "$name",
    }
    ''';
  }

  static AccountModel fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AccountModel(
      uid: jsonMap['uid'],
      email: jsonMap['email'],
      photoURL: jsonMap['photoURL'],
      phoneNumber: jsonMap['phoneNumber'],
      name: jsonMap['name'],
    );
  }
}
