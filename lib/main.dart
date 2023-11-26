import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_tp/modules/splash_screen.dart';
import 'package:mobile_tp/shared/cubit/app_cubit.dart';
import 'package:mobile_tp/shared/cubit/app_states.dart';
import 'package:mobile_tp/shared/cubit/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_tp/themes_and_componants/noty_text_Style.dart';
import 'package:mobile_tp/themes_and_componants/responsive.dart';

import 'isNear.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(blocObserver: MyBlocObserver(),
          ()   {
        runApp(MyApp());
      })
  ;}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (create)=>AppCubit()..createdDatabase(),),
        ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener:(context,state){},
          builder:(context,state){

            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                  fillColor: nColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: nColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: nColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelStyle: TextStyle(
                    color: nColor,
                  ),
                ),
                primarySwatch: Colors.blue,
              ),
              home:isNear(),
              //const SplahsScreen(),
            );
          },
        ),),
    );
  }
}
