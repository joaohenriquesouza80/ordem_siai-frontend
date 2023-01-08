// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ordem_siai/src/features/packages/models/package_model.dart';

import '../../core/app_colors.dart';
import '../../shared/utils/display_dialog.dart';
import '../../shared/widget/button/button_widget.dart';
import '../../shared/widget/simple_app_bar/simple_app_bar_widget.dart';
import '../users/models/users_models.dart';
import 'controllers/packages_controller.dart';
import 'widgets/detail_package_user_list_widget.dart';

class DetailPackagePage extends StatefulWidget {
  final PageController? pageController;

  const DetailPackagePage({
    super.key,
    required this.pageController,
  });

  @override
  State<DetailPackagePage> createState() => _DetailPackagePageState();
}

class _DetailPackagePageState extends State<DetailPackagePage> {
  late PackagesController _packagesController;

  final insertPackageFormKey = GlobalKey<FormState>();

  final TextEditingController _eventDateController = TextEditingController();

  PackageModel _packageDetail = PackageModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _packagesController = PackagesController(
        context,
        widget.pageController,
      );

      setState(() {
        _packageDetail = PackagesController.packageDetail;
      });
    });
  }

  _handleSelectStatus(int index) async {
    bool can = await _packagesController.canUpdatePackageStatus();
    if (!can) {
      await DisplayDialog.showDialogAsync(
        context,
        "Usuário sem permissão",
        "Usuário não possui permissão para alterar o Status do Pacote",
        FeatherIcons.alertTriangle,
      );
      return;
    }

    bool hasAny = _packageDetail.rel_pacote_usuario!
        .any((e) => e.rel_pac_usu_presenca != null);
    if (hasAny) {
      await DisplayDialog.showDialogAsync(
        context,
        "Mudança de status não permitida",
        "Já foi marcado presença para um ou mais usuários deste pacote",
        FeatherIcons.alertTriangle,
      );
      return;
    }

    UsersModel? authUser = await _packagesController.getAuthenticateUser();

    switch (index) {
      case 0:
        _packageDetail.pac_status = 'approved';
        break;
      case 1:
        _packageDetail.pac_status = 'unapproved';
        break;
      default:
        _packageDetail.pac_status = 'waiting';
    }

    _packageDetail.usuario_pacote_usu_id_aprovacao_fkTousuario = null;
    _packageDetail.pac_dt_aprovacao = null;
    if (authUser != null) {
      _packageDetail.usuario_pacote_usu_id_aprovacao_fkTousuario = authUser;
      _packageDetail.pac_dt_aprovacao = DateTime.now();
    }

    setState(() {});

    await _packagesController.updatePackageStatus(_packageDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SimpleAppBarWidget(
          title: 'Detalhe do Pacote',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //Event Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _setTitleWidget("Data do Evento:"),
                      _packageDetail.pac_dt_evento != null
                          ? Text(
                              DateFormat(
                                'dd/MM/yyyy HH:mm',
                                'pt_Br',
                              ).format(
                                _packageDetail.pac_dt_evento!,
                              ),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.myBlack),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                            _handleSelectStatus(index);
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
                            _packageDetail.pac_status == 'approved',
                            _packageDetail.pac_status == 'unapproved'
                          ],
                          children: _getPossibleStatus(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _packageDetail
                                  .usuario_pacote_usu_id_aprovacao_fkTousuario !=
                              null
                          ? Text(
                              _getStatusDescription(_packageDetail),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: AppColors.myBlack),
                            )
                          : Container(),
                      _packageDetail.pac_dt_aprovacao != null
                          ? Text(
                              'Em: ${DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                                'pt_Br',
                              ).format(
                                _packageDetail.pac_dt_aprovacao!,
                              )}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: AppColors.myBlack),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _setTitleWidget("Ordem:"),
                      _packageDetail.assembleia?.ordem != null
                          ? Text(
                              _packageDetail.assembleia!.ordem!.ord_name!,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.myBlack),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _setTitleWidget("Assembleia:"),
                      _packageDetail.assembleia != null
                          ? Text(
                              _packageDetail.assembleia!.ass_nome!,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.myBlack),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _setTitleWidget("Criado por:"),
                  _packageDetail.usuario_pacote_usu_id_criacao_fkTousuario !=
                          null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_packageDetail.usuario_pacote_usu_id_criacao_fkTousuario!.usu_nome} (${_packageDetail.usuario_pacote_usu_id_criacao_fkTousuario!.usu_email})",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.myBlack),
                            ),
                            Text(
                              'Em: ${DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                                'pt_Br',
                              ).format(
                                _packageDetail.pac_dt_criacao!,
                              )}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.myBlack),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 30),
// Presence users of Assemblage
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _setTitleWidget('Presenças dos Usuários'),
                  SizedBox(
                    //width: 500,
                    child: _packageDetail.rel_pacote_usuario != null
                        ? Wrap(
                            children: _packageDetail.rel_pacote_usuario!
                                .map(
                                  (e) => DetailPackageUserListWidget(
                                    item: e,
                                    package: _packageDetail,
                                    packagesController: _packagesController,
                                  ),
                                )
                                .toList(),
                          )
                        : Container(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 30,
                width: 150,
                child: ButtonWidget.needColor(
                  context: context,
                  label: 'Voltar',
                  onTap: () {
                    _packagesController.handleCancelNewPackage();
                  },
                  backgroundColor: Colors.white,
                  fontColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 20),
              /*SizedBox(
                height: 30,
                width: 150,
                child: ButtonWidget.needColor(
                  backgroundColor: Colors.red,
                  context: context,
                  label: 'Excluir Pacote',
                  fontColor: Colors.white,
                  onTap: () => {},
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  _setTitleWidget(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }

  List<Widget> _getPossibleStatus() {
    return <Widget>[
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Aprovado'),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Reprovado'),
      ),
    ];
  }

  String _getStatusDescription(PackageModel package) {
    if (package.usuario_pacote_usu_id_aprovacao_fkTousuario != null) {
      if (package.pac_status == 'approved') {
        return 'Aprovado por: ${package.usuario_pacote_usu_id_aprovacao_fkTousuario!.usu_nome} (${package.usuario_pacote_usu_id_aprovacao_fkTousuario!.usu_email})';
      }
      if (package.pac_status == 'unapproved') {
        return 'Reprovado por: ${package.usuario_pacote_usu_id_aprovacao_fkTousuario!.usu_nome} (${package.usuario_pacote_usu_id_aprovacao_fkTousuario!.usu_email})';
      }
    }
    return '';
  }
}
