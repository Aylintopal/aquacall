import 'package:aquacall/core/constants/app_constants.dart';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RainIcons extends StatelessWidget {
  const RainIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.verticalPadding10,
      child: Row(
        children: [
          _buildIcon(AssetConstants.redRaindropSvg),
          _buildIcon(AssetConstants.yellowRaindropSvg),
          _buildIcon(AssetConstants.blueRaindropSvg),
          _buildIcon(AssetConstants.greenRaindropSvg),
        ],
      ),
    );
  }

  Widget _buildIcon(String icon) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: SvgPicture.asset(icon, height: 16.h),
    );
  }
}
