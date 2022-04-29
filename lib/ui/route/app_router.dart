

import 'package:apartment/ui/route/route_constants.dart';
import 'package:apartment/ui/route/slide_route_builder.dart';
import 'package:apartment/ui/screens/deposite.dart';
import 'package:apartment/ui/screens/history.dart';
import 'package:apartment/ui/screens/home.dart';
import 'package:apartment/ui/screens/login_page.dart';
import 'package:apartment/ui/screens/messages.dart';
import 'package:apartment/ui/screens/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/my_location.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.depositeRoute:
        return SlideRouteBuilder(page: Deposite());
      case RouteConstant.loginRoute:
        return SlideRouteBuilder(page: LoginPage());
      case RouteConstant.historyRoute:
        return SlideRouteBuilder(page: History());
      case RouteConstant.messagesRoute:
        return SlideRouteBuilder(page: Messages());
      case RouteConstant.profileRoute:
        return SlideRouteBuilder(page: MyProfile());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
  
}
