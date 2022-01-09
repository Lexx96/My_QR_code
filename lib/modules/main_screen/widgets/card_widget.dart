import 'package:flutter/material.dart';

/// Виджет вывода карточки
class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.color,
      required this.height,
      required this.context,
      required this.icon})
      : super(key: key);

  final String title;
  final String description;
  final Color color;
  final double height;
  final BuildContext context;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(71, 84, 108, 1),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
          Icon(
            icon,
            size: 80.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
