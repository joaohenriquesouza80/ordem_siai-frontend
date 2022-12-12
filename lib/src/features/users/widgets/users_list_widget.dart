import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/users/widgets/users_list_item_widget.dart';

import '../models/users_models.dart';

class UsersListWidget extends StatefulWidget {
  final List<UsersModel> users;

  const UsersListWidget({
    super.key,
    required this.users,
  });

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return UsersListItemWidget(
            user: widget.users[index],
          );
        },
      ),
    );
  }
}
