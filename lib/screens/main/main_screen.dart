import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'chat/home_chat_screen.dart';
import 'learning/learing_screen.dart';
import 'notification/notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'search/tab_view_search.dart';
import 'home/home_tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  SwiperController swiperController;
  TabController tabControllerHome;
  TabController tabControllerRank;
  TabController tabControllerSearch;
  TabController bottomTabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabControllerHome = TabController(length: 3, vsync: this);
    tabControllerSearch = TabController(length: 1, vsync: this);
    tabControllerRank = TabController(length: 2, vsync: this);
    bottomTabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = TabBar(
      isScrollable: true,
      indicatorColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      tabs: <Widget>[
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("Home"),
            ),
          ),
        ),
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("Hot"),
            ),
          ),
        ),
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("Explore"),
            ),
          ),
        ),
      ],
      controller: tabControllerHome,
    );
    Widget tabBarSearch = TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      tabs: <Widget>[
        Tab(
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text("EXample"),
            ),
          ),
        ),
      ],
      controller: tabControllerSearch,
    );
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    List<Widget> _widgetOptions = <Widget>[
      DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(-20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 32,
                  child: tabBar,
                ),
              ),
            ),
          ),
          body: HomeTabView(
            tabController: tabControllerHome,
          ),
        ),
      ),
      // ExamplePage(),
      DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(-20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 32,
                  child: tabBarSearch,
                ),
              ),
            ),
          ),
          body: TabSearchView(
            tabController: tabControllerSearch,
          ),
        ),
      ),
      LearingPage(tabController: tabControllerRank),
      ChatHomeScreen(),
      NotificationsSreen(),
      ProfilePage()
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            title: Text('Grammar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text('Game'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Message'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('menu'),
          ),
        ],
        iconSize: 28,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
