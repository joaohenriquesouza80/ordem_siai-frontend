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

    if (widget.package.pac_status == null ||
        widget.package.pac_status != 'approved') {
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
        widget.item.rel_pac_usu_presenca = true;
        break;
      case 1:
        widget.item.rel_pac_usu_presenca = false;
        break;
      default:
        widget.item.rel_pac_usu_presenca = null;
    }

    widget.item.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario = null;
    widget.item.rel_pac_usu_dt_presenca = null;
    if (authUser != null) {
      widget.item.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario =
          authUser;
      widget.item.rel_pac_usu_dt_presenca = DateTime.now();
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
              widget.item.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!
                          .usu_nome ==
                      null
                  ? '-'
                  : widget
                          .item
                          .usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!
                          .usu_nome ??
                      '-',
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: AppColors.myBlack,
              ),
            ),
            const Spacer(),
            Text(
              widget.item.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!
                          .assembleia ==
                      null
                  ? '-'
                  : "${widget.item.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!.assembleia?.ass_nome ?? ""} (Ordem: ${widget.item.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!.assembleia?.ordem?.ord_name ?? ""})",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: AppColors.myBlack,
              ),
            ),
            const Spacer(),
            Text(
              widget.item.usuario_rel_pacote_usuario_usu_id_usuario_fkTousuario!
                      .usu_email ??
                  '-',
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
                          widget.item.rel_pac_usu_presenca == true,
                          widget.item.rel_pac_usu_presenca == false,
                        ],
                        children: _getPossiblePresence(),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.item.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario !=
                            null
                        ? Text(
                            'Presença informada por: ${widget.item.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario!.usu_nome}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 8,
                                color: AppColors.myBlack),
                          )
                        : Container(),
                    widget.item.usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario !=
                            null
                        ? Text(
                            widget
                                    .item
                                    .usuario_rel_pacote_usuario_usu_id_presenca_fkTousuario!
                                    .usu_email ??
                                '-',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 8,
                                color: AppColors.myBlack),
                          )
                        : Container(),
                    widget.item.rel_pac_usu_dt_presenca != null
                        ? Text(
                            'Em: ${DateFormat(
                              'dd/MM/yyyy HH:mm:ss',
                              'pt_Br',
                            ).format(
                              widget.item.rel_pac_usu_dt_presenca!,
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
