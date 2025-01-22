/* 


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final ImagePicker _picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body:BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return   Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: state.user.imageUrl!= null
                                ? NetworkImage( state.user.imageUrl!)
                                : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                               onTap: () async {
                              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                print(pickedFile);
                                context.read<AuthBloc>().add(
                                  AuthUploadProfileImage(
                                    user: state.user,
                                    pickedFile: pickedFile,
                                  ),
                                );
                              }
                            },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name: ${ state.user.name}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: ${ state.user.email}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Role: ${ state.user.role ?? 'User'}',
                      style: TextStyle(fontSize: 18),
                    ),
                    // Add more user information here
                  ],
                ),
              );
    
          } 
          return Center(child: Container());
        },
       
           ),
     
     );
  }
} */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: state.user.imageUrl != null
                              ? NetworkImage(state.user.imageUrl!)
                              : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                             if (pickedFile != null) {
                                print(pickedFile);
                                context.read<AuthBloc>().add(
                                  AuthUploadProfileImage(
                                    user: state.user,
                                    pickedFile: pickedFile,
                                  ),
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${state.user.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${state.user.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Role: ${state.user.role ?? 'User'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Add more user information here
                ],
              ),
            );
          }
          return Center(child: Container());
        },
      ),
    );
  }
}