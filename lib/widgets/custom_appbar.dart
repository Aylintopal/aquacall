import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback onPressed;

  const CustomAppbar({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),
      ),
      titleSpacing: 0,
      leading: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.keyboard_backspace, size: 22.w)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
