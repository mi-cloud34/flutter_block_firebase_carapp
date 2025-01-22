

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_block_firebase_carapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_block_firebase_carapp/core/network/connection_checker.dart';
import 'package:flutter_block_firebase_carapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_block_firebase_carapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/usecases/uoloadImageUser.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_block_firebase_carapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/car/data/datasources/car_local_data_source.dart';
import 'package:flutter_block_firebase_carapp/features/car/data/repositories/car_repository_impl.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/repositories/car_repository.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/usecases/get_all_cars.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/usecases/upload_car.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'features/car/data/datasources/car_remote_data_source.dart';

part 'init_dependencies.main.dart';
