import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor/layout/doctor/cubit/cubit.dart';
import 'package:doctor/layout/doctor/cubit/state.dart';
import 'package:doctor/model/message.dart';
import 'package:doctor/model/user_model.dart';
import 'package:doctor/modules/login/cubit/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
var messageController=TextEditingController();

class ChatPrivateDoctor extends StatelessWidget {
  UserModel ?umodel;

  ChatPrivateDoctor({this.umodel});

  @override
  Widget build(BuildContext context) {
    return  Builder(
        builder: (BuildContext context){
          DoctorLayoutCubit.get(context).getMessages(receiverId: umodel!.uId);
          return BlocConsumer<DoctorLayoutCubit,AdminStates>(
            listener: (context, state){},
            builder: (context, state){
              return Scaffold(

                  body:
                     Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context,index){
                                    var message=DoctorLayoutCubit.get(context).message[index];

                                    if(userModel?.uId==message.receiverId) {
                                      return buildChatMessage(message);
                                    }else
                                      return buildChatMessageReceiver(message);
                                  },
                                  separatorBuilder: (context,index)=>SizedBox(
                                    height: 15,
                                  ),
                                  itemCount: DoctorLayoutCubit.get(context).message.length)
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10
                                    ),
                                    child: TextField(
                                      //keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Massege.....'
                                      ),
                                      controller: messageController,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  color: Colors.blue,
                                  child: MaterialButton(onPressed: () {
                                    DoctorLayoutCubit.get(context).sendMessage(
                                        receiverId: umodel?.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text
                                    );
                                    messageController.clear();
                                  },
                                    minWidth: 1.0,
                                    child: Icon(
                                      Icons.send,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),


              );
            },
          );
        }

    );
  }
  Widget buildChatMessage(Message mModel )=>Align(
    alignment: AlignmentDirectional.centerStart,

    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Text(
          '${mModel.text}'
      ),

    ),
  );
  Widget buildChatMessageReceiver(Message mModel)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Text(
          '${mModel.text}'
      ),
    ),
  );
}
