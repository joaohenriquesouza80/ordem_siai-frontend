import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/packages/controllers/packages_controller.dart';

import '../models/package_model.dart';
import 'packages_list_item_widget.dart';

class PackagesListWidget extends StatefulWidget {
  final List<PackageModel> packages;
  final PackagesController controller;

  const PackagesListWidget({
    super.key,
    required this.packages,
    required this.controller,
  });

  @override
  State<PackagesListWidget> createState() => _PackagesListWidgetState();
}

class _PackagesListWidgetState extends State<PackagesListWidget> {
  _handleSelectStatus(int index, String packageId) {
    for (int i = 0; i < widget.packages.length; i++) {
      if (widget.packages[i].id == packageId) {
        setState(() {
          switch (index) {
            case 0:
              widget.packages[i].status = 'approved';
              break;
            case 1:
              widget.packages[i].status = 'unapproved';
              break;
            default:
              widget.packages[i].status = 'waiting';
          }
        });
      }
    }
  }

  _handleShowPackageDetail(PackageModel? package) {
    widget.controller.handlePackageDetail(package);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
          defaultColumnWidth: const IntrinsicColumnWidth(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(100),
            1: FlexColumnWidth(100),
            2: FlexColumnWidth(100),
            3: FlexColumnWidth(100),
            4: FlexColumnWidth(100),
            5: FlexColumnWidth(150),
          },
          textBaseline: TextBaseline
              .alphabetic, // Pass this argument when using [TableCellVerticalAlignment.fill]
          children: PackagesListItemWidget(
            _handleSelectStatus,
            _handleShowPackageDetail,
          ).buildTableRows(
            context,
            widget.packages,
          ),
        ),
      ),
    );
  }
}
