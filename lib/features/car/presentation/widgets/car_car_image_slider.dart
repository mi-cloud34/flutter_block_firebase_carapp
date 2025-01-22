import 'dart:async';
import 'package:flutter/material.dart';

class CarCardImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  const CarCardImageSlider({super.key, required this.imageUrls});

  @override
  State<CarCardImageSlider> createState() => _CarCardImageSliderState();
}

class _CarCardImageSliderState extends State<CarCardImageSlider> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == widget.imageUrls.length - 1) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}