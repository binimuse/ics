import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarouselSlider extends StatefulWidget {
  const BannerCarouselSlider(
      {Key? key, required this.items, this.showIndicator = true})
      : super(key: key);

  final List<Widget> items;
  final bool showIndicator;

  @override
  State<BannerCarouselSlider> createState() => _NewsCarouselSliderState();
}

class _NewsCarouselSliderState extends State<BannerCarouselSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.items.length,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            viewportFraction: 1.0,
            aspectRatio: 1.0,
            height: 28.h,
            onPageChanged: (index, str) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, pageViewIndex) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: widget.items[index],
            );
          },
        ),
        widget.showIndicator
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.items.asMap().entries.map((item) {
                  return Container(
                    width: 7.0,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == item.key
                          ? AppColors.secondary
                          : AppColors.grayLighter,
                    ),
                  );
                }).toList(),
              )
            : const SizedBox(),
      ],
    );
  }
}
