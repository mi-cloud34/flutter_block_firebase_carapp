import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_event.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_bloc.dart';

class AddCarPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddCarPage());
  const AddCarPage({super.key});

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage>  {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _distanceController = TextEditingController();
  final _fuelCapacityController = TextEditingController();
  final _pricePerHourController = TextEditingController();
  final List<File> _selectedImages = [];


 

  @override
  void dispose() {
    _modelController.dispose();
    _distanceController.dispose();
    _fuelCapacityController.dispose();
    _pricePerHourController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages.addAll(images.map((image) => File(image.path)).toList());
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceController,
                decoration: InputDecoration(labelText: 'Distance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the distance';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fuelCapacityController,
                decoration: InputDecoration(labelText: 'Fuel Capacity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fuel capacity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricePerHourController,
                decoration: InputDecoration(labelText: 'Price Per Hour'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price per hour';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Pick Images'),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _selectedImages.map((image) {
                  return Image.file(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
            final car = Car(
      id: UniqueKey().toString(),
      model: _modelController.text,
      distance: double.parse(_distanceController.text),
      fuelCapacity: double.parse(_fuelCapacityController.text),
      pricePerHour: double.parse(_pricePerHourController.text),
      imageUrls: [], // Initially empty, will be updated by Bloc
            );
            context.read<CarBloc>().add(CarUpload(car:car, files: _selectedImages.map((file) => XFile(file.path)).toList()));
            Navigator.pop(context);
          }
                },
                child: Text('Add Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}