import 'package:feeds_app/src/constants/user_feed_key.dart';
import 'package:feeds_app/src/scenes/feeds_page/app/feeds_provider.dart';
import 'package:feeds_app/src/scenes/feeds_page/presentation/feeds_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
//initialize hive
  await Hive.initFlutter();
//open box
  var userFeeds = await Hive.openBox(UserFeedKey.userFeedKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FeedsProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Feeds',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const FeedsPage(),
      ),
    );
  }
}
