import 'package:ecommerce/cores/utiles/app_assets.dart';
import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor:   AppColors.greenButton,
      indicatorBackgroundColor: Colors.grey,
      autoPlayInterval: 3000,
      isLoop: true,
      children: [_buildBanner(), _buildBanner(), _buildBanner()],
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(AppAssets.banner, fit: BoxFit.cover),
    );
  }
}
