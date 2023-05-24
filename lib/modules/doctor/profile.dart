import 'package:doctor/modules/login/cubit/cubit.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
        child: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  CircleAvatar(
                    radius:60 ,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1684931764~exp=1684932364~hmac=084c773a9c476e38cb509615d7a2d4d7e909503b49d5863600ada2ce8dfc05ae'
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Name: ${userModel!.name}',style: TextStyle(
                      fontSize: 22
                  ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'E-mail: ${userModel!.mail}',style: TextStyle(
                      fontSize: 22
                  ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Phone: ${userModel!.phone}',style: TextStyle(
                      fontSize: 22
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
