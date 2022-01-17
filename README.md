# My_QR_Code

## О приложении

Создано для быстрого и удобного доступа к сертификату о прохождении вакцинации от COVID-19
и QR коду, подтверждающему вакцинацию.

Основано на паттерне проектирования BLoC с управлением состояниями.

Содержит следующие модули:

- Главный экран
- Экран сканирования камерой
- Экран вывода информации об сертификате о вакцинации

## Использованы следующие пакеты

| Название пакета                                      | Версия        | Описание                                       |
| ---------------------------------------------------- | ------------- | ---------------------------------------------- |
| [qr_code_scanner][qr_code_scanner]                   | ^0.6.1        | Сканер QR-кода                                 |
| [html][html]                                         | ^0.15.0       | Парсер Dart HTML5                              |
| [http][http]                                         | ^0.13.4       | Использование ресурсов HTTP                    |
| [intl][intl]                                         | ^0.17.0       | Добавление языковых пакетов                    |
| [image_picker][image_picker]                         | ^0.8.4+4      | Выбор изображений из памяти устройства         |
| [shared_preferences][shared_preferences]             | ^2.0.11       | Получение доступа к нативным хранилищам        |
| [webview_flutter][webview_flutter]                   | ^3.0.0        | Плагин Flutter, предоставляющий виджет WebView |
| [qr_flutter][qr_flutter]                             | ^4.0.0        | Генерация QR-кода                              |
| [flutter_webview_plugin][flutter_webview_plugin]     | ^0.4.0        | Плагин для взаимодействия с собственным WebView|
| [r_scan][r_scan]                                     | ^0.1.6+1      | Плагин для сканирования qr-кода или штрих-кода |

[qr_code_scanner]: <https://pub.dev/packages/qr_code_scanner>
[html]: <https://pub.dev/packages/html>
[http]: <https://pub.dev/packages/http>
[intl]: <https://pub.dev/packages/intl>
[image_picker]: <https://pub.dev/packages/image_picker>
[shared_preferences]: <https://pub.dev/packages/shared_preferences>
[webview_flutter]: <https://pub.dev/packages/webview_flutter>
[qr_flutter]: <https://pub.dev/packages/qr_flutter>
[flutter_webview_plugin]: <https://pub.dev/packages/flutter_webview_plugin>
[r_scan]: <https://pub.dev/packages/r_scan>

