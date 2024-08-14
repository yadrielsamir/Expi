import 'package:expiration_date/features/presentation/pages/Loading.dart';
import 'package:expiration_date/features/presentation/pages/Home.dart';
import 'package:expiration_date/features/presentation/pages/Error.dart';
import 'package:expiration_date/features/presentation/pages/Expired.dart';
import 'package:expiration_date/features/presentation/pages/Inventory.dart';
import 'package:flutter/material.dart';

class AppRouter{
  Route onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case 'loading':
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case 'expired':
        return MaterialPageRoute(builder: (_) => const ExpiredPage(expiredList: [],));
      case 'inventory':
        return MaterialPageRoute(builder: (_) => const InventoryPage());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }

  }
}
