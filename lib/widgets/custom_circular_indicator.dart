import 'package:aquacall/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularIndicator extends StatefulWidget {
  final int dailyGoal;
  final int currentAmount;

  const CustomCircularIndicator(
      {super.key, required this.dailyGoal, required this.currentAmount});

  @override
  State<CustomCircularIndicator> createState() =>
      _CustomCircularIndicatorState();
}

class _CustomCircularIndicatorState extends State<CustomCircularIndicator> {
  double get _currentProgress {
    if (widget.dailyGoal == 0) return 0.0;
    double progress = widget.currentAmount / widget.dailyGoal;
    return progress > 1.0 ? 1.0 : progress;
  }

  @override
  Widget build(BuildContext context) {
    final kalan = widget.dailyGoal - widget.currentAmount;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Center(
        child: CircularPercentIndicator(
          radius: 100.r,
          percent: _currentProgress > 0 ? _currentProgress : 0.001,
          lineWidth: 10,
          backgroundColor: Colors.grey.shade300,
          progressColor: Colors.red.shade900,
          animation: true,
          animateFromLastPercent: true,
          curve: Curves.fastOutSlowIn,
          animationDuration: 1500,
          circularStrokeCap: CircularStrokeCap.round,
          header: Padding(
            padding: AppConstants.verticalPadding10,
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                children: [
                  TextSpan(
                      text: widget.dailyGoal == 0
                          ? "Hedef belirlemek için bilgilerinizi güncelleyin."
                          : "Hedef: "),
                  TextSpan(
                      text: widget.dailyGoal == 0
                          ? ''
                          : "${widget.dailyGoal} ml ",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          footer: Padding(
            padding: AppConstants.verticalPadding10,
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                children: [
                  TextSpan(
                      text: widget.currentAmount >= widget.dailyGoal
                          ? ""
                          : "Kalan: "),
                  if (widget.dailyGoal != 0)
                    TextSpan(
                        text: widget.currentAmount >= widget.dailyGoal
                            ? "Günlük hedefe ulaşıldı!"
                            : "$kalan ml",
                        style: widget.currentAmount >= widget.dailyGoal
                            ? TextStyle(
                                color: Colors.lightGreen.shade800,
                                fontWeight: FontWeight.w500)
                            : const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tüketilen",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                "${widget.currentAmount}",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
