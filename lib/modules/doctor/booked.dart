import 'package:doctor/layout/doctor/cubit/cubit.dart';
import 'package:doctor/layout/doctor/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorLayoutCubit,AdminStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(child: ListView.separated(itemBuilder: (context,index)=>
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1684931764~exp=1684932364~hmac=084c773a9c476e38cb509615d7a2d4d7e909503b49d5863600ada2ce8dfc05ae'
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Patient Name :${DoctorLayoutCubit.get(context).bookingModel[index].name}'),
                            Text('Patient Phone :${DoctorLayoutCubit.get(context).bookingModel[index].phone}'),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('Booking Date${DoctorLayoutCubit.get(context).bookingModel[index].date}',style: TextStyle(color: Colors.grey),),
                            Text('Booking Time${DoctorLayoutCubit.get(context).bookingModel[index].time}',style: TextStyle(color: Colors.grey)),
                          ],
                        )

                      ],
                    ),
                    separatorBuilder: (context,index)=>SizedBox(
                      height: 12,
                    ),
                    itemCount: DoctorLayoutCubit.get(context).bookingModel.length))
              ],
            ),
          ),
        );
      },
    );
  }
}
