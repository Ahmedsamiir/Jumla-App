
class ProfileModel {

  late final bool status;
 // late final String message;
  late final UserData data;

  ProfileModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    //message = json['message'];
    data = UserData.fromJson(json['data']);
  }

}

class UserData {

  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  late final int points;
  late final int credit;
  late final String token;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}