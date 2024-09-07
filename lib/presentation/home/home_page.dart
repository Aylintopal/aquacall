import 'package:aquacall/core/constants/app_constants.dart';
import 'package:aquacall/core/constants/asset_constants.dart';
import 'package:aquacall/data/cubit/app_cubit.dart';
import 'package:aquacall/data/cubit/app_cubit_state.dart';
import 'package:aquacall/data/models/app_model.dart';
import 'package:aquacall/presentation/home/widgets/add_button.dart';
import 'package:aquacall/presentation/home/widgets/amount_button.dart';
import 'package:aquacall/presentation/home/widgets/home_appbar.dart';
import 'package:aquacall/presentation/home/widgets/rain_icons.dart';
import 'package:aquacall/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(context),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          if (state is DataLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blueGrey));
          } else if (state is DataLoaded) {
            final data = state.data;
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  final dataList = data[index];
                  return _buildBody(context, dataList);
                });
          } else if (state is DataError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppModel data) {
    List<AmountButton> amountWidgetList = [
      AmountButton(
        icon: AssetConstants.redRaindropSvg,
        amount: '150',
        background: Colors.red.shade50,
        textColor: Colors.red.shade900,
        data: data,
        addAmount: 150,
      ),
      AmountButton(
        icon: AssetConstants.yellowRaindropSvg,
        amount: '180',
        background: Colors.yellow.shade100,
        textColor: Colors.yellow.shade800,
        data: data,
        addAmount: 180,
      ),
      AmountButton(
        icon: AssetConstants.blueRaindropSvg,
        amount: '250',
        background: Colors.blue.shade50,
        textColor: Colors.blue.shade900,
        data: data,
        addAmount: 250,
      ),
      AmountButton(
        icon: AssetConstants.greenRaindropSvg,
        amount: '500',
        background: Colors.green.shade50,
        textColor: Colors.green.shade900,
        data: data,
        addAmount: 500,
      ),
    ];

    return Padding(
      padding: AppConstants.horizontalPadding20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCircularIndicator(
              dailyGoal: data.dailyGoal!, currentAmount: data.amount!),
          const RainIcons(),
          Text(
            'İçilen su miktarını ekleyin',
            style: TextStyle(fontSize: 12.sp),
          ),
          GridView.builder(
              padding: AppConstants.verticalPadding20,
              shrinkWrap: true,
              itemCount: amountWidgetList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                return amountWidgetList[index];
              }),
          Center(child: AddButton(appData: data)),
        ],
      ),
    );
  }
}
