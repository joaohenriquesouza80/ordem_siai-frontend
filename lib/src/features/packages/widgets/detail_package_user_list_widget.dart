// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ordem_siai/src/features/packages/controllers/packages_controller.dart';
import 'package:ordem_siai/src/features/packages/models/package_model.dart';

import '../../../core/app_colors.dart';
import '../../../shared/utils/display_dialog.dart';
import '../../users/models/users_models.dart';
import '../models/package_users_model.dart';

class DetailPackageUserListWidget extends StatefulWidget {
  final PackagesController packagesController;
  final PackageModel package;
  final PackageUsersModel item;

  const DetailPackageUserListWidget({
    super.key,
    required this.item,
    required this.packagesController,
    required this.package,
  });

  @override
  State<DetailPackageUserListWidget> createState() =>
      _DetailPackageUserListWidgetState();
}

class _DetailPackageUserListWidgetState
    extends State<DetailPackageUserListWidget> {
  _handleSelectPresence(int index) async {
    bool can = await widget.packagesController.canUpdateUserPresenceStatus();
    if (!can) {
      await DisplayDialog.showDialogAsync(
        context,
        "Usuário sem permissão",
        "Usuário não possui permissão para marcar presença do usuário",
        FeatherIcons.alertTriangle,
      );
      return;
    }

    if (widget.package.status == null || widget.package.status != 'approved') {
      await DisplayDialog.showDialogAsync(
        context,
        "Pacote não esta aprovado",
        "Somente pacotes aprovados podem ter presença marcadas",
        FeatherIcons.alertTriangle,
      );
      return;
    }

    UsersModel? authUser =
        await widget.packagesController.getAuthenticateUser();

    switch (index) {
      case 0:
        widget.item.is_presence = true;
        break;
      case 1:
        widget.item.is_presence = false;
        break;
      default:
        widget.item.is_presence = null;
    }

    widget.item.presence_user = null;
    widget.item.presence_date = null;
    if (authUser != null) {
      widget.item.presence_user = authUser;
      widget.item.presence_date = DateTime.now();
    }

    setState(() {});

    await widget.packagesController
        .updatePackageUserPresenceStatus(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.item.user!.UserProfile == null
                  ? '-'
                  : widget.item.user!.UserProfile!.name ?? '-',
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: AppColors.myBlack,
              ),
            ),
            const Spacer(),
            Text(
              widget.item.user!.UserProfile == null
                  ? '-'
                  : "${widget.item.user!.UserProfile?.assemblage?.name ?? ""} (Ordem: ${widget.item.user!.UserProfile?.order?.name ?? ""})",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: AppColors.myBlack,
              ),
            ),
            const Spacer(),
            Text(
              widget.item.user!.email!,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: AppColors.myBlack,
              ),
            ),
            const SizedBox(width: 50),
            Column(
              children: [
                Container(
                  height: 80,
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          _handleSelectPresence(index);
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor:
                            Theme.of(context).colorScheme.secondary,
                        selectedColor: Colors.white,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        color: Colors.black,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: [
                          widget.item.is_presence == true,
                          widget.item.is_presence == false,
                        ],
                        children: _getPossiblePresence(),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.item.presence_user != null
                        ? Text(
                            'Presença informada por: ${widget.item.presence_user!.UserProfile!.name!}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 8,
                                color: AppColors.myBlack),
                          )
                        : Container(),
                    widget.item.presence_user != null
                        ? Text(
                            widget.item.presence_user!.email!,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 8,
                                color: AppColors.myBlack),
                          )
                        : Container(),
                    widget.item.presence_date != null
                        ? Text(
                            'Em: ${DateFormat(
                              'dd/MM/yyyy HH:mm:ss',
                              'pt_Br',
                            ).format(
                              widget.item.presence_date!,
                            )}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 9,
                                color: AppColors.myBlack),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPossiblePresence() {
    return <Widget>[
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Compareceu'),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Não Compareceu'),
      ),
    ];
  }
}
