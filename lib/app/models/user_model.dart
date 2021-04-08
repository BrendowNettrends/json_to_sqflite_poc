class UserModel {

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
  });


  factory UserModel.fromJson(Map<String, dynamic>  json) => UserModel(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    phone: json['phone'],
    website: json['website']
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();

    json['id'] = id;
    json['name'] = name;
    json['username'] = username;
    json['email'] = email;
    json['phone'] = phone;
    json['website'] = website;

    return json;
  }
}