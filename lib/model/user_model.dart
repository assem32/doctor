class UserModel{
  String ?name;
  String ? mail;
  String ?uId;
  String ?phone;
  String ? image;
  String ?role;
  UserModel({
    this.name,
    this.mail,
    this.uId,
    this.phone,
    this.image,
    this.role

  });
  UserModel.fromJson(Map<String,dynamic>? json){
    mail = json!['mail'];
    name=json['name'];
    uId=json['uId'];
    phone=json['phone'];
    image=json['image'];
    role=json['role'];


  }
  Map<String,dynamic>toMap(){
    return {
      'name': name,
      'mail': mail,
      'uId': uId,
      'image':image,
      'phone': phone,
      'role': role,
    };
  }
}