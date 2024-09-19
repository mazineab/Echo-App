import 'package:myapp/data/models/enums.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  Sexe sexe;
  List<dynamic>? roles;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.sexe,
    required this.phoneNumber,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      sexe: json['sexe'] == "male" ? Sexe.male : Sexe.female,
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'sexe': sexe == Sexe.male ? "male" : "femel",
      'password': password,
    };
  }

  getFullName() => "$firstName $lastName";
}
