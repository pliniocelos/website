import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:website/content_view.dart';
import 'package:website/custom_tab.dart';

import 'custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<ContentView> contentViews = [
    ContentView(
        tab: CustomTab(title: 'Home'),
        content: Center(
          child: Container(
            color: Colors.green,
            width: 100,
            height: 100,
          ),
        )),
    ContentView(
        tab: CustomTab(title: 'About'),
        content: Center(
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
        )),
    ContentView(
        tab: CustomTab(title: 'Projects'),
        content: Center(
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
        )),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e1e24),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 715) {
            return desktopView();
          } else {
            return mobileView();
          }
        },
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
            height: 400,
            child: TabBarView(
              controller: tabController,
              children: contentViews.map((e) => e.content).toList(),
            )
        )
      ],
    );
  }

  Widget mobileView() {
    return Container();
  }
}
