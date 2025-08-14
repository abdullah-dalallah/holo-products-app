import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color color;

  const StarRatingWidget({
    super.key,
    this.rating = 0.0,
    this.starCount = 5,
    this.color = Colors.amber,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
        size: 16.0,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: 16.0,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: 16.0,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
            (index) => buildStar(context, index),
      ),
    );
  }
}