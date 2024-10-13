import 'package:myapp/data/models/enums.dart';

class User {
  String id;
  String? uId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  Sexe sexe;
  String? imageUrl;
  String? bio;
  List<dynamic>? roles;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.sexe,
    required this.phoneNumber,
    required this.password,
    this.bio,
    this.imageUrl,
    this.uId,
  });

  User.empty()
      : id = '',
        uId='',
        firstName = '',
        lastName = '',
        email = '',
        sexe = Sexe.male,
        phoneNumber = '',
        bio='',
        imageUrl='',
        password = '';


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']??'',
      uId: json['uId']??'',
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      sexe: json['sexe'] == "male" ? Sexe.male : Sexe.female,
      password: json['password'],
      bio:json['bio'],
      imageUrl: json['imageUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uId':uId??'',
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'sexe': sexe == Sexe.male ? "male" : "femel",
      'password': password,
      'bio':bio,
      'imageUrl':imageUrl
    };
  }

  getFullName() => "$firstName $lastName";
}
