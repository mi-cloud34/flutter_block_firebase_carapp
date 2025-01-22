import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_bloc.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_event.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/bloc/car_state.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/widgets/car_card.dart';

class CarListPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => CarListPage(),
      );
  CarListPage({super.key});

  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  final Random _random = Random();

  Offset _getRandomOffset() {
    //return Offset(_random.nextDouble() * 0.5, _random.nextDouble() * 0.5);
    switch (_random.nextInt(4)) {
      case 0:
        return Offset(-1.0, 0.0); // Soldan giriş
      case 1:
        return Offset(1.0, 0.0); // Sağdan giriş
      case 2:
        return Offset(0.0, -1.0); // Yukarıdan giriş
      default:
        return Offset(0.0, 1.0); // Aşağıdan giriş
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CarBloc>().add(CarFetchAllCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car List'),
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CarsDisplaySuccess) {
            _controllers = List.generate(state.cars.length, (index) {
              return AnimationController(
                duration: const Duration(milliseconds: 2500),
                vsync: this,
              );
            });

            _animations = List.generate(state.cars.length, (index) {
              return Tween<Offset>(
                begin: _getRandomOffset(), 
                end: Offset.zero, 
              ).animate(CurvedAnimation(
                parent: _controllers[index],
                curve: Curves.easeInOut,
              ));
            });

            for (var controller in _controllers) {
              controller.forward();
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // İki sütun
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // Kartların boyut oranı
              ),
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controllers[index],
                  builder: (context, child) {
                    return SlideTransition(
                      position: _animations[index],
                      child: CarCard(car: state.cars[index]),
                    );
                  },
                );
              },
              padding: const EdgeInsets.all(10.0),
            );
          } else if (state is CarFailure) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text('No cars available'));
          }
        },
      ),
    );
  }
}
