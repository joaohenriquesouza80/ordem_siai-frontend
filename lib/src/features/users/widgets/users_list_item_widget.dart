import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widget/image_box/image_box_cached_widget.dart';
import '../models/users_models.dart';

class UsersListItemWidget extends StatefulWidget {
  final UsersModel user;

  const UsersListItemWidget({
    super.key,
    required this.user,
  });

  @override
  State<UsersListItemWidget> createState() => _UsersListItemWidgetState();
}

class _UsersListItemWidgetState extends State<UsersListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ImageBoxCachedWidget(
                    imageUrl: widget.user.usu_foto,
                    dynamicStringToAvatar: widget.user.usu_uuid,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.user.usu_nome ?? 'Não Informado',
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '${widget.user.usu_email}',
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.user.assembleia?.ordem?.ord_name ??
                          'Não Informado',
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
                      widget.user.assembleia?.ass_nome ?? ' ',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
