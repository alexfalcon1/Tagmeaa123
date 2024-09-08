import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../theme/app_colors.dart';
import '../theme/theme_manager.dart';

class FormBuilderTextFieldEx extends StatefulWidget {
  const FormBuilderTextFieldEx(
      {super.key,
      required this.name,
      this.labelText,
      this.onSuccess,
      this.onError,
      this.validator,
      this.hintText,
      this.textInputAction,
      this.textInputType,
      this.icon,
      this.errorIcon,
      this.secured,
      this.errorText,
      required this.formKey});

  final String name;
  final String? labelText;
  final Function(String?)? onSuccess;
  final Function? onError;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final IconData? icon;
  final bool? secured;
  final String? errorText;
  final Icon? errorIcon;
  final GlobalKey<FormBuilderState> formKey;

  @override
  State<FormBuilderTextFieldEx> createState() => _FormBuilderTextFieldExState();
}

class _FormBuilderTextFieldExState extends State<FormBuilderTextFieldEx> {
  bool instanceHasError = true;

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.surfaceVariant)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getSi().setHeight(5),
                horizontal: getSi().setWidth(20)),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: theme.surfaceVariant,
                ),
                spaceW(20),
                Expanded(
                  child: FormBuilderTextField(
                    obscureText: widget.secured!,
                    name: widget.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: widget.labelText,
                      suffixIcon: instanceHasError
                          ? Icon(Icons.error, color: AppColors.danger)
                          : Icon(Icons.check, color: AppColors.success),
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    onChanged: (val) {
                      setState(() {
                        instanceHasError = widget.formKey.currentState
                                ?.fields[widget.name]?.hasError ??
                            false;

                        instanceHasError
                            ? widget.onError
                            : widget.onSuccess!(widget.formKey.currentState
                                ?.fields[widget.name]?.value);
                      });
                    },
                    keyboardType: widget.textInputType,
                    textInputAction: widget.textInputAction,
                  ),
                ),
              ],
            ),
          ),
        ),
        instanceHasError ? Text(widget.errorText!) : spaceH_1X()
      ],
    );
  }
}
