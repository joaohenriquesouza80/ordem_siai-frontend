import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ordem_siai/src/features/home/widgets/menu_footer_widget.dart';
import 'package:ordem_siai/src/features/home/widgets/menu_items_widget.dart';

import 'controllers/home_page_controller.dart';
import 'widgets/menu_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(keepPage: false);
  late final HomePageController homePageController2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homePageController2 = HomePageController(context);

      setState(() {
        _init();
      });
    });
  }

  _init() async {
    await homePageController2.loadProfile(true);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    final homePageController = HomePageController(context);
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text("widget.title"),
      //  centerTitle: true,
      //),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: pageController,
            style: SideMenuStyle(
              showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Theme.of(context).colorScheme.tertiary,
              selectedColor: Theme.of(context).colorScheme.primary,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              //decoration: BoxDecoration(
              //  borderRadius: BorderRadius.all(Radius.circular(10)),
              //),
              //backgroundColor: Colors.blueGrey[700],
            ),
            title: MenuHeaderWidget(
              controller: homePageController,
            ),
            items: MenuItemsWidget.getMenuItems(
              buildContext: context,
              pageController: pageController,
              controller: homePageController,
            ),
            footer: MenuFooterWidget(
              controller: homePageController,
            ),
          ),
          Expanded(
            child: MenuItemsWidget.getPagesItems(
              pageController: pageController,
            ),
          ),
        ],
      ),
    );
  }
}
