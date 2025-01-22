
import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/core/usecase/usecase.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/repositories/car_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCars implements UseCase<List<Car>, NoParams> {
  final CarRepository carRepository;
  GetAllCars(this.carRepository);

  @override
  Future<Either<Failure, List<Car>>> call(NoParams params) async {
    return await carRepository.getAllCars();
  }
}
