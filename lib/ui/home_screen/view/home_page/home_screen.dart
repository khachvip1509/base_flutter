import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/carousel_view_custom/hero_layout_card.dart';
import 'package:untitled/utils/carousel_view_custom/normal_layout_card.dart';

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
      debugShowCheckedModeBanner: false,
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
                        HeroLayoutCard(),
                        const SizedBox(height: 20),
                        Introduce(),
                        const SizedBox(height: 20),
                        NormalLayoutCard(),
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
    const Center(child: Text(AppStrings.thi)),
    const Center(child: Text(AppStrings.nangCap)),
    const Center(child: Text(AppStrings.caiDat)),
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
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
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
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }
}
