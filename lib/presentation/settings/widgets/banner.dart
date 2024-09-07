import 'package:aquacall/core/constants/app_constants.dart';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsBanner extends StatefulWidget {
  final AppModel data;
  const SettingsBanner({super.key, required this.data});

  @override
  State<SettingsBanner> createState() => _SettingsBannerState();
}

class _SettingsBannerState extends State<SettingsBanner> {
  @override
  Widget build(BuildContext context) {
    int completed = widget.data.dailyGoal! - widget.data.amount!;
    return Container(
      width: double.infinity,
      padding: AppConstants.allPadding10,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.blueGrey.shade900),
              children: [
                TextSpan(
                    text:
                        '${widget.data.amount} / ${widget.data.dailyGoal} ml\n',
                    style: TextStyle(fontSize: 16.sp)),
                widget.data.dailyGoal != 0
                    ? TextSpan(
                        text: widget.data.dailyGoal! <= widget.data.amount!
                            ? 'Günlük hedefe ulaşıldı!'
                            : 'Hedefe kalan: $completed ml',
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontSize: 12.sp,
                          height: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : TextSpan(
                        text: 'Bilgilerinizi güncelleyin.',
                        style: TextStyle(fontSize: 12.sp, height: 2)),
              ],
            ),
          ),
          Image.asset(AssetConstants.waterCharImg, height: 100.h),
        ],
      ),
    );
  }
}
