import 'package:aquacall/data/services/notification_service.dart';
import 'package:aquacall/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _notifySwitch = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadNotificationSwitchStatus();
  }

  void _loadNotificationSwitchStatus() => setState(
      () => _notifySwitch = NotificationService.getNotificationStatus());

  @override
  Widget build(BuildContext context) {
    List<Widget> listTileList = [
      _buildSwitchListTile(
        text: 'Bildirimler',
        trailing: Switch(
          value: _notifySwitch,
          onChanged: (val) async {
            setState(() => _notifySwitch = val);
            if (!val) {
              NotificationService.cancelNotification();
            } else {
              NotificationService.scheduleNotification();
            }
          },
          activeTrackColor: Colors.blueGrey,
          thumbColor: MaterialStateProperty.all(Colors.white),
          inactiveTrackColor: Colors.blueGrey.shade200,
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
      _buildSwitchListTile(
        text: 'Hatırlatma',
        trailing: Text(
          'Her 60 dakikada',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
          title: 'Bildirim Ayarları', onPressed: () => Navigator.pop(context)),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        child: Column(
          children: listTileList,
        ),
      ),
    );
  }

  Widget _buildSwitchListTile({String? text, Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(vertical: -1),
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
          leading: Text(
            text!,
            style: TextStyle(fontSize: 14.sp),
          ),
          trailing: trailing,
        ),
        const Divider(),
      ],
    );
  }
}
