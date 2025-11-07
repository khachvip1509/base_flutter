import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/carousel_view_custom/hero_layout_card.dart';
import 'package:untitled/utils/carousel_view_custom/normal_layout_card.dart';
import 'package:untitled/utils/carousel_view_custom/uncontained_layout_card.dart';

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
                  SizedBox(
                    height: AppNumbs.sizePageView,
                    child: ListView(
                      children: [
                        HeroLayoutCard(),
                        const SizedBox(height: 20),
                        NormalLayoutCard(),
                      ],
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: openDrawer,
                  //   child: const Text('Open Drawer'),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    const Center(child: Text("Học chữ")),
    const Center(child: Text("Cài đặt")),
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
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Learn"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),

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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Learn"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
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
