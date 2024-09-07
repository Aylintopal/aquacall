import 'package:aquacall/core/constants/app_constants.dart';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/presentation/home/home_page.dart';
import 'package:aquacall/widgets/custom_button.dart';
import 'package:aquacall/widgets/custom_text_form_field.dart';
import 'package:aquacall/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<CustomTextFormField> formList = [
      CustomTextFormField(controller: _ageController, hintText: 'Yaşınız'),
      CustomTextFormField(controller: _heightController, hintText: 'Boyunuz'),
      CustomTextFormField(controller: _weightController, hintText: 'Kilonuz'),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAnimationWidget(),
            Padding(
              padding: AppConstants.allPadding20,
              child: Column(
                children: [
                  _buildTitleText(),
                  _buildFormFields(formList),
                  _buildButton(context),
                  _buildSettingsText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildFormFields(List<CustomTextFormField> formList) {
    return Padding(
      padding: AppConstants.verticalPadding20,
      child: Column(children: formList),
    );
  }

  AspectRatio _buildAnimationWidget() {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Lottie.asset(
        AssetConstants.waveAnimation,
        fit: BoxFit.cover, // This will crop the animation
      ),
    );
  }

  Text _buildSettingsText() {
    return Text(
      "Kişisel verilerinizi daha sonra 'Ayarlar' sayfasından değiştirebilirsiniz.",
      style: TextStyle(fontSize: 11.sp),
      textAlign: TextAlign.center,
    );
  }

  CustomButton _buildButton(BuildContext context) {
    return CustomButton(
      onPressed: () {
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
          context.read<AppCubit>().addData(age, height, weight);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => AppCubit(),
                child: const HomePage(),
              ),
            ),
          );
        }
        _ageController.clear();
        _heightController.clear();
        _weightController.clear();
      },
    );
  }

  Padding _buildTitleText() {
    return Padding(
      padding: AppConstants.verticalPadding20,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: 'Hoşgeldin!\n',
                style: TextStyle(fontSize: 32.sp, height: 2)),
            TextSpan(
                text: 'Günlük su ihtiyacın kişisel verilerine göre hesaplanır.',
                style: TextStyle(fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
