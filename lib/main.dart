
import 'package:apartment/cubit/user_cubit.dart';
import 'dart:io';
import 'package:apartment/cubit/user_state.dart';
import 'package:apartment/repository/auth_repo.dart';
import 'package:apartment/ui/route/app_router.dart';
import 'package:apartment/ui/screens/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:apartment/cubit/theme_cubit.dart';
import 'package:apartment/ui/screens/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// Try using const constructors as much as possible!

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  final tmpDir = await getTemporaryDirectory();
  Hive.init(tmpDir.toString());

  final storage = await HydratedStorage.build(
    storageDirectory: tmpDir,
  );

  HydratedBlocOverrides.runZoned(
        () => runApp(
      EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('ru'),
          Locale('en'),
        ],
        fallbackLocale: const Locale('ru'),
        useFallbackTranslations: true,
        child: MyApp(),
      ),
    ),
    storage: storage,
  );
}

class MyApp extends StatefulWidget {


   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  final storage = FlutterSecureStorage();
  Widget page = LoginPage();

  void checkLogin() async{
    String? token = await storage.read(key: "token");
    String? name = await storage.read(key: "name");
    if (token != null && name != null){
      page = Home();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>ThemeCubit()),
      BlocProvider(create: (_)=>UserBloc(LoginInitState(), AuthRepository(),"")),

    ],

          child: BlocBuilder<ThemeCubit,ThemeState>(
            builder: (context, state) {
              return  MaterialApp(
              /// Localization is not available for the title.
              title: 'app_name',
              onGenerateRoute: _appRouter.generateRoute,
              initialRoute: '/',
              theme: state.themeData,
              routes: {
              "/":(context) => page,
              '/home':(context)=>Home(),
              },
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              );

            }),

          );


  }
}
