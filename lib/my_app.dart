import 'package:classconnect/features/intro/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'ClassConnect',
        // theme: ThemeData(
        //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //     type: BottomNavigationBarType.shifting,
        //   ),
        // ),
        // darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        // locale: const Locale('ar'),
        // localizationsDelegates: const [
        //   S.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: S.delegate.supportedLocales,
        home: const SplashScreen(),
        // home: LogInScreen(),
        // home: BlocProvider(
        //    create: (context) => HomeCubit(),
        //    child: HomeScreen(),
        // home: BlocProvider(
        //   create: (context) => SignUpCubit(),
        //   child: SignUpScreen(),
        ),
    );
  }
}