import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:website/about_view.dart';
import 'package:website/content_view.dart';
import 'package:website/custom_tab.dart';
import 'package:website/home_view.dart';
import 'package:website/projects_view.dart';

import 'bottom_bar.dart';
import 'custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController tabController;
  late double screenHeight;
  late double screenWidth;
  late double topPadding;
  late double bottomPadding;

  List<ContentView> contentViews = [
    ContentView(
        tab: CustomTab(title: 'Home'),
        content: HomeView()),
    ContentView(
        tab: CustomTab(title: 'About'),
        content: AboutView()),
    ContentView(
        tab: CustomTab(title: 'Projects'),
        content: ProjectsView()),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.01;
    return Scaffold(
      backgroundColor: Color(0xff1e1e24),
      endDrawer: drawer(),
      key: scaffoldKey,
      body: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 715) {
              return desktopView();
            } else {
              return mobileView();
            }
          },
        ),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTabBar(
          controller: tabController,
          tabs: contentViews.map((e) => e.tab).toList(),
        ),
        Container(
            height: screenHeight * 0.8,
            child: TabBarView(
              controller: tabController,
              children: contentViews.map((e) => e.content).toList(),
              physics: NeverScrollableScrollPhysics(),
            )),
        BottomBar()
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
      child: Container(
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                iconSize: screenWidth * 0.08,
                icon: Icon(Icons.menu_rounded),
                onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                color: Colors.white,
              ),
              Expanded(child: ListView.builder(
                  itemCount: contentViews.length,
                  itemBuilder: (context, index) => contentViews[index].content))
            ],
          )),
    );
  }

  Widget drawer() {
    return Drawer(
        child: ListView(
      children: [
            Container(
              height: screenHeight * 0.1,
            )
          ] +
          contentViews
              .map((e) => Container(
                    child: ListTile(
                      title: Text(e.tab.title),
                      onTap: () {},
                    ),
                  ))
              .toList(),
    ));
  }
}
