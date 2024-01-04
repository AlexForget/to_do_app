import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/src/features/notes/bloc/note_list_bloc.dart';
import 'package:to_do_app/src/features/notes/models/note_model.dart';
import 'package:to_do_app/src/features/notes/models/note_model_box.dart';
import 'package:to_do_app/src/helpers/bloc_obesrver.dart';
import 'package:to_do_app/src/helpers/constants.dart';
import 'package:to_do_app/src/features/notes/presentation/screen/home_page.dart';

void main() async {
  // ignore: await_only_futures
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  // ignore: unused_local_variable
  boxNotes = await Hive.openBox<NoteModel>(noteHiveBox);
  // boxNotes.deleteAt(0);
  // await boxNotes.clear();
  print(boxNotes.values);
  Bloc.observer = const SimpleBlocObserver();
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
      create: (context) => NoteListBloc(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (contect) => NoteListBloc()..add(InitialNote()))
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
