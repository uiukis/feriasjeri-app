import 'package:flutter/material.dart';

class CustomClickableTile extends StatelessWidget {
  final IconData? prefixIcon;
  final String text;
  final VoidCallback? onTap;
  final String? errorText;

  const CustomClickableTile({
    super.key,
    this.prefixIcon,
    required this.text,
    this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hasError ? Colors.red : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            leading: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Colors.black,
                    size: 20,
                  )
                : null,
            title: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: hasError ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 5.0),
            child: Text(
              errorText!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
