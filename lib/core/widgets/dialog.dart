import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';


showErrorDialog({
  required BuildContext context,
  String message = "",
  String? title,
  String? code,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(left: 16, bottom: 43),
        elevation: 4,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 21.0),
                  child: Image.asset(
                    "assets/graphics/attention_orange.png",
                    width: 37,
                    height: 37,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11, right: 11, top: 30),
                    child: ButtonText(
                      title ?? AppLocalizations.of(context)!.error,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: BodyText1(message, color: Theme.of(context).colorScheme.optional2,),
            ),
            if(!code.isNullOrEmpty())
            Wrap(
              children: [
                BodyText1(AppLocalizations.of(context)!.error_code, color: Theme.of(context).colorScheme.optional2,),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.copied_to_buffer,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      right: 8,
                    ),
                    child: BodyText1(
                      code!,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
