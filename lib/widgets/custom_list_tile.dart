import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? leading;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? trailing;

 const CustomListTile({
    super.key,
    this.title,
    this.leading,
    this.color,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent),
          child: ListTile(
            onTap: onTap,
            leading: SvgPicture.asset(leading!,
                // ignore: deprecated_member_use
                height: 16.h, color: color ?? Colors.black),
            title: Text(title!,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: color ?? Colors.black,
                )),
            trailing: trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.w,
                  color: color ?? Colors.black,
                ),
            visualDensity: const VisualDensity(vertical: -4, horizontal: 1),
            contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
            dense: false,
          ),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}
