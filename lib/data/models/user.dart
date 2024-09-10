class User {
  String id;
  String name;
  String email;
  String city;
  String password;
  List<dynamic>? roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      city: json['city'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'city': city,
      'password': password,
    };
  }
}
