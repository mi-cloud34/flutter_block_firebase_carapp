
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/entities/user.dart' as user_model;
import 'package:flutter_block_firebase_carapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/pages/add_car_page.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/pages/car_list_page.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  user_model.User? user;

  final List<Widget> _pages = <Widget>[
    CarListPage(),
    AnotherPage(),
    AnotherPage1(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
       context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       
       actions: [
        IconButton(onPressed: () => {}, icon:Icon(Icons.messenger_outline,color: Colors.black,size: 30,),),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                user = state.user;
                return GestureDetector(
                  onTap: () async {
                    //await FirebaseAuth.instance.signOut();
                    Navigator.push(context, ProfilePage.route());
                  },
                  child: Padding(
                    
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      margin: EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundImage: user?.imageUrl != null
                            ? NetworkImage(user!.imageUrl!)
                            : const AssetImage('assets/default_user.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              );
            },
          ),
          
        ],
      ),
      drawer: Drawer(
        width: 200,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                //color: Colors.lightBlue,
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    user = state.user;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: user?.imageUrl != null
                              ? NetworkImage(user!.imageUrl!)
                              : const AssetImage('assets/default_user.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user?.name ?? 'Unknown User',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user?.email ?? 'Unknown Email',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, ProfilePage.route());
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Ayarlar sayfasına yönlendirme
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, LoginPage.route());
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages),
            label: 'Another',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Another-1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Another-2',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess && state.user.role == 'admin') {
            return FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                 Navigator.push(context, AddCarPage.route());
              },
              child: Icon(Icons.add, color: Colors.white),
            );
          }
          return Container(); // Kullanıcı rolü 'admin' değilse boş bir Container döndür
        },
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text('This is another page'),
        ),
      ),
    );
  }
}

class AnotherPage1 extends StatelessWidget {
  const AnotherPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Text('This is another page'),
        ),
      ),
    );
  }
}

class AnotherPage2 extends StatelessWidget {
  const AnotherPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text('This is another page'),
        ),
      ),
    );
  }
}