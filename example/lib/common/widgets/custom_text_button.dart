import 'package:example/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.text,
    this.onPressed,
    this.isLoading = false,
  })  : assert(isLoading == false ? text != null : true),
        super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: isLoading
          ? const CupertinoActivityIndicator(
              color: ColorName.mountainMeadow,
              radius: 9,
            )
          : Text(
              text!,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
            ),
    );
  }
}
