import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_coder/modules/screen/widgets/card_widget.dart';

/// Главный экран приложения
class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: const Color.fromRGBO(210, 226, 239, 1.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.supervised_user_circle,
                        size: 28.0,
                      ),
                      Icon(
                        Icons.settings,
                        size: 28.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Привет!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(71, 84, 108, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Фамилия Имя Отчество',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(171, 175, 178, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () => showActions(
                                topButtonText: 'Камера',
                                topButtonIcon: Icons.camera_alt_outlined,
                                bottomButtonText: 'Галерея',
                                bottomButtonIcon: Icons.slideshow,
                              ),
                              child: CardWidget(
                                title: 'Добавить QR код',
                                description: '',
                                color: const Color.fromRGBO(242, 76, 78, 1),
                                height: 0.35,
                                context: context,
                                icon: Icons.add,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () => showActions(
                                topButtonText: 'Да',
                                topButtonIcon: Icons.visibility_rounded,
                                bottomButtonText: 'Нет',
                                bottomButtonIcon: Icons.visibility_off,
                              ),
                              child: CardWidget(
                                title: 'Показывать при запуске приложения ',
                                description: '',
                                color: const Color.fromRGBO(150, 33, 75, 1),
                                height: 0.4,
                                context: context,
                                icon: Icons.slideshow,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () => showActions(
                                topButtonText: 'Камера',
                                topButtonIcon: Icons.camera_alt_outlined,
                                bottomButtonText: 'Галерея',
                                bottomButtonIcon: Icons.slideshow,
                              ),
                              child: CardWidget(
                                title: 'Заменить QR код',
                                description: '',
                                color: const Color.fromRGBO(255, 199, 89, 1),
                                height: 0.4,
                                context: context,
                                icon: Icons.arrow_downward,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () => showActions(
                                topButtonText: 'Удалить',
                                topButtonIcon: Icons.delete,
                                bottomButtonText: 'Отмена',
                                bottomButtonIcon: Icons.cancel,
                              ),
                              child: CardWidget(
                                title: 'Удалить',
                                description: '',
                                color: const Color.fromRGBO(79, 199, 254, 1),
                                height: 0.35,
                                context: context,
                                icon: Icons.delete,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Показывает уведомление для пользователя
  void showMessage() {
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoPageScaffold(
            child: Center(
              child: CupertinoButton(
                onPressed: () {
                  showCupertinoDialog<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text('Alert'),
                      content: const Text('Proceed with destructive action?'),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('Yes'),
                          isDestructiveAction: true,
                          onPressed: () {
                            // Do something destructive.
                          },
                        )
                      ],
                    ),
                  );
                },
                child: const Text('CupertinoAlertDialog'),
              ),
            ),
          );
        } else {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(210, 226, 239, 1.0),
            title: const Center(
              child: Text(
                '\n \nТема события не должна быть короче 10 символов',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        }
      },
    );
  }

  /// Показывает варианты дейсвий,
  /// принимает название верхней кнопки String [topButtonText],
  /// название нижней кнопки String [bottomButtonText],
  /// иконку верхней кнопки IconData [topButtonIcon],
  /// иконку нижней кнопки IconData [bottomButtonText],
  dynamic showActions({
    required String topButtonText,
    required String bottomButtonText,
    required IconData topButtonIcon,
    required IconData bottomButtonIcon,
  }) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(topButtonText),
                  Icon(topButtonIcon),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(bottomButtonText),
                  Icon(bottomButtonIcon),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(topButtonText),
                leading: Icon(topButtonIcon),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(bottomButtonText),
                leading: Icon(bottomButtonIcon),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
