import 'package:flutter/material.dart';

class OrBetween extends StatelessWidget {
  const OrBetween({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('OR'),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
