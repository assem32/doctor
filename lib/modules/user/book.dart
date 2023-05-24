import 'package:doctor/layout/user_layout/cubit/cubit.dart';
import 'package:doctor/layout/user_layout/cubit/state.dart';
import 'package:doctor/modules/login/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

var timeController=TextEditingController();
var dateController=TextEditingController();

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit,UserStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(

              children: [
                Text('Our Doctors',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
                Expanded(child: ListView.separated(itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1684931764~exp=1684932364~hmac=084c773a9c476e38cb509615d7a2d4d7e909503b49d5863600ada2ce8dfc05ae'
                          ),
                        ),
                        Text('${UserLayoutCubit.get(context).doctorsList[index].name}'),

                      ],
                    ),
                  );
                },
                     separatorBuilder: (context,index)=>SizedBox(
                  height: 12,
                ), itemCount: UserLayoutCubit.get(context).doctorsList.length)
        ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    label: Text('Time'),
                      border: OutlineInputBorder()
                  ),
                  onTap: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      timeController.text =
                          value!.format(context).toString();
                      print(value.format(context));
                    });
                  },
                ),
                SizedBox(height: 12,),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      label: Text('date'),
                      border: OutlineInputBorder()
                  ),
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2026-05-03'),
                    ).then((value) {
                      dateController.text =
                          DateFormat.yMMMd().format(value!);
                    });
                  },
                ),
                SizedBox(height: 12,),
                Material(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.blue,
                  child: MaterialButton(onPressed: (){
                    UserLayoutCubit.get(context).addBooking(modelIn: userModel,time: timeController.text,date: dateController.text,);
                  },
                    child: Text('Book',style: TextStyle(color: Colors.white),),),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
