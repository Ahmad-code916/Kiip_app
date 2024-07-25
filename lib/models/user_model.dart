class UserModel {
  String? name;
  String? password;
  String? profilePic;
  String? email;
  String? uid;
  String? status;

  UserModel({this.name, this.email, this.password, this.profilePic,this.status, this.uid});

  UserModel.fromMap(Map<String, dynamic> map) {
    name = map["name"]??"";
    email = map["email"]??"";
    password = map["password"]??"";
    profilePic = map["profilePic"]??"";
    status = map["status"]??"";
    uid = map["uid"]??"";
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "profilePic": profilePic,
      "status": status,
      "uid": uid,
    };
  }
}
