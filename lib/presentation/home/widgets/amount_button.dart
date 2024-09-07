import 'package:aquacall/data/models/app_model.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AmountButton extends StatefulWidget {
  final String icon;
  final String amount;
  final Color background;
  final Color textColor;
  final AppModel data;
  final int addAmount;
  const AmountButton({
    super.key,
    required this.icon,
    required this.amount,
    required this.background,
    required this.textColor,
    required this.data,
    required this.addAmount,
  });

  @override
  State<AmountButton> createState() => _AmountButtonState();
}

class _AmountButtonState extends State<AmountButton> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AppCubit>().updateAmount(widget.data, widget.addAmount);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.h),
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(widget.icon, height: 22.h),
              Text(
                '   ${widget.amount} ml',
                style: TextStyle(fontSize: 16.sp, color: widget.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
