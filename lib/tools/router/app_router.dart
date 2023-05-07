import 'package:flutter/material.dart';

import '../../splash_screen.dart';
import '../../todo_feature/screens/add_todo_screen.dart';
import '../../todo_feature/screens/edit_todo_screen.dart';
import '../../todo_feature/screens/show_todo_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRout(RouteSettings settings) {
    switch (settings.name) {
      case ShowTodoScreen.screenId:
        return MaterialPageRoute(builder: (_) => const ShowTodoScreen());

      case AddTodoScreen.screenId:
        return MaterialPageRoute(builder: (_) => const AddTodoScreen());

        case SplashScreen.screenId:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case EditTodoScreen.screenId:
        List<dynamic>? args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (_) => EditTodoScreen(
            id: args[0],
            title: args[1],
            desc: args[2],
            submitDate: args[3],
            goalDate: args[4],
            isDone: args[5],
            index: args[6],
          ),
        );

      // case ProductDetailScreen.screenId:
      //   List<dynamic>? args = settings.arguments as List<dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => ProductDetailScreen(productId: args[0], screenName: args[1]));

      default:
        return null;
    }
  }
}
