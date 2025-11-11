import 'package:flutter/material.dart';
import 'package:untitled/ui/quiz_screen/view/quiz_screen.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/carousel_view_custom/normal_layout_card.dart';

import '../../../setting_screen/view/screen_screen.dart';
import '../../app_bar/view/app_bar.dart';
import 'introduce.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
    'Messages',
    Icon(Icons.widgets_outlined),
    Icon(Icons.widgets),
  ),
  ExampleDestination(
    'Profile',
    Icon(Icons.format_paint_outlined),
    Icon(Icons.format_paint),
  ),
  ExampleDestination(
    'Settings',
    Icon(Icons.settings_outlined),
    Icon(Icons.settings),
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: NavigationDrawerExample(),
    );
  }
}

class NavigationDrawerExample extends StatefulWidget {
  const NavigationDrawerExample({super.key});

  @override
  State<NavigationDrawerExample> createState() =>
      _NavigationDrawerExampleState();
}

class _NavigationDrawerExampleState extends State<NavigationDrawerExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int screenIndex = 0;
  late bool showNavigationDrawer;

  static List<Widget> get _pages => [
    SafeArea(
      bottom: false,
      top: false,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: AppNumbs.doublePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: [
                        // HeroLayoutCard(),
                        // const SizedBox(height: 20),
                        Introduce(),
                        // const SizedBox(height: 20),
                        // NormalLayoutCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    const Center(child: Text(AppStrings.loTrinh)),
    const QuizScreen(),
    const Center(child: Text(AppStrings.nangCap)),
    SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {
      // Khi vuốt thì bottom nav tự đổi index
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuLeading(),
        title: Text(AppStrings.appName, style: AppTextStyle.s23w500cWhite),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: TabBarView(controller: _tabController, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.blue6187E8,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.luyenTap,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: AppStrings.loTrinh,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: AppStrings.thi,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond),
            label: AppStrings.nangCap,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.caiDat,
          ),
        ],
      ),
      endDrawer: NavigationDrawer(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Header'),
          ),
          ...destinations.map((destination) {
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
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuLeading(),
        title: Text(AppStrings.appName, style: AppTextStyle.s23w500cWhite),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(
                Icons.person,
                size: AppNumbs.sizeAvt,
                color: Colors.white,
              ),
              tooltip: AppStrings.guess,
            ),
          ),
        ],
      ),
      body: TabBarView(controller: _tabController, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.blue6187E8,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.luyenTap,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: AppStrings.loTrinh,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: AppStrings.thi,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond),
            label: AppStrings.nangCap,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.caiDat,
          ),
        ],
      ),
      endDrawer: NavigationDrawer(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Header'),
          ),
          ...destinations.map((destination) {
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
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
    showNavigationDrawer =false;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }
}
