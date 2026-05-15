import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? height;
  const BasicButton(
    {super.key, required this.onPressed, required this.title, this.height}
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
        backgroundColor: AppColors.primary
      ), 
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }
}
