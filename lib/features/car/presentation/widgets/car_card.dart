import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_block_firebase_carapp/features/car/domain/entities/car.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/pages/car_detail_page.dart';
import 'package:flutter_block_firebase_carapp/features/car/presentation/widgets/car_car_image_slider.dart';

class CarCard extends StatefulWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: () {
        Navigator.push(
          context,
          CardDetailsPage.route(widget.car),
        );
      },
      child: Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffF3F3F3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CarCardImageSlider(imageUrls: widget.car.imageUrls),
              SizedBox(height: 10),
              Text(
                widget.car.model,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/gps.png', height: 8),
                      SizedBox(width: 5),
                      Text('${widget.car.distance.toStringAsFixed(0)}km', style: TextStyle(fontSize: 12, color: Colors.black)),
                      SizedBox(width: 20),
                      Text(
                        '\$${widget.car.pricePerHour.toStringAsFixed(2)}/h',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}