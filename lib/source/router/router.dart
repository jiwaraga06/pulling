import 'package:pulling/source/pages/Auth/login.dart';
import 'package:pulling/source/pages/Auth/splash.dart';
import 'package:pulling/source/pages/Menu/Pulling/filter.dart';
import 'package:pulling/source/pages/Menu/Pulling/insert.dart';
import 'package:pulling/source/pages/Menu/Pulling/pulling.dart';
import 'package:pulling/source/pages/Menu/bottomNavBar.dart';
import 'package:pulling/source/router/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterNavigation {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => Login());
      case BOTTOM_NAV_BAR:
        return MaterialPageRoute(builder: (context) => CustomBottomNavbar());
      // PULINNG
      case PULLING:
        return MaterialPageRoute(builder: (context) => Pulling());
      case FILTER_PULLING:
        return MaterialPageRoute(builder: (context) => FilterPulling());
      case INSERT_PULLING:
        return MaterialPageRoute(builder: (context) => InsertPulling());
      default:
        return null;
    }
  }
}
