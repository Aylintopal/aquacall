import 'package:aquacall/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.verticalPadding10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          minimumSize: Size(double.infinity, 32.h),
        ),
        onPressed: onPressed,
        child: const Text(
          "KAYDET",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
