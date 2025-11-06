import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/ui/login_screens/bloc/item_bloc.dart';
import 'package:untitled/ui/login_screens/view/home/home_screen.dart';
import 'package:untitled/utils/app_constants.dart';

import 'data/model/item_model.g.dart';
import 'di/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  await di.init();
  runApp(
    BlocProvider(
      create: (_) => ItemBloc()..add(LoadRemoteItemsEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.appName, style: AppTextStyle.s23w500cWhite),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Information person")),
                  );
                },
                icon: const Icon(Icons.person, size: AppNumbs.sizeAvt),
                tooltip: "Guess",
              ),
            ],
          ),
          body: HomeScreen(),
        ),
      ),
    );
  }
}
