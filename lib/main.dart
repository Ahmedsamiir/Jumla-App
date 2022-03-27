import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layouts/login/shop_login_screen.dart';
import 'package:salla/layouts/shopLayout/cubit/state.dart';
import 'package:salla/layouts/shopLayout/shop_layout.dart';
import 'package:salla/shared/components/constant.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/themes.dart';

import 'layouts/onBoarding/on_boarding_screen.dart';
import 'layouts/shopLayout/cubit/cubit.dart';
import 'modules/bloc_observer.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

   DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding')??false;
  token = CacheHelper.getData(key: 'token')??"null";
  if(onBoarding!=null){

    if(token!="null")  widget = const ShopLayout();
     else widget = ShopLoginScreen();

  }else{
    widget = const OnBoardingScreen();
  }

  BlocOverrides.runZoned(
        () {

      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
   MyApp({
    required this.startWidget,
});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(date
          create: (context)=> ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
