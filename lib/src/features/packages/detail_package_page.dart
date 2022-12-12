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
  final PageController pageController;

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

    bool hasAny =
        _packageDetail.package_users!.any((e) => e.is_presence != null);
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
    setState(
      () {
        switch (index) {
          case 0:
            _packageDetail.status = 'approved';
            break;
          case 1:
            _packageDetail.status = 'unapproved';
            break;
          default:
            _packageDetail.status = 'waiting';
        }

        _packageDetail.approve_user = null;
        _packageDetail.approve_date = null;
        if (authUser != null) {
          _packageDetail.approve_user = authUser;
          _packageDetail.approve_date = DateTime.now();
        }
      },
    );
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
                      _packageDetail.event_date_time != null
                          ? Text(
                              DateFormat(
                                'dd/MM/yyyy HH:mm',
                                'pt_Br',
                              ).format(
                                _packageDetail.event_date_time!,
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
                            _packageDetail.status == 'approved',
                            _packageDetail.status == 'unapproved'
                          ],
                          children: _getPossibleStatus(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _packageDetail.approve_user != null
                          ? Text(
                              _getStatusDescription(_packageDetail),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: AppColors.myBlack),
                            )
                          : Container(),
                      _packageDetail.approve_date != null
                          ? Text(
                              'Em: ${DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                                'pt_Br',
                              ).format(
                                _packageDetail.approve_date!,
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
                      _packageDetail.assemblage?.order != null
                          ? Text(
                              _packageDetail.assemblage!.order!.name!,
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
                      _packageDetail.assemblage != null
                          ? Text(
                              _packageDetail.assemblage!.name!,
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
                  _packageDetail.creator_user != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_packageDetail.creator_user!.UserProfile!.name!} (${_packageDetail.creator_user!.email!})",
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
                                _packageDetail.created_at!,
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
                    child: _packageDetail.package_users != null
                        ? Wrap(
                            children: _packageDetail.package_users!
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
              SizedBox(
                height: 30,
                width: 150,
                child: ButtonWidget.needColor(
                  backgroundColor: Colors.red,
                  context: context,
                  label: 'Excluir Pacote',
                  fontColor: Colors.white,
                  onTap: () => {},
                ),
              )
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
    if (package.status == 'approved') {
      return 'Aprovado por: ${package.approve_user!.UserProfile!.name!} (${package.approve_user!.email!})';
    }
    if (package.status == 'unapproved') {
      return 'Reprovado por: ${package.approve_user!.UserProfile!.name!} (${package.approve_user!.email!})';
    }
    return '';
  }
}
