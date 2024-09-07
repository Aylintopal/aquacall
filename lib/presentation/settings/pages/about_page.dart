import 'package:aquacall/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
          title: 'Hakkında', onPressed: () => Navigator.pop(context)),
      body: const Center(
        child: Text('Developed by AYLİN TOPAL'),
      ),
    );
  }
}
