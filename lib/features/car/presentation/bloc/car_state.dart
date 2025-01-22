//part of 'car_bloc.dart';


import 'package:flutter/material.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
@immutable
sealed class CarState {}

final class CarInitial extends CarState {}

final class CarLoading extends CarState {}

final class CarFailure extends CarState {
  final String error;
  CarFailure(this.error);
}

final class CarUploadSuccess extends CarState {}

final class CarsDisplaySuccess extends CarState {
  final List<Car> cars;
  CarsDisplaySuccess(this.cars);
}
