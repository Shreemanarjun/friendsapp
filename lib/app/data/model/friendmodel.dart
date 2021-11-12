import 'dart:convert';

class Friend {
  int? id;
  String? fname;
  String? lname;
  int? mobile;
  String? email;
  int? fid;
  Friend({
    this.id,
    this.fname,
    this.lname,
    this.mobile,
    this.email,
    this.fid,
  });

  Friend copyWith({
    int? id,
    String? fname,
    String? lname,
    int? mobile,
    String? email,
    int? fid,
  }) {
    return Friend(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      fid: fid ?? this.fid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'mobile': mobile,
      'email': email,
      'fid': fid,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      mobile: map['mobile'],
      email: map['email'],
      fid: map['fid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Friend.fromJson(String source) => Friend.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Friend(id: $id, fname: $fname, lname: $lname, mobile: $mobile, email: $email, fid: $fid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Friend &&
      other.id == id &&
      other.fname == fname &&
      other.lname == lname &&
      other.mobile == mobile &&
      other.email == email &&
      other.fid == fid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fname.hashCode ^
      lname.hashCode ^
      mobile.hashCode ^
      email.hashCode ^
      fid.hashCode;
  }
}
