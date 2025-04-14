import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'providers/user_provider.dart';
import 'repo/user_repo.dart';
import 'screens/homescreen_main/edit_user_deets.dart';
import 'screens/homescreen_main/friends.dart';
import 'screens/homescreen_main/home.dart';
import 'screens/homescreen_main/profile.dart';
import 'screens/homescreen_main/timecapsual_lock.dart';
import 'screens/homescreen_main/timecapsual_open.dart';
import 'screens/map_screens/map_home.dart';
import 'screens/map_screens/search.dart';
import 'screens/setup_screens/add_friends.dart';
import 'screens/setup_screens/add_widget.dart';
import 'screens/setup_screens/login.dart';
import 'screens/setup_screens/signup.dart';
import 'screens/setup_screens/welcome.dart';
import 'services/firebase_user_service.dart';
import 'services/user_service.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// don't remove the splash screen automatically
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// User service and repository
    /// Service can easily be swapped out for a different implementation here
    final UserService userService = FirebaseUserService();
    final UserRepository userRepository = UserRepository(userService);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          /// User provider - manages user state and authentication
          ChangeNotifierProvider(create: (_) => UserProvider(userRepository)),
        ],
        builder: (context, child) {
          AuthController.init(context.read<UserProvider>());

          return child!;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          builder: FToastBuilder(),
          title: 'Ember',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),

          routes: <String, WidgetBuilder>{
            Welcome.route: (BuildContext context) => const Welcome(),
            SignUp.route: (BuildContext context) => const SignUp(),
            Login.route: (BuildContext context) => const Login(),
            AddWidget.route: (BuildContext context) => const AddWidget(),
            AddFriends.route: (BuildContext context) => const AddFriends(),
            Home.route: (BuildContext context) => const Home(),
            Friends.route: (BuildContext context) => const Friends(),
            TimeCapsualLock.route: (BuildContext context) =>
                const TimeCapsualLock(),
            TimecapsualOpen.route: (BuildContext context) =>
                const TimecapsualOpen(),
            Profile.route: (BuildContext context) => const Profile(),
            EditUserDeets.route: (BuildContext context) =>
                const EditUserDeets(),
            MapHome.route: (BuildContext context) => const MapHome(),
            SearchMap.route: (BuildContext context) => const SearchMap(),
          },

          // initialRoute: TimecapsualOpen.route,
          // initialRoute: TimeCapsualLock.route,
          // initialRoute: Home.route,
          // initialRoute: Welcome.route,
          // initialRoute: Profile.route,
          // initialRoute: MapHome.route,
          initialRoute: Welcome.route,
        ),
      ),
    );
  }
}
