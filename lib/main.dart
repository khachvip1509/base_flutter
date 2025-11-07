import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/ui/home_screen/view/app_bar/app_bar.dart';
import 'package:untitled/ui/home_screen/view/home_page/home_screen.dart';
import 'package:untitled/ui/login_screens/bloc/item_bloc.dart';
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> items = ['Trang chủ', 'Học chữ', 'Cài đặt'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: const MenuLeading(),
            centerTitle: true,
            title: Text(AppStrings.appName, style: AppTextStyle.s23w500cWhite),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                onPressed: openDrawer,
                icon: const Icon(Icons.person, size: AppNumbs.sizeAvt, color: Colors.white),
                tooltip: "Guess",
              ),
            ],
          ),
          body: HomeScreen(),
          endDrawer: NavigationDrawer(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(
                  'Header',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ...destinations.map((ExampleDestination destination) {
                return NavigationDrawerDestination(
                  label: Text(destination.label),
                  icon: destination.icon,
                  selectedIcon: destination.selectedIcon,
                );
              }),
              const Padding(
                padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
