import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/layout/doctor/cubit/state.dart';
import 'package:doctor/model/booking_model.dart';
import 'package:doctor/model/message.dart';
import 'package:doctor/model/user_model.dart';
import 'package:doctor/modules/doctor/booked.dart';
import 'package:doctor/modules/doctor/chat.dart';
import 'package:doctor/modules/doctor/profile.dart';
import 'package:doctor/modules/login/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorLayoutCubit extends Cubit<AdminStates> {
  DoctorLayoutCubit() : super(AdminInit());

  static DoctorLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeIndexStateA());
  }

  List <Widget> pagesAdmin = [
    ChatScreen(),
    BookedScreen(),
    ProfileScreen(),
  ];

  List<UserModel> userOnlyList=[];
  void userSearch(){
    userOnlyList = usersList
        .where((element) => element.role!.contains('User'))
        .toList();
    emit(SearchUserState());
  }

  List<UserModel>usersList=[];

  void getUsers(){
    FirebaseFirestore.instance.collection('User').get().then((value) {
      value.docs.forEach((element) {
        usersList.add(UserModel.fromJson(element.data()));
      });
      userSearch();
      print(usersList);
      emit(AdminGetUsersState());
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

  List<BookingModel>bookingModel=[];
  void getBooking(){
    FirebaseFirestore.instance.collection('Booking').get().then((value) {
      value.docs.forEach((element) {
        bookingModel.add(BookingModel.fromJson(element.data()));
      });
      emit(GetBookingState());
    }).catchError((error){
      print(error.toString());
    });
  }

}