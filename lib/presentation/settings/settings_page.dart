import 'package:aquacall/core/constants/app_constants.dart';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/data/cubit/app_cubit_state.dart';
import 'package:aquacall/data/models/app_model.dart';
import 'package:aquacall/presentation/settings/pages/about_page.dart';
import 'package:aquacall/presentation/settings/widgets/banner.dart';
import 'package:aquacall/presentation/settings/widgets/settings_appbar.dart';
import 'package:aquacall/widgets/custom_alert_dialog.dart';
import 'package:aquacall/widgets/custom_list_tile.dart';
import 'package:aquacall/widgets/custom_text_form_field.dart';
import 'package:aquacall/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/notification_settings_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          if (state is DataLoading) {
            return const CircularProgressIndicator(color: Colors.blueGrey);
          } else if (state is DataLoaded) {
            final data = state.data;
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final dataList = data[index];
                  return _buildBody(dataList);
                });
          } else if (state is DataError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBody(AppModel data) {
    List<CustomListTile> listTileWidgets = [
      CustomListTile(
        title: 'Bilgilerini Güncelle',
        leading: AssetConstants.adminSvg,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                List<Widget> customFieldList = [
                  CustomTextFormField(
                      controller: _ageController, hintText: 'Yaş'),
                  CustomTextFormField(
                      controller: _heightController, hintText: 'Boy'),
                  CustomTextFormField(
                      controller: _weightController, hintText: 'Kilo'),
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
                        .updateUserData(data, age, height, weight);
                    Navigator.pop(context);
                  }
                  _ageController.clear();
                  _heightController.clear();
                  _weightController.clear();
                }

                return CustomAlertDialog(
                  title: 'Bilgilerini güncelle',
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: customFieldList),
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
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.black))),
                  ],
                  icon: AssetConstants.redoImg,
                );
              });
        },
      ),
      CustomListTile(
        title: 'Verilerini Sıfırla',
        leading: AssetConstants.deleteSvg,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return CupertinoAlertDialog(
                  title: Image.asset(AssetConstants.waterScarcityImg,
                      height: 30.h),
                  content: Text('Emin misin?',
                      style: TextStyle(fontSize: 16.sp, height: 2)),
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon:
                            Text("Vazgeç", style: TextStyle(fontSize: 14.sp))),
                    IconButton(
                        onPressed: () {
                          context.read<AppCubit>().deleteAmount(data);
                          Navigator.pop(context);
                        },
                        icon: Text("Sıfırla",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500))),
                  ],
                );
              });
        },
      ),
      CustomListTile(
        title: 'Bildirimler',
        leading: AssetConstants.notificationSvg,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationSettingsPage()));
        },
      ),
      CustomListTile(
        title: 'Hakkında',
        leading: AssetConstants.infoSvg,
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutPage())),
      ),
      CustomListTile(
        title: 'Çıkış Yap',
        leading: AssetConstants.logoutSvg,
        color: Colors.red.shade700,
        onTap: () => SystemNavigator.pop(),
      ),
    ];

    return Padding(
      padding: AppConstants.horizontalPadding10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsBanner(data: data),
          ...listTileWidgets,
        ],
      ),
    );
  }
}
