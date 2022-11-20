import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/button/button_widget.dart';

class DisplayDialog {
  static Future<void> showDialogAsync(
      BuildContext context, String title, String content, IconData? icon,
      [String buttonLabel = '']) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Theme.of(context).colorScheme.secondary),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Theme.of(context).primaryTextTheme.caption?.color),
          ),
          actions: [
            icon != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Icon(
                        icon,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 40,
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ButtonWidget.secondary(
                label: buttonLabel.isEmpty ? 'Voltar' : buttonLabel,
                onTap: () {
                  Navigator.pop(context);
                },
                context: context,
              ),
            )
          ],
        );
      },
    );
  }
}
