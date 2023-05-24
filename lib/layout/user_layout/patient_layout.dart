import 'package:doctor/layout/user_layout/cubit/cubit.dart';
import 'package:doctor/layout/user_layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class PatientHomePage extends StatelessWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>UserLayoutCubit()..getUsers(),
      child: BlocConsumer<UserLayoutCubit,UserStates>(
        listener: (context,state){},
        builder: (context,state){
          return SafeArea(
            child: Scaffold(
              body: UserLayoutCubit.get(context).pages[UserLayoutCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: UserLayoutCubit.get(context).currentIndex,
                onTap: (index){
                  UserLayoutCubit.get(context).changeIndex(index);
                },
                items: [

                  BottomNavigationBarItem(

                      icon: Icon(Icons.science),label: 'Prediction'),
                  BottomNavigationBarItem(icon: Icon(Icons.book),label: 'Book'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chat'),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
