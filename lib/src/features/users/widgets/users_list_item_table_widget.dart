import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widget/image_box/image_box_cached_widget.dart';
import '../models/users_models.dart';

class UsersListItemTableWidget {
  static TableRow buildTableRow({
    required BuildContext context,
    required UsersModel user,
  }) {
    //return Text(user.toJson());
    return TableRow(
      key: ValueKey(user.usu_uuid),
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ImageBoxCachedWidget(
                imageUrl: user.usu_foto,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  user.usu_nome ?? 'Não Informado',
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${user.usu_email}',
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
            ],
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  user.assembleia?.ordem?.ord_name ?? 'Não Informado',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  user.assembleia?.ass_nome ?? ' ',
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              ),
            ],
          ),
        ),
        // FittedBox(
        //   fit: BoxFit.fitWidth,
        //   child: Text(
        //     'Cargo',
        //     style: GoogleFonts.notoSans(
        //       fontWeight: FontWeight.normal,
        //       fontSize: 14,
        //       color: Theme.of(context).textTheme.bodyMedium!.color,
        //     ),
        //   ),
        // ),
        // FittedBox(
        //   fit: BoxFit.fitWidth,
        //   child: Text(
        //     'Iniciacao',
        //     style: GoogleFonts.notoSans(
        //       fontWeight: FontWeight.normal,
        //       fontSize: 14,
        //       color: Theme.of(context).textTheme.bodyMedium!.color,
        //     ),
        //   ),
        // ),
        // FittedBox(
        //   fit: BoxFit.fitWidth,
        //   child: Text(
        //     'Status',
        //     style: GoogleFonts.notoSans(
        //       fontWeight: FontWeight.normal,
        //       fontSize: 14,
        //       color: Theme.of(context).textTheme.bodyMedium!.color,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
