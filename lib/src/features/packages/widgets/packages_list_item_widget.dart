import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/package_model.dart';

class PackagesListItemWidget {
  final Function(int, String) onHandleSelectStatus;
  final Function(PackageModel?) onHandleShowPackageDetail;

  PackagesListItemWidget(
    this.onHandleSelectStatus,
    this.onHandleShowPackageDetail,
  );

  List<TableRow> buildTableRows(
      BuildContext context, List<PackageModel> packages) {
    const BoxFit boxFit = BoxFit.scaleDown;
    List<TableRow> result = [];
    TableRow header = _buildTableHeader(
      context: context,
      boxFit: boxFit,
      headers: "ID,TIPO,DATA EVENTO,ORDEM,ASSEMBLEIA,STATUS",
    );

    result = packages
        .map(
          (item) => _buildTableRow(
            boxFit: boxFit,
            context: context,
            package: item,
          ),
        )
        .toList();

    result.insert(0, header);
    result.insert(
      1,
      _rowDivider(cols: 6, color: Theme.of(context).colorScheme.primary),
    );

    return result;
  }

  TableRow _rowDivider({
    required int cols,
    double height = 1,
    Color color = Colors.black,
  }) =>
      TableRow(
        children: [
          for (var i = 0; i < cols; i++)
            Container(
              height: height,
              color: color,
            )
        ],
      );

  TableRow _buildTableHeader({
    required BuildContext context,
    required BoxFit boxFit,
    required String headers,
    double fontSize = 16,
  }) {
    return TableRow(
      children: headers.split(',').map(
        (name) {
          return TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: FittedBox(
              fit: boxFit,
              child: Text(
                name,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  TableRow _buildTableRow({
    required BuildContext context,
    required PackageModel package,
    required BoxFit boxFit,
    double fontSize = 12,
  }) {
    return TableRow(
      key: ValueKey(package.pac_uuid),
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: boxFit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    package.pac_uuid!.substring(package.pac_uuid!.length - 6),
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.normal,
                        fontSize: fontSize,
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye_rounded),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      onHandleShowPackageDetail(package);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: boxFit,
              child: Text(
                package.tipo_pacote!.tip_pac_nome!,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize,
                    color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: boxFit,
              child: Text(
                DateFormat(
                  'dd/MM/yyyy HH:mm',
                  'pt_Br',
                ).format(
                  package.pac_dt_evento!.toLocal(),
                ),
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize,
                    color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: boxFit,
              child: Text(
                package.assembleia!.ordem!.ord_name!,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize,
                    color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: boxFit,
              child: Text(
                package.assembleia!.ass_nome!,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize,
                    color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: boxFit,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    //onHandleSelectStatus(index, package.id!);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Theme.of(context).colorScheme.secondary,
                  selectedColor: Colors.white,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: [
                    package.pac_status == 'approved',
                    package.pac_status == 'unapproved'
                  ],
                  children: getPossibleStatus(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getPossibleStatus() {
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
}
