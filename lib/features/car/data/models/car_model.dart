import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';

class CarModel extends Car {
  CarModel({
    required super.imageUrls,
    required super.model,
    required super.distance,
    required super.fuelCapacity,
    required super.pricePerHour, 
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'distance': distance,
      'fuel_capacity': fuelCapacity,
      'price_per_hour': pricePerHour,
      'imageUrls': imageUrls,
    };
  }

  factory CarModel.fromJson(Map<String, dynamic> map) {
    return CarModel(
      model: map['model'] as String,
      distance: map['distance'] as double,
      fuelCapacity: map['fuel_capacity'] as double,
      pricePerHour: map['price_per_hour'] as double, 
      id: map['id'] as String,
      imageUrls: List<String>.from(map['imageUrls'] as List),
    );
  }

  CarModel copyWith({
    String? id,
    String? model,
    double? distance,
    double? fuelCapacity,
    double? pricePerHour,
    List<String>? imageUrls,
  }) {
    return CarModel(
      id: id ?? this.id,
      model: model ?? this.model,
      distance: distance ?? this.distance,
      fuelCapacity: fuelCapacity ?? this.fuelCapacity,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}