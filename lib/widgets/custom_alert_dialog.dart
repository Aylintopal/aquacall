import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String icon;
  final Widget? content;
  final List<Widget>? actions;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(title, style: TextStyle(fontSize: 14.sp)),
      icon: Image.asset(icon,height: 34.h),
      content: content ?? content,
      actions: actions ?? actions,
    );
  }
}
