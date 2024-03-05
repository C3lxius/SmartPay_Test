// ignore_for_file: non_constant_identifier_names

class User {
  String? id;
  String? full_name;
  String? username;
  String? email;
  String? phone;
  String? phone_country;
  String? country;
  String? avatar;

  User(
      {this.id,
      this.full_name,
      this.username,
      this.email,
      this.phone,
      this.phone_country,
      this.country,
      this.avatar});

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "full_name": full_name,
        "username": username,
        "email": email,
        "phone": phone,
        "phone_country": phone_country,
        "country": country,
        "avatar": avatar
      };
}
