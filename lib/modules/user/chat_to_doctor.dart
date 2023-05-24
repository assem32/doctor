import 'package:doctor/layout/user_layout/cubit/cubit.dart';
import 'package:doctor/layout/user_layout/cubit/state.dart';
import 'package:doctor/modules/doctor/chat_private.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatToDoctor extends StatelessWidget {
  const ChatToDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit,UserStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(child: ListView.separated(itemBuilder: (context,index)=>
                    InkWell(
                      onTap: (){
                        var id=UserLayoutCubit.get(context).doctorsList[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPrivateDoctor(umodel: id,)));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1684931764~exp=1684932364~hmac=084c773a9c476e38cb509615d7a2d4d7e909503b49d5863600ada2ce8dfc05ae'

                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text('${UserLayoutCubit.get(context).doctorsList[index].name}')
                        ],
                      ),
                    ),

                     separatorBuilder: (context,index)=>SizedBox(
                       height: 12,
                     ), itemCount: UserLayoutCubit.get(context).doctorsList.length)
        )
              ],
            ),
          ),
        );
      },
    );
  }
}
