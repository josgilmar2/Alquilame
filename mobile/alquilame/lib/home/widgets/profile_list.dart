import 'package:flutter/material.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPress;
  final Color? textColor;

  const ProfileList(
      {super.key,
      required this.title,
      required this.iconData,
      required this.onPress,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1)),
          child: Icon(
            iconData,
            color: Colors.black,
          ),
        ),
        title: Text(title,
            style:
                Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
        trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1)),
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
                onPressed: onPress)));
  }
}
