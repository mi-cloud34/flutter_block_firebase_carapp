import 'dart:io';

import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/core/usecase/usecase.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/repositories/car_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadCar implements UseCase<Car, UploadCarParams> {
  final CarRepository carRepository;
  UploadCar(this.carRepository);

  @override
  Future<Either<Failure, Car>> call(UploadCarParams params) async {
    return await carRepository.uploadCar(
      images: params.imageUrls,
      model: params.model,
      fuelCapacity: params.fuelCapacity,
      pricePerHour: params.pricePerHour,
      distance: params.distance,
    );
  }
}

class UploadCarParams {
   final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;
  final List<File> imageUrls;

  UploadCarParams({
  required this.imageUrls, required this.model, required this.distance, required this.fuelCapacity, required this.pricePerHour}
  );
}
