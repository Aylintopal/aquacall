import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/presentation/home/home_page.dart';
import 'package:aquacall/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: 'Ayarlar',
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => AppCubit(),
                child: const HomePage(),
              ),
            ));
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
