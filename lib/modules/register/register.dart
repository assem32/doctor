import 'package:doctor/modules/register/cubit/cubit.dart';
import 'package:doctor/modules/register/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';



final _formKey = GlobalKey<FormState>();
final nameController = TextEditingController();
final passwordController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();
final talentController = TextEditingController();
String selectedOption='User';
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,state){
        if(state is RegisterSuccessUserState)
          Fluttertoast.showToast(
              msg: "User Registered successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0
          );


      },
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                      SizedBox(height: 12,),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your mail',
                            border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder()

                        ),

                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                            labelText: 'Phone',
                            hintText: 'Enter your phone',
                            border: OutlineInputBorder()

                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Role',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        value: selectedOption,
                        items: [
                          DropdownMenuItem<String>(
                            value: 'User',
                            child: Text('User'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Doctor',
                            child: Text('Doctor'),
                          ),
                        ],
                        onChanged: (value) {
                          selectedOption = value!;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Role is required';
                          }
                          return null;
                        },
                      ),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Colors.blue,

                            borderRadius: BorderRadius.circular(26),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(email: emailController.text,password: passwordController.text,role: selectedOption,name: nameController.text,phone: phoneController.text,context: context);

                                }
                              },
                              child: Text('Register',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
