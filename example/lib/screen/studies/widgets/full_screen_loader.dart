import 'package:example/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        child: const CupertinoActivityIndicator(
          radius: 20,
          color: ColorName.mountainMeadow,
        ),
      ),
    );
  }
}
