import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSuffixPressed;

  const CustomTextField({
    super.key,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    required this.onChanged,
    this.onSuffixPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError ? const Color(0xFFF35F5F) : Colors.transparent,
              width: 2,
            ),
            color: Theme.of(context).colorScheme.surfaceTint.withAlpha(40),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(
                prefixIcon,
                size: 25,
                color:
                    hasError ? const Color(0xFFF35F5F) : Theme.of(context).colorScheme.surfaceTint,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color:
                    hasError ? const Color(0xFFF35F5F) : Theme.of(context).colorScheme.surfaceTint,
                width: 2,
                height: 20,
              ),
              Expanded(
                child: TextFormField(
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (suffixIcon != null)
                IconButton(
                  onPressed: onSuffixPressed,
                  icon: Icon(
                    suffixIcon,
                    size: 25,
                    color: hasError
                        ? const Color(0xFFEF9A9A)
                        : Theme.of(context).colorScheme.surfaceTint,
                  ),
                ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 1.5),
            child: Row(
              children: [
                const Icon(Icons.error, size: 14, color: Colors.red),
                const SizedBox(width: 5),
                Text(errorText!, style: const TextStyle(color: Colors.red)),
              ],
            ),
          )
        else
          const SizedBox(height: 10),
      ],
    );
  }
}
