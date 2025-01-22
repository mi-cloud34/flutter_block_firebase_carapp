import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_block_firebase_carapp/core/error/exceptions.dart';
import 'package:flutter_block_firebase_carapp/features/car/data/models/car_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

abstract interface class CarRemoteDataSource {
  Future<CarModel> uploadCar(CarModel car);
  Future<List<String>> uploadCarImages({
    required List<File> images,
    required CarModel car,
  });
  Future<List<CarModel>> getAllCars();
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final FirebaseFirestore firestore;
  final CloudinaryPublic cloudinary;

  CarRemoteDataSourceImpl(this.firestore, Object object)
      : cloudinary = CloudinaryPublic('mst1993-hb', 'flutter-car', cache: false);

  @override
  Future<CarModel> uploadCar(CarModel car) async {
    try {
      final carRef = firestore.collection('cars').doc();
      await carRef.set(car.toJson());

      return car.copyWith(id: carRef.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> uploadCarImages({
    required List<File> images,
    required CarModel car,
  }) async {
    try {
      List<String> imageUrls = [];
      for (File image in images) {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: 'car_images'),
        );
        imageUrls.add(response.secureUrl);
      }
      return imageUrls;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CarModel>> getAllCars() async {
    try {
      final querySnapshot = await firestore.collection('cars').get();
      print("carsss: ${querySnapshot}");
      return querySnapshot.docs
          .map((doc) => CarModel.fromJson(doc.data() as Map<String, dynamic>).copyWith(id: doc.id))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}