import 'dart:io';
import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CarRepository {
  Future<Either<Failure, Car>> uploadCar({
     required List<File> images,
   required String model,
  required double distance,
  required double fuelCapacity,
  required double pricePerHour,
  });

  Future<Either<Failure, List<Car>>> getAllCars();
}
