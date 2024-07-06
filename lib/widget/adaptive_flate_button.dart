import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlateButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  AdaptiveFlateButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.amber,
            onPressed: handler,
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'BalsamiqSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            //  Color.fromARGB(255, 47, 147, 160),
            style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 47, 147, 160)),
            onPressed: handler,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'BalsamiqSans',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          );
  }
}
