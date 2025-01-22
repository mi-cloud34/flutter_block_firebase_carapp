
import 'package:flutter_block_firebase_carapp/features/car/data/models/car_model.dart';
import 'package:hive/hive.dart';

abstract interface class CarLocalDataSource {
  void uploadLocalcars({required List<CarModel> cars});
  List<CarModel> loadCars();
}

class CarLocalDataSourceImpl implements CarLocalDataSource {
  final Box box;
  CarLocalDataSourceImpl(this.box);

  @override
  List<CarModel> loadCars() {
    List<CarModel> cars = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        cars.add(CarModel.fromJson(box.get(i.toString())));
      }
    });

    return cars;
  }

  @override
  void uploadLocalcars({required List<CarModel> cars}) {
    box.clear();

    box.write(() {
      for (int i = 0; i < cars.length; i++) {
        box.put(i.toString(), cars[i].toJson());
      }
    });
  }
}
