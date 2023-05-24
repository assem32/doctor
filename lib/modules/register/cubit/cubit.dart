import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/model/user_model.dart';
import 'package:doctor/modules/login/cubit/cubit.dart';
import 'package:doctor/modules/register/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInit());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    name,
    email,
    password,
    phone,
    role,
    context,
  }) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name,phone: phone,email: email,uid: value.user?.uid,role: role);

      if(role=='User') {
        emit(RegisterSuccessUserState());
      } else if(role=='Content Creator')
        emit(RegisterSuccessCreatorState());


    })
        .catchError((error){
      print(error.toString());
    });
  }
  void userCreate({
    name,
    email,
    phone,
    uid,
    role
  }){
    UserModel model =UserModel(
        mail: email,
        phone: phone,
        name: name,
        uId: uid,
      role: role
    );
    FirebaseFirestore.instance.collection('User').doc(uid).set(model.toMap()).then((value) {
      userModel=model;
    });

  }
}