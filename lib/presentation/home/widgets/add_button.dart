import 'package:aquacall/core/constants/app_constants.dart';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/models/app_model.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddButton extends StatefulWidget {
  final AppModel appData;
  const AddButton({super.key, required this.appData});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.allPadding10,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CustomAlertDialog(
              title: 'Miktar Ekle (ml)',
              content: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 12.w),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                cursorWidth: 1,
                cursorColor: Colors.blueGrey,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Vazgeç',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400))),
                TextButton(
                    onPressed: () {
                      int newAmount = _amountController.text == ''
                          ? 0
                          : int.parse(_amountController.text);
                      context
                          .read<AppCubit>()
                          .updateAmount(widget.appData, newAmount);
                      Navigator.pop(context);
                      _amountController.clear();
                    },
                    child: Text('Kaydet',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp)))
              ],
              icon: AssetConstants.addWaterImg,
            ),
          );
        },
        icon: Image.asset(AssetConstants.addAmountImg, height: 28.h),
      ),
    );
  }
}
