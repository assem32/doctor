class BookingModel{
  String ?name;
  String ? mail;
  String ?uId;
  String ?phone;
  String ?time;
  String ?date;
  BookingModel({
    this.name,
    this.mail,
    this.uId,
    this.phone,
    this.time,
    this.date,


  });
  BookingModel.fromJson(Map<String,dynamic>? json){
    mail = json!['mail'];
    name=json['name'];
    uId=json['uId'];
    phone=json['phone'];
    time=json['time'];
    date=json['date'];


  }
  Map<String,dynamic>toMap(){
    return {
      'name': name,
      'mail': mail,
      'uId': uId,
      'phone': phone,
      'time': time,
      'date': date,
    };
  }
}