import 'dart:convert';

User userFromJson(String str){
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String userToJson(User data){
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User{
  final String name;
  final String username;
  final String password;
  final String email;
  final int progress;
  final int xp;
  final String type;

  User({
    this.name,
    this.username,
    this.email,
    this.password,
    this.progress = 0,
    this.xp = 0,
    this.type = "N/A"
  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
    name: json['Name'],
    username: json['UserName'],
    password: json['PassWord'],
    email: json['Email'],
    progress: json['Progress'],
    xp: json['XP'],
    type: json['Type']
  );

  Map<String, dynamic> toMap() => {
    "Name": name,
    "UserName": username,
    "PassWord": password,
    "Email": email,
    "Progress": progress,
    "XP": xp,
    "Type": type
  };
}