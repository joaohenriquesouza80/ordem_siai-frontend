import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../models/insert_package_selected_email_model.dart';

class InsertPackageUserListWidget extends StatefulWidget {
  final InsertPackageSelectedEmailModel item;

  const InsertPackageUserListWidget({
    super.key,
    required this.item,
  });

  @override
  State<InsertPackageUserListWidget> createState() =>
      _InsertPackageUserListWidgetState();
}

class _InsertPackageUserListWidgetState
    extends State<InsertPackageUserListWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.item.usu_nome == null ? '-' : widget.item.usu_nome!,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: AppColors.myBlack,
            ),
          ),
          const Spacer(),
          Text(
            widget.item.assembleia == null
                ? '-'
                : "${widget.item.assembleia?.ass_nome ?? ""} (Ordem: ${widget.item.assembleia?.ordem?.ord_name ?? ""})",
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: AppColors.myBlack,
            ),
          ),
          const Spacer(),
          Text(
            widget.item.usu_email!,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: AppColors.myBlack,
            ),
          ),
        ],
      ),
      value: widget.item.checked,
      checkColor: Theme.of(context).colorScheme.primary,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: (value) {
        setState(
          () {
            widget.item.checked = value ?? false;
          },
        );
      },
    );
  }
}
