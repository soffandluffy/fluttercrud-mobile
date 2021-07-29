import 'package:flutter/material.dart';
import 'package:fluttercrud/presentation/Opportunities/opportunities_page.dart';
import 'package:fluttercrud/presentation/Opportunities/opportunity_add.dart';
import 'package:fluttercrud/presentation/Opportunities/opportunity_detail.dart';
import 'package:fluttercrud/presentation/auth/login_page.dart';
import 'package:fluttercrud/presentation/auth/register_page.dart';
import 'package:fluttercrud/presentation/forum/question_detail_page.dart';
import 'package:fluttercrud/presentation/home/home_page.dart';
import 'package:fluttercrud/presentation/not_found/not_found_page.dart';
import 'package:fluttercrud/router/route_constants.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case opportunitiesRoute:
        return MaterialPageRoute(builder: (_) => OpportunitiesPage());
      case opportunityDetailRoute:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => OpportunityDetailPage());
      case opportunityAddRoute:
        return MaterialPageRoute(builder: (_) => OpportunityAddPage());
      case questionDetailRoute:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => QuestionDetailPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
