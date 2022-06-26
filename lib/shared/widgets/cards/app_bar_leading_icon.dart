import 'package:flutter/material.dart';

class AppBarLeadingButton extends StatelessWidget {
  final IconData icon;
  const AppBarLeadingButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(left: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Icon(icon),
      ),
    );
  }
}
