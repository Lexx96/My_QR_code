import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Виджет вывода оповещения
class ShowDialogWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? textLeftButton;
  final Function? onTabLeftButton;
  final String? textRightButton;
  final Function? onTabRightButton;

  const ShowDialogWidget(
      {Key? key,
      this.title,
      this.description,
      this.textLeftButton,
      this.onTabLeftButton,
      this.textRightButton,
      this.onTabRightButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: Center(
              child: CupertinoButton(
                onPressed: () {
                  showCupertinoDialog<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text(title ?? ''),
                      content: Text(description ?? ''),
                      actions: [
                        textLeftButton != null
                            ? CupertinoDialogAction(
                                child: Text(textLeftButton!),
                                onPressed: () => onTabLeftButton,
                              )
                            : const SizedBox.shrink(),
                        textRightButton != null
                            ? CupertinoDialogAction(
                                child: Text(textRightButton!),
                                isDestructiveAction: true,
                                onPressed: () => onTabRightButton,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                },
                child: const Text('CupertinoAlertDialog'),
              ),
            ),
          )
        : AlertDialog(
            backgroundColor: const Color.fromRGBO(210, 226, 239, 1.0),
            title: Center(
              child: Text(
                '\n \n$description',
              ),
            ),
            actions: [
              textLeftButton != null
                  ? TextButton(
                      onPressed: () => onTabLeftButton,
                      child: Text(textLeftButton!),
                    )
                  : const SizedBox.shrink(),
              textRightButton != null
                  ? TextButton(
                      onPressed: () => onTabRightButton,
                      child: Text(textRightButton!),
                    )
                  : const SizedBox.shrink(),
            ],
          );
  }
}