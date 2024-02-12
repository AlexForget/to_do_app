import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/tasks/bloc/task_list_bloc.dart';
import 'package:to_do_app/src/features/tasks/data/local_db.dart';
import 'package:to_do_app/src/features/tasks/models/task_model.dart';
import 'package:to_do_app/src/helpers/bloc_obesrver.dart';
import 'package:to_do_app/src/helpers/constants.dart';
import 'package:to_do_app/src/features/tasks/presentation/screen/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

void main() async {
  // ignore: await_only_futures
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  // ignore: unused_local_variable
  boxNotes = await Hive.openBox<TaskModel>(noteHiveBox);
  Bloc.observer = const SimpleBlocObserver();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider(
      create: (context) => TaskListBloc(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (contect) => TaskListBloc()..add(InitialTask()))
        ],
        child: MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.bitter().fontFamily,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.light,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomePage(),
        ),
      ),
    );
  }
}
