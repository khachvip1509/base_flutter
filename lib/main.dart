import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/app_routers/screens.dart';
import 'package:untitled/ui/home_screen/app_bar/view/app_bar.dart';
import 'package:untitled/ui/home_screen/home_page/view/home_demo.dart';
import 'package:untitled/ui/home_screen/home_page/view/home_screen.dart';
import 'package:untitled/ui/login_screens/bloc/item_bloc.dart';
import 'package:untitled/utils/app_constants.dart';

import 'app_routers/AppRoutes.dart';
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: Home.home,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }

}
