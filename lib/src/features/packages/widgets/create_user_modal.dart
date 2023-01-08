import 'package:flutter/material.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ordem_siai/src/features/assemblages/models/assemblage_mode.dart';

import '../../../shared/widget/button/button_widget.dart';
import '../../users/models/insert_user_and_profile_model.dart';

class CreateUserModal extends StatefulWidget {
  final Function(InsertUseAndProfileModel user) handleInsertNewUser;
  final AssemblageModel assemblage;

  const CreateUserModal({
    super.key,
    required this.handleInsertNewUser,
    required this.assemblage,
  });

  @override
  State<CreateUserModal> createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  final _formInsertUserKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  _insertUser() {
    if (!_formInsertUserKey.currentState!.validate()) return;

    InsertUseAndProfileModel user = InsertUseAndProfileModel(
      email: _emailController.text,
      name: _nameController.text,
      assemblage_id: widget.assemblage.ass_uuid!,
      password: _emailController.text.split('@')[0],
    );

    widget.handleInsertNewUser(user);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Form(
          key: _formInsertUserKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              _createTitles(
                "Criar novo Usuário",
                24,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (Validator.email(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email do novo Usuário",
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nome do novo Usuário",
                ),
              ),
              const SizedBox(height: 50),
              ButtonWidget.secondary(
                context: context,
                label: "Criar Usuário",
                onTap: () => {
                  _insertUser(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _createTitles(String title, double size) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: Theme.of(context).colorScheme.tertiary),
    );
  }
}
