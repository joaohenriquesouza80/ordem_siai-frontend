import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/users/models/users_models.dart';
import 'package:ordem_siai/src/features/users/widgets/users_list_item_widget.dart';

class UsersListWidget extends StatelessWidget {
  final List<UsersModel> users;

  const UsersListWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      // border: TableBorder(
      //     bottom: BorderSide(color: Colors.red, width: 2),
      //     horizontalInside: BorderSide(color: Colors.red, width: 2),
      // ),
      // border: TableBorder.all(color: Colors.red, width: 2),
      // border: TableBorder.symmetric(
      //   inside: const BorderSide(color: Colors.blue, width: 2),
      //   outside: const BorderSide(color: Colors.red, width: 5),
      // ),
      defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
      defaultColumnWidth: const IntrinsicColumnWidth(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(100),
        1: FlexColumnWidth(3),
        2: MaxColumnWidth(FlexColumnWidth(2), FractionColumnWidth(0.3)),
        //   3: FixedColumnWidth(150),
      },
      // textDirection: TextDirection.rtl,
      textBaseline: TextBaseline
          .alphabetic, // Pass this argument when using [TableCellVerticalAlignment.fill]
      children: users
          .map(
            (item) => UsersListItemWidget.buildTableRow(
              context: context,
              user: item,
            ),
          )
          .toList(),
    );
  }
}
