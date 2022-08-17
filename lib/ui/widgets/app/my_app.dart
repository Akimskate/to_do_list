import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/provider/theme_provider.dart';
import 'package:todo_list_app/ui/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNAvigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          routes: mainNavigation.routes,
          initialRoute: mainNavigation.initialRoute,
          onGenerateRoute: mainNavigation.onGenerateRoute,
          themeMode: provider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
        );
      });
}
