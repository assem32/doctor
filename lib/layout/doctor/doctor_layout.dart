import 'package:doctor/layout/doctor/cubit/cubit.dart';
import 'package:doctor/layout/doctor/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>DoctorLayoutCubit()..getUsers()..getBooking(),
      child: BlocConsumer<DoctorLayoutCubit,AdminStates>(
        listener: (context,state){},
        builder: (context,state){
          return SafeArea(
            child: Scaffold(
              body: DoctorLayoutCubit.get(context).pagesAdmin[DoctorLayoutCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: DoctorLayoutCubit.get(context).currentIndex,
                onTap: (index){
                  DoctorLayoutCubit.get(context).changeIndex(index);
                },
                items: [

                  BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chat'),
                  BottomNavigationBarItem(icon: Icon(Icons.book),label: 'Booked'),
                  BottomNavigationBarItem(icon: Icon(Icons.book),label: 'Profile'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
