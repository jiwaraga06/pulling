import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulling/source/data/Auth/cubit/account_cubit.dart';
import 'package:pulling/source/data/Auth/cubit/login_cubit.dart';
import 'package:pulling/source/data/Auth/cubit/shift_cubit.dart';
import 'package:pulling/source/data/Auth/cubit/splash_cubit.dart';
import 'package:pulling/source/data/Menu/Pulling/cubit/insert_scan_cubit.dart';
import 'package:pulling/source/data/Menu/Pulling/cubit/pulling_cubit.dart';
import 'package:pulling/source/data/Menu/Pulling/cubit/save_pulling_cubit.dart';
import 'package:pulling/source/data/Menu/Pulling/cubit/workcenter_cubit.dart';
import 'package:pulling/source/network/network.dart';
import 'package:pulling/source/repository/repository.dart';
import 'package:pulling/source/router/router.dart';

void main() {
  runApp(MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  const MyApp({super.key, this.router, this.myRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => ShiftCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => AccountCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => LoginCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => PullingCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => InsertScanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => SavePullingCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => WorkcenterCubit(myRepository: myRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}
