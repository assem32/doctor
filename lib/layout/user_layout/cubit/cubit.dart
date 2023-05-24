import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/layout/user_layout/cubit/state.dart';
import 'package:doctor/model/booking_model.dart';
import 'package:doctor/model/message.dart';
import 'package:doctor/model/user_model.dart';
import 'package:doctor/modules/login/cubit/cubit.dart';
import 'package:doctor/modules/user/book.dart';
import 'package:doctor/modules/user/chat_to_doctor.dart';
import 'package:doctor/modules/user/machine_model.dart';
import 'package:doctor/modules/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserLayoutCubit extends Cubit<UserStates> {
  UserLayoutCubit() : super(UserInit());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  void changeIndex(index){
    currentIndex=index;
    emit(ChangeIndexStateU());
  }

  List <Widget> pages=[
    MachineScreen(),
    BookScreen(),
    ChatToDoctor(),
    ProfileUser(),
  ];

  List<UserModel> doctorsList=[];
  void userSearch(){
    doctorsList = usersList
        .where((element) => element.role!.contains('Doctor'))
        .toList();
    emit(GetDoctorState());
  }
  List<UserModel>usersList=[];

  void getUsers(){
    FirebaseFirestore.instance.collection('User').get().then((value) {
      value.docs.forEach((element) {
        usersList.add(UserModel.fromJson(element.data()));
      });
      userSearch();
      print(usersList);
      emit(GetUsersState());
    }).catchError((error){
      print(error.toString());
    });



  }

  List<Message> message=[];
  void getMessages({
    required String ?receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('User')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];

      event.docs.forEach((element) {
        message.add(Message.fromJson(element.data()));
      });

      emit(GetMassageSuccessState());
    });
  }

  void sendMessage({
    required receiverId,
    required dateTime,
    required text
  }){
    Message mModel= Message(
        senderId: userModel?.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text:text
    );
    //sender screen when send
    FirebaseFirestore.instance.collection('User')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(mModel.toMap()).then((value){
      emit(SendMassageSuccessState());
    }).catchError((error){
      emit(SendMassageErrorState());
    });

//receiver screen when send
    FirebaseFirestore.instance.collection('User')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('message')
        .add(mModel.toMap()).then((value){
      emit(SendMassageSuccessState());
    }).catchError((error){
      emit(SendMassageErrorState());
    });
  }

  void addBooking({UserModel ?modelIn,time,date,context}){
    BookingModel model=BookingModel(
      name: modelIn!.name,
      mail: modelIn.mail,
      phone: modelIn.phone,
      uId: modelIn.uId,
      date: date,
      time: time
    );
    FirebaseFirestore.instance.collection('Booking').add(model.toMap()).then((value) {
      Fluttertoast.showToast(
          msg: "Booking successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      emit(BookingSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }
  }