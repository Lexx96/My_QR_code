import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_coder/modules/main_screen/widgets/card_widget.dart';
import 'package:qr_coder/modules/main_screen/widgets/show_dialog_widget.dart';
import 'package:qr_coder/modules/show_qr_code_screen/show_qr_code_screen.dart';
import 'package:qr_coder/utils/main_navigation/main_navigation.dart';
import 'bloc/main_screen_bloc.dart';
import 'bloc/main_screen_state.dart';
import 'service/main_screen_service.dart';

/// Главный экран приложения
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenBloc _bloc;
  late bool? _isShowScreen = false;
  String? _url = null;

  @override
  void initState() {
    super.initState();
    _bloc = MainScreenBloc();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.getURLFromSharedPreferences();
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.mainScreenStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is ReadURLFromSharedPreferencesState) {
            final _data = snapshot.data as ReadURLFromSharedPreferencesState;
            _url = _data.url;
          }

          if (snapshot.data
              is ReadIsShowQRCodeScreenFromSharedPreferencesState) {
            final _isShowQRCodeScreen = snapshot.data
                as ReadIsShowQRCodeScreenFromSharedPreferencesState;
            _isShowScreen = _isShowQRCodeScreen.isShowQRCodeScreen;
          }

          return ListView(
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
                      Text(
                        _url != null
                            ? 'Рады тебя видеть'
                            : 'Фамилия Имя Отчество',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(171, 175, 178, 1),
                        ),
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                _url != null
                                    ? InkWell(
                                        onTap: () => showActions(
                                          topButtonText: 'Показать',
                                          topButtonIcon: const Icon(
                                            Icons.camera_alt_outlined,
                                          ),
                                          bottomButtonIcon: null,
                                          functionTopButton: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => ShowQRCodeScreen(
                                                url: _url,
                                              ),
                                            ),
                                          ),
                                          functionBottomBottom: () {},
                                        ),
                                        child: CardWidget(
                                          title: 'Ваш QR код',
                                          description: '',
                                          color: const Color.fromRGBO(
                                              242, 76, 78, 1),
                                          height: 0.35,
                                          context: context,
                                          icon: Icons.qr_code,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () => showActions(
                                          topButtonText: 'Камера',
                                          topButtonIcon: const Icon(
                                              Icons.camera_alt_outlined),
                                          bottomButtonText: 'Галерея',
                                          bottomButtonIcon:
                                              const Icon(Icons.slideshow),
                                          functionTopButton: () =>
                                              Navigator.of(context).pushNamed(
                                                  MainNavigationRouteName
                                                      .viewScreen),
                                          functionBottomBottom: () =>
                                              Navigator.of(context).pushNamed(
                                                  MainNavigationRouteName
                                                      .viewScreen),
                                        ),
                                        child: CardWidget(
                                          title: 'Добавить QR код',
                                          description: '',
                                          color: const Color.fromRGBO(
                                              242, 76, 78, 1),
                                          height: 0.35,
                                          context: context,
                                          icon: Icons.add,
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  onTap: _url != null
                                      ? () {
                                          _bloc.isShowQRCodeScreen();
                                          showActions(
                                            topButtonText: 'Да',
                                            bottomButtonText: 'Нет',
                                            topButtonIcon: _isShowScreen == true
                                                ? const Icon(
                                                    Icons.visibility_rounded,
                                                    color: Colors.green,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_rounded,
                                                  ),
                                            bottomButtonIcon:
                                                _isShowScreen == false
                                                    ? const Icon(
                                                        Icons.visibility_off,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons.visibility_off,
                                                      ),
                                            functionTopButton: () async {
                                              await MainScreenService()
                                                  .setIsShowQRCodeScreenService(
                                                      true);
                                              _bloc.isShowQRCodeScreen();
                                              Navigator.of(context).pop();
                                            },
                                            functionBottomBottom: () async {
                                              await MainScreenService()
                                                  .setIsShowQRCodeScreenService(
                                                      false);
                                              _bloc.isShowQRCodeScreen();
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }
                                      : () {},
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
                                  onTap: _url != null
                                      ? () => showActions(
                                            topButtonText: 'Камера',
                                            bottomButtonText: 'Галерея',
                                            topButtonIcon: const Icon(
                                                Icons.camera_alt_outlined),
                                            bottomButtonIcon:
                                                const Icon(Icons.slideshow),
                                            functionTopButton: () =>
                                                Navigator.of(context).pushNamed(
                                                    MainNavigationRouteName
                                                        .viewScreen),
                                            functionBottomBottom: () =>
                                                Navigator.of(context).pushNamed(
                                                    MainNavigationRouteName
                                                        .viewScreen),
                                          )
                                      : () {},
                                  child: CardWidget(
                                    title: 'Заменить QR код',
                                    description: '',
                                    color:
                                        const Color.fromRGBO(255, 199, 89, 1),
                                    height: 0.4,
                                    context: context,
                                    icon: Icons.arrow_downward,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  onTap: _url != null
                                      ? () => showActions(
                                            topButtonText: 'Удалить',
                                            bottomButtonText: 'Отмена',
                                            topButtonIcon:
                                                const Icon(Icons.delete),
                                            bottomButtonIcon:
                                                const Icon(Icons.cancel),
                                            functionTopButton: () {
                                              _bloc
                                                  .deleteURLFromSharedPreferences();
                                              Navigator.of(context).pop();
                                            },
                                            functionBottomBottom: () =>
                                                Navigator.of(context).pop(),
                                          )
                                      : () {},
                                  child: CardWidget(
                                    title: 'Удалить',
                                    description: '',
                                    color:
                                        const Color.fromRGBO(79, 199, 254, 1),
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
          );
        },
      ),
    );
  }

  /// Показывает варианты дейсвий,
  /// принимает название верхней кнопки String [topButtonText],
  /// название нижней кнопки String [bottomButtonText],
  /// иконку верхней кнопки IconData [topButtonIcon],
  /// иконку нижней кнопки IconData [bottomButtonText],
  dynamic showActions({
    required String topButtonText,
    required Icon topButtonIcon,
    required Function() functionTopButton,
    String? bottomButtonText,
    required Icon? bottomButtonIcon,
    required Function() functionBottomBottom,
  }) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => functionTopButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(topButtonText),
                  topButtonIcon,
                ],
              ),
            ),
            bottomButtonText != null && bottomButtonIcon != null
                ? CupertinoActionSheetAction(
                    onPressed: () => functionBottomBottom(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(bottomButtonText),
                        bottomButtonIcon,
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
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
                leading: topButtonIcon,
                onTap: () => functionTopButton(),
              ),
              bottomButtonText != null
                  ? ListTile(
                      title: Text(bottomButtonText),
                      leading: bottomButtonIcon,
                      onTap: () => functionBottomBottom(),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
