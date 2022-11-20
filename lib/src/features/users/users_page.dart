import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/users/controllers/users_controller.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../shared/widget/progress_indicator/progress_indicator_widget.dart';
import '../../shared/widget/text_message/text_message_widget.dart';
import 'providers/users_provider.dart';
import 'widgets/users_list_widget.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController usersController = UsersController(context);
    return Scaffold(
      body: FutureBuilder(
        future: usersController.loadUsers(context),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: ProgressIndicatorWidget.primary(
              context: context,
            ));
          } else if (snapshot.error != null) {
            print(snapshot.error);
            return ListView(
              children: [
                Center(
                  child: TextMessageWidget(
                    message: 'Erro ao carregar Usuários\nTente novamente.',
                    color: AppColors.darkRed,
                  ),
                )
              ],
            );
          } else {
            return Consumer<UsersProvider>(
              builder: (ctx, provider, child) {
                return UsersListWidget(
                  users: provider.users,
                );
              },
            );
          }
        },
      ),
    );
  }
}