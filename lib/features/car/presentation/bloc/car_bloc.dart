import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/usecases/get_all_cars.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/usecases/upload_car.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_event.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_state.dart';

import '../../../../core/usecase/usecase.dart';


class CarBloc extends Bloc<CarEvent, CarState> {
  final UploadCar _uploadCar;
  final GetAllCars _getAllCars;
  CarBloc({
    required UploadCar uploadCar,
    required GetAllCars getAllCars,
  })  : _uploadCar = uploadCar,
        _getAllCars = getAllCars,
        super(CarInitial()) {
    on<CarEvent>((event, emit) => emit(CarLoading()));
    on<CarUpload>(_onCarUpload);
    on<CarFetchAllCars>(_onFetchAllCars);
  }

  void _onCarUpload(
    CarUpload event,
    Emitter<CarState> emit,
  ) async {
    final res = await _uploadCar(
      UploadCarParams(
        imageUrls: event.files.map((xfile) => File(xfile.path)).toList(),
        pricePerHour: event.car.pricePerHour,
        distance: event.car.distance,
        fuelCapacity: event.car.fuelCapacity,
        model: event.car.model,
      ),
    );

    res.fold(
      (l) => emit(CarFailure(l.message)),
      (r) => emit(CarUploadSuccess()),
    );
  }

  void _onFetchAllCars(
    CarFetchAllCars event,
    Emitter<CarState> emit,
  ) async {
    final res = await _getAllCars(NoParams());

    res.fold(
      (l) => emit(CarFailure(l.message)),
      (r) => emit(CarsDisplaySuccess(r)),
    );
  }
}
