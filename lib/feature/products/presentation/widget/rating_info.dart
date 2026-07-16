import 'package:flutique/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RatingInfo extends StatelessWidget {
  final String rating;

  const RatingInfo({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.yellow,
          ),
          child: Row(
            children: [
              Icon(Icons.star_half, size: 14),
              Text(
                rating,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text(
          '(164 Reviews)',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
