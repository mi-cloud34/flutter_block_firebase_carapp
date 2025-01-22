import 'dart:io';
import 'package:flutter_block_firebase_carapp/core/constants/constants.dart';
import 'package:flutter_block_firebase_carapp/core/error/exceptions.dart';
import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/core/network/connection_checker.dart';
import 'package:flutter_block_firebase_carapp/features/car/data/datasources/car_local_data_source.dart';
import 'package:flutter_block_firebase_carapp/features/car/data/datasources/car_remote_data_source.dart';
import 'package:flutter_block_firebase_carapp/features/car/data/models/car_model.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/repositories/car_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource carRemoteDataSource;
  final CarLocalDataSource carLocalDataSource;
  final ConnectionChecker connectionChecker;
  CarRepositoryImpl(
    this.carRemoteDataSource,
    this.carLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Car>> uploadCar({
    required List<File> images,
   required String model,
  required double distance,
  required double fuelCapacity,
  required double pricePerHour,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      CarModel carModel = CarModel(
        id: const Uuid().v1(),
        model: model,
        distance: distance,
        fuelCapacity: fuelCapacity,
        imageUrls: [],
        pricePerHour: pricePerHour,
      );

      final imageUrls = await carRemoteDataSource.uploadCarImages(
        images: images,
        car: carModel,
      );

      carModel = carModel.copyWith(
        imageUrls: imageUrls,
      );

      final uploadCar = await carRemoteDataSource.uploadCar(carModel) as Car;
      return right(uploadCar);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Car>>> getAllCars() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final cars = carLocalDataSource.loadCars() as List<Car>;
        return right(cars);
      }
      final cars = await carRemoteDataSource.getAllCars() ;
      carLocalDataSource.uploadLocalcars(cars: cars);
      final carList = carLocalDataSource.loadCars() as List<Car>;
      return right(carList);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
