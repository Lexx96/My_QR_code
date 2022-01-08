import 'package:flutter/material.dart';
import 'bloc/license_agreement_bloc.dart';
import 'bloc/license_agreement_state.dart';

class LicenseAgreement extends StatefulWidget {
  final bool isFirstEnter;
  const LicenseAgreement({Key? key, required this.isFirstEnter})
      : super(key: key);

  @override
  State<LicenseAgreement> createState() => _LicenseAgreementState();
}

class _LicenseAgreementState extends State<LicenseAgreement> {
  bool? _isAccepted;
  late LicenseAgreementState data = LicenseAgreementState();
  late final LicenseAgreementBloc _bloc;
  final _mainTextStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
  final _secondTextStyle = const TextStyle(
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    _bloc = LicenseAgreementBloc();
    _bloc.emptyState();
    _isAccepted = false;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.streamControllerLicense,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is LicenseAgreementState) {
            data = snapshot.data;
          }
          return Container(
            color: Colors.transparent,
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '''Лицензионное соглашение на использование программы «MY QR» для мобильных устройств''',
                        style: _mainTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '''Перед использованием программы, пожалуйста, ознакомьтесь с условиями нижеследующего лицензионного соглашения.
                  \nЛюбое использование Вами программы означает полное и безоговорочное принятие Вами условий настоящего лицензионного соглашения.
                  \nЕсли Вы не принимаете условия лицензионного соглашения в полном объёме, Вы не имеете права использовать программу в каких-либо целях.
''',
                        style: _secondTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '1. Общие положения',
                          style: _mainTextStyle,
                        ),
                      ),
                      Text(
                        '''1.1. Настоящее Лицензионное соглашение («Лицензия») устанавливает условия использования программы «EventOnMap» для мобильных устройств («Программа»), и заключено между любым лицом, использующим Программу («Пользователь»), и ООО «VGOSTY», Россия, 654000, г. Новокузнецк, ул. Кирова , 73, являющимся правообладателем исключительного права на Программу («Правообладатель»).
                  \n1.2. Копируя Программу, устанавливая её на свое устройство или используя Программу любым образом, Пользователь выражает свое полное и безоговорочное согласие со всеми условиями Лицензии.
                  \n1.3. Использование Программы разрешается только на условиях настоящей Лицензии. Если Пользователь не принимает условия Лицензии в полном объёме, Пользователь не имеет права использовать Программу в каких-либо целях. Использование Программы с нарушением (невыполнением) какого-либо из условий Лицензии запрещено.
                  \n1.4. Использование Программы Пользователем на условиях настоящей Лицензии в личных некоммерческих целях осуществляется безвозмездно.  Использование Программы на условиях и способами, не предусмотренными настоящей Лицензией, возможно только на основании отдельного соглашенияс Правообладателем.
''',
                        style: _secondTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '2. Право на Программу',
                          style: _mainTextStyle,
                        ),
                      ),
                      const Text(
                        '2.1. Исключительное право на Программу принадлежит Правообладателю.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '3. Лицензия',
                          style: _mainTextStyle,
                        ),
                      ),
                      Text(
                        '''3.1. Правообладатель безвозмездно, на условиях простой (неисключительной) лицензии, предоставляет Пользователю непередаваемое право использования Программы на территории стран всего мира следующими способами:
                  \n3.1.1. Применять Программу по прямому функциональному назначению, в целях чего произвести ее копирование и установку (воспроизведение) устройство(-ва) Пользователя. Пользователь вправе произвести установку Программы на неограниченное число устройств. При установке на устройство каждой копии Программы присваивается индивидуальный номер, который автоматически сообщается Правообладателю.
                  \n3.1.2. Воспроизводить и распространять Программу в некоммерческих целях (безвозмездно).
''',
                        style: _secondTextStyle,
                      ),
                      Text(
                        '4. Ограничения',
                        style: _mainTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '''4.1. За исключением использования в объемах и способами, прямо предусмотренными настоящей Лицензией или законодательством РФ, Пользователь не имеет права изменять, декомпилировать, дизассемблировать, дешифровать и производить иные действия с объектным кодом Программы, имеющие целью получение информации о реализации алгоритмов, используемых в Программе, создавать производные произведения с использованием Программы, а также осуществлять (разрешать осуществлять) иное использование Программы, без письменного согласия Правообладателя.
                    \n4.2. Пользователь не имеет право воспроизводить и распространять Программу в коммерческих целях (в том числе за плату), в том числе в составе сборников программных продуктов, без письменного согласия Правообладателя.
                    \n4.3. Пользователь не имеет права распространять Программу в виде, отличном от того, в котором он ее получил, без письменного согласия Правообладателя.
                    \n4.4. Программа должна использоваться (в том числе распространяться) под наименованием: «EventOnMap». Пользователь не вправе изменять наименование Программы, изменять и/или удалять знак охраны авторского права или иное указание на Правообладателя.
''',
                          style: _secondTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '5. Условия использования отдельных функций Программы',
                          style: _mainTextStyle,
                        ),
                      ),
                      Text(
                        '''5.1. Выполнение функций Программы возможно только при наличии доступа к сети Интернет. Пользователь самостоятельно получает и оплачивает такой доступ на условиях и по тарифам своего оператора связи или провайдера доступа к сети Интернет.
                  \n5.2. Пользователь настоящим уведомлен и соглашается, что при использовании в Программе функции «Определение местоположения», перед отправкой поискового запроса Программа получает данные о ближайшей соте оператора связи, sim-карта которого установлена в устройстве Пользователя, и передает его в составе поискового запроса, до момента отключения указанной функции.
                  \n5.3. Пользователь может в любой момент отказаться от передачи данных, указанных в п. 5.2, отключив соответствующую функцию.
                  \n5.4. Все данные об использовании Программы, передаваемые в соответствии с настоящей Лицензией, сохраняются и обрабатываются в соответствии с Политикой конфиденциальности.
''',
                        style: _secondTextStyle,
                      ),
                      widget.isFirstEnter
                          ? Row(
                              children: [
                                Text(
                                  'Принять',
                                  style: _secondTextStyle,
                                ),
                                Checkbox(
                                  value: data is EmptyLicenseAgreementState
                                      ? _isAccepted
                                      : true,
                                  onChanged: (bool? isAccepted) =>
                                      _agreeTerms(isAccepted),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      widget.isFirstEnter
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: data is EmptyLicenseAgreementState
                                      ? ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey))
                                      : null,
                                  onPressed: data is EmptyLicenseAgreementState
                                      ? null
                                      : () {},
                                  child: const Text('OK'),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Отмена'),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Есть ли соглашение на ЛС
  void _agreeTerms(bool? isAccepted) {
    if (isAccepted == false) {
      _bloc.emptyState();
    } else {
      _bloc.accepted();
    }
  }
}
