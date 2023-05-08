import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_hive_project/splash_screen.dart';
import 'package:flutter_bloc_hive_project/todo_feature/logic/bloc/todo_bloc.dart';
import 'package:flutter_bloc_hive_project/todo_feature/model/todo_model.dart';
import 'package:flutter_bloc_hive_project/tools/router/app_router.dart';
import 'package:flutter_bloc_hive_project/tools/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TodoModelAdapter());

  runApp(
    BlocProvider(
      create: (context) => TodoBloc(),
      child: MyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fa')],
        onGenerateRoute: appRouter.onGenerateRout,
        // home: ShowTodoScreen(),
        initialRoute: SplashScreen.screenId,
        theme: CustomTheme.lightTheme,
      ),
    );
  }
}
