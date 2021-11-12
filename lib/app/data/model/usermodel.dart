import 'dart:convert';

class User {
  int? id;
  String? fname;
  String? lname;
  String? email;
  int? mobile;
  String? password;
  User({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.mobile,
    this.password,
  });

  User copyWith({
    int? id,
    String? fname,
    String? lname,
    String? email,
    int? mobile,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobile': mobile,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      email: map['email'],
      mobile: map['mobile'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, fname: $fname, lname: $lname, email: $email, mobile: $mobile, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.fname == fname &&
      other.lname == lname &&
      other.email == email &&
      other.mobile == mobile &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fname.hashCode ^
      lname.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      password.hashCode;
  }
}
