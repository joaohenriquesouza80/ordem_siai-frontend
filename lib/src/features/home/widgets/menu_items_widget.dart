import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/home/controllers/home_page_controller.dart';
import 'package:ordem_siai/src/features/users/users_page.dart';

class MenuItemsWidget {
  const MenuItemsWidget();

  static List<SideMenuItem> getMenuItems({
    required BuildContext buildContext,
    required PageController pageController,
    required HomePageController controller,
  }) {
    return [
      SideMenuItem(
        priority: 0,
        title: 'Usuários',
        onTap: () {
          //controller.goToUsersPage(buildContext);
          pageController.jumpToPage(0);
        },
        icon: const Icon(Icons.supervisor_account),
        // badgeContent: const Text(
        //   '3',
        //   style: TextStyle(color: Colors.white),
        // ),
        // tooltipContent: "This is a tooltip for Dashboard item",
      ),
      SideMenuItem(
        priority: 1,
        title: 'Iniciação',
        onTap: () {
          pageController.jumpToPage(1);
        },
        icon: const Icon(Icons.token_rounded),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Documentos',
        onTap: () {
          pageController.jumpToPage(2);
        },
        icon: const Icon(Icons.file_copy_rounded),
        // trailing: Container(
        //   decoration: const BoxDecoration(
        //       color: Colors.amber,
        //       borderRadius: BorderRadius.all(Radius.circular(6))),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
        //     child: Text(
        //       'New',
        //       style: TextStyle(fontSize: 11, color: Colors.grey[800]),
        //     ),
        //   ),
        // ),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Tesouraria',
        onTap: () {
          pageController.jumpToPage(3);
        },
        icon: const Icon(Icons.attach_money_rounded),
      ),
      SideMenuItem(
        priority: 4,
        title: 'Eventos',
        onTap: () {
          pageController.jumpToPage(4);
        },
        icon: const Icon(Icons.event_rounded),
      ),
      SideMenuItem(
        priority: 5,
        title: 'Notícias',
        onTap: () {
          pageController.jumpToPage(5);
        },
        icon: const Icon(Icons.campaign_rounded),
      ),
      SideMenuItem(
        priority: 6,
        title: 'Sair',
        icon: const Icon(Icons.exit_to_app),
        onTap: () {
          controller.logout();
        },
      ),
    ];
  }

  static PageView getPagesItems({
    required PageController pageController,
  }) {
    return PageView(
      controller: pageController,
      children: [
        const UsersPage(),
        // Container(
        //   color: Colors.white,
        //   child: const Center(
        //     child: Text(
        //       'USUÁRIOS',
        //       style: TextStyle(fontSize: 35),
        //     ),
        //   ),
        // ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'INICIAÇÃO - Em Construção',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'DOCUMENTOS - Em Construção',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'TESOURARIA - Em Construção',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'EVENTOS - Em Construção',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'NOTÍCIAS - Em Construção',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
      ],
    );
  }
}
