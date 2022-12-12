import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';
import '../button/button_widget.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime)? onDateChanged;
  final bool useDatePicker;

  const DatePickerWidget({
    super.key,
    this.selectedDate,
    this.onDateChanged,
    this.useDatePicker = true,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: 365 * 50 * -1)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      fieldHintText: 'dd/mm/aaaa',
      locale: const Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged!(pickedDate);
    });
  }

  Widget _showDatePicker2() {
    final List<TextInputFormatter> listFormatter = [];
    listFormatter.add(DataInputFormatter());

    return DateTimePicker(
      type: DateTimePickerType.date,
      dateMask: "dd 'de' MMMM 'de' yyyy",
      locale: const Locale('pt', 'BR'),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      firstDate: DateTime.now().add(const Duration(days: 365 * 50 * -1)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      //icon: Icon(Icons.event),
      dateLabelText: 'Data',
      timeLabelText: "Hora",
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      style: GoogleFonts.robotoSlab(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: Colors.transparent,
      ),
      onChanged: (val) {
        onDateChanged!(DateUtils.dateOnly(DateTime.parse(val)));
      },
      inputFormatters: listFormatter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd 'de' MMMM 'de' yyyy", 'pt-BR');

    return SizedBox(
      //margin: EdgeInsets.symmetric(horizontal: 10),
      //height: 60,
      width: MediaQuery.of(context).size.width,
      child: useDatePicker
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Não informado'
                      : DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                          .format(selectedDate!),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: AppColors.myBlack),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: ButtonWidget.primary(
                    label: 'Selecionar Data',
                    icon: FeatherIcons.calendar,
                    onTap: () {
                      _showDatePicker(context);
                    },
                    context: context,
                  ),
                )
              ],
            )
          : Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [8, 4],
                color: AppColors.primary,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        selectedDate != null
                            ? formatter.format(selectedDate!)
                            : 'Clique aqui para informar uma data',
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.tertiary,
                        ),
                      ),
                    ),
                    _showDatePicker2(),
                  ],
                ),
              ),
            ),
    );
  }
}
