import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/constants/colors.dart';
import 'package:wordle_app/pages/settings.dart';
import 'package:wordle_app/providers/controller.dart';
import 'package:wordle_app/providers/theme_provider.dart';
import 'package:wordle_app/themes/theme_preferences.dart';
import 'package:wordle_app/themes/themes.dart';
import 'providers/controller.dart';
import 'package:wordle_app/pages/settings.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],

      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      initialData: false,
      future: ThemePreferences.getTheme(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            Provider.of<ThemeProvider>(context, listen: false).setTheme(turn0n:
            snapshot.data as bool
            );
          });
        }


        return Consumer<ThemeProvider>(
        builder: (_, notifier, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wordle App',
          theme: notifier.isDark ? darkTheme : lightTheme,
          home: const HomePage(),
        ),
       );
      },
    );
  }
}

