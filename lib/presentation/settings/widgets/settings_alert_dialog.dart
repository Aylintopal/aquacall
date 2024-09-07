import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/models/app_model.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/widgets/custom_alert_dialog.dart';
import 'package:aquacall/widgets/custom_text_form_field.dart';
import 'package:aquacall/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsAlertDialog extends StatefulWidget {
  final AppModel data;
  const SettingsAlertDialog({super.key, required this.data});

  @override
  State<SettingsAlertDialog> createState() => _SettingsAlertDialogState();
}

class _SettingsAlertDialogState extends State<SettingsAlertDialog> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).fetchData();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> customFieldList = [
      CustomTextFormField(controller: _ageController, hintText: 'Yaş'),
      CustomTextFormField(controller: _heightController, hintText: 'Boy'),
      CustomTextFormField(controller: _weightController, hintText: 'Kilo'),
    ];

    void editOnPressed() {
      final age = int.tryParse(_ageController.text);
      final height = double.tryParse(_heightController.text);
      final weight = double.tryParse(_weightController.text);

      if (age == null) {
        toast(context, 'Yaş bilgisi boş bırakılamaz!');
      } else if (weight == null) {
        toast(context, 'Kilo bilgisi boş bırakılamaz!');
      } else if (height == null) {
        toast(context, 'Boy bilgisi boş bırakılamaz!');
      } else {
        context
            .read<AppCubit>()
            .updateUserData(widget.data, age, height, weight);
        Navigator.pop(context);
      }
      _ageController.clear();
      _heightController.clear();
      _weightController.clear();
    }

    return CustomAlertDialog(
      title: 'Bilgilerini güncelle',
      content:
          Column(mainAxisSize: MainAxisSize.min, children: customFieldList),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              _ageController.clear();
              _heightController.clear();
              _weightController.clear();
            },
            child: Text('Vazgeç',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black))),
        TextButton(
            onPressed: () => editOnPressed(),
            child: Text('Güncelle',
                style: TextStyle(fontSize: 14.sp, color: Colors.black))),
      ],
      icon: AssetConstants.redoImg,
    );
  }
}
