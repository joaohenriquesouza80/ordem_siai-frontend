// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ordem_siai/src/features/assemblages/models/assemblage_mode.dart';
import 'package:ordem_siai/src/features/packages/models/package_type_model.dart';
import 'package:ordem_siai/src/shared/widget/button/button_widget.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../shared/utils/display_dialog.dart';
import '../../shared/widget/simple_app_bar/simple_app_bar_widget.dart';
import '../assemblages/providers/assemblages_provider.dart';
import '../users/providers/users_provider.dart';
import 'controllers/packages_controller.dart';
import 'models/insert_package_selected_email_model.dart';
import 'providers/packages_types_provider.dart';
import 'widgets/create_user_modal.dart';
import 'widgets/insert_package_user_list_widget.dart';

class InsertPackagePage extends StatefulWidget {
  final PageController pageController;

  const InsertPackagePage({
    super.key,
    required this.pageController,
  });

  @override
  State<InsertPackagePage> createState() => _InsertPackagePageState();
}

class _InsertPackagePageState extends State<InsertPackagePage> {
  late PackagesController _packagesController;

  final insertPackageFormKey = GlobalKey<FormState>();

  final TextEditingController _eventDateController = TextEditingController();

  DateTime selectedEventDate = DateTime.now().add(const Duration(days: 1));
  AssemblageModel? selectedAssemblage;
  PackageTypeModel? selectedPackageType;
  List<InsertPackageSelectedEmailModel> checkedUsers = [];

  _setEventDate(DateTime eventDate) {
    setState(() {
      selectedEventDate = eventDate;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _packagesController = PackagesController(
        context,
        widget.pageController,
      );

      _packagesController.loadAllAssemblages();
      _packagesController.loadAllPackagesTypes();
    });
  }

  _insertPackage() {
    if (!insertPackageFormKey.currentState!.validate()) return;

    if (selectedEventDate.isBefore(DateTime.now())) {
      DisplayDialog.showDialogAsync(
        context,
        "Erro na Inclusão do Pacote",
        "Data do evento deve ser maior que a data atual",
        FeatherIcons.alertTriangle,
      );
      return;
    }

    List<InsertPackageSelectedEmailModel> onlyCheckedUsers =
        checkedUsers.where((e) => e.checked == true).toList();
    if (onlyCheckedUsers.isEmpty) {
      DisplayDialog.showDialogAsync(
        context,
        "Erro na Inclusão do Pacote",
        "Selecione pelo menos um Usuário para o Pacote",
        FeatherIcons.alertTriangle,
      );
      return;
    }

    _packagesController.handleInsertPackage(
      eventDateTime: selectedEventDate,
      assemblage: selectedAssemblage ?? AssemblageModel(),
      packageType: selectedPackageType ?? PackageTypeModel(),
      checkedUsers: onlyCheckedUsers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SimpleAppBarWidget(
          title: 'Inserir Pacote',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Form(
            key: insertPackageFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _setTitleWidget('Data do Evento'),
                    Row(
                      children: [
                        Text(
                          DateFormat(
                            'dd/MM/yyyy HH:mm',
                            'pt_Br',
                          ).format(
                            selectedEventDate,
                          ),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: AppColors.myBlack),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_month_rounded,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime.now().add(
                                const Duration(days: -1),
                              ),
                              maxTime: DateTime.now().add(
                                const Duration(days: 365 * 5),
                              ),
                              onConfirm: (date) {
                                _setEventDate(date);
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.pt,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Assemblage
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _setTitleWidget('Assembléia'),
                    SizedBox(
                      //width: 200,

                      child: DropdownButtonHideUnderline(
                        child: Consumer<AssemblagesProvider>(
                          builder: (ctx, provider, child) {
                            return DropdownButtonFormField<AssemblageModel>(
                              value: selectedAssemblage,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 20,
                              elevation: 16,
                              alignment: AlignmentDirectional.bottomStart,
                              style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedAssemblage = newValue;
                                  });
                                }
                              },
                              validator: (value) {
                                if (Validator.required(value)) {
                                  return 'Por favor, selecione uma assembleia';
                                }
                                return null;
                              },
                              items: provider.assemblages.map(
                                (assemblage) {
                                  String assemblageOrder =
                                      "${assemblage.name} (Ordem: ${assemblage.order!.name!})";
                                  return DropdownMenuItem<AssemblageModel>(
                                    key: Key(assemblage.id!),
                                    value: assemblage,
                                    child: Text(
                                      assemblageOrder,
                                      style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: AppColors.myBlack,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Package Type
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _setTitleWidget('Tipo do Pacote'),
                    SizedBox(
                      width: 200,
                      child: DropdownButtonHideUnderline(
                        child: Consumer<PackagesTypesProvider>(
                          builder: (ctx, provider, child) {
                            return DropdownButtonFormField<PackageTypeModel>(
                              value: selectedPackageType,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 20,
                              elevation: 16,
                              alignment: AlignmentDirectional.bottomStart,
                              style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedPackageType = newValue;
                                  });
                                }
                              },
                              validator: (value) {
                                if (Validator.required(value)) {
                                  return 'Por favor, selecione um tipo de pacote';
                                }
                                return null;
                              },
                              items: provider.packagesTypes.map(
                                (packageType) {
                                  return DropdownMenuItem<PackageTypeModel>(
                                    key: Key(packageType.id!),
                                    value: packageType,
                                    child: Text(
                                      packageType.package_name!,
                                      style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: AppColors.myBlack,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Select users of Assemblage
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _setTitleWidget('Usuários do Pacote'),
                    Consumer<UsersProvider>(
                      builder: (ctx, provider, child) {
                        checkedUsers = provider.users.map((e) {
                          var userChecked =
                              InsertPackageSelectedEmailModel(false);
                          userChecked.id = e.id;
                          userChecked.email = e.email;
                          userChecked.UserProfile = e.UserProfile;

                          return userChecked;
                        }).toList();
                        checkedUsers.sort((a, b) => a.UserProfile!.name!
                            .compareTo(b.UserProfile!.name!));

                        return SizedBox(
                          //width: 500,
                          child: Wrap(
                              children: checkedUsers
                                  .map(
                                    (e) => InsertPackageUserListWidget(
                                      item: e,
                                    ),
                                  )
                                  .toList()),
                        );
                      },
                    ),
                    SizedBox(
                      width: 500,
                      child: ButtonWidget.secondary(
                        context: context,
                        label: "Criar Novo Usuário",
                        onTap: selectedAssemblage == null
                            ? () {
                                DisplayDialog.showDialogAsync(
                                  context,
                                  "Inclusão de Usuário não permitida",
                                  "Necessário informar uma Assembleia primeiro",
                                  FeatherIcons.alertCircle,
                                );
                              }
                            : () => {
                                  showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => CreateUserModal(
                                      handleInsertNewUser: _packagesController
                                          .handleInsertNewUser,
                                      assemblage: selectedAssemblage!,
                                    ),
                                  )
                                },
                      ),
                    )
                  ],
                )
              ],
            ),
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
                child: ButtonWidget.redWithoutBords(
                  context: context,
                  label: 'Cancelar',
                  onTap: () {
                    _packagesController.handleCancelNewPackage();
                  },
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 30,
                width: 150,
                child: ButtonWidget.primary(
                  context: context,
                  label: 'Salvar Pacote',
                  onTap: () => {_insertPackage()},
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
          color: Theme.of(context).colorScheme.tertiary),
    );
  }
}
