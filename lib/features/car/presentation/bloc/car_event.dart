
//part of 'blog_bloc.dart';



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:image_picker/image_picker.dart';

@immutable
sealed class CarEvent {}

final class CarUpload extends CarEvent {
 final Car car;
 final List<XFile> files;
  CarUpload( {required this.car,required this.files});

  
}

final class CarFetchAllCars extends CarEvent {}
