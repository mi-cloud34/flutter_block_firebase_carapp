import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/pages/home.dart';
import 'package:flutter_block_firebase_carapp/firebase_options.dart';

import 'package:flutter_block_firebase_carapp/init_dependencies.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
         
        BlocProvider<CarBloc>(
          create: (context) => serviceLocator<CarBloc>(),
        ),
        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    ),
      ),
    );
  }
}

