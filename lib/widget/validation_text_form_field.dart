import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:get/get.dart';
import 'package:tagmeea/theme/app_colors.dart';
import 'package:tagmeea/theme/font_constants.dart';

import '../theme/theme_manager.dart';
import 'helper_widgets.dart';

class ValidationTextFormField extends StatefulWidget {
  const ValidationTextFormField(
      {super.key,
      this.icon,
      this.hintText,
      this.labelText,
      this.maxLength,
      this.minLength = 0,
      this.secured = false,
      this.onSuccess,
      this.onError,
      this.regexValidation,
      this.rules,
      this.textInputAction,
      this.textInputType,
      this.oldValue,
      required this.name});

  final IconData? icon;
  final String? hintText;
  final String? labelText;
  final bool? secured;
  final Map<Pattern, String>? regexValidation;
  final Map<String, String>? rules;
  final int? maxLength;
  final int minLength;
  final String name;
  final Function(String?)? onSuccess;
  final Function(String?)? onError;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? oldValue;

  @override
  State<ValidationTextFormField> createState() =>
      _ValidationTextFormFieldState();
}

class _ValidationTextFormFieldState extends State<ValidationTextFormField> {
  ThemeManager themeManager = Get.put(ThemeManager());
  bool hasError = false;
  String errorMessage = '';
  bool canValidate = false;
  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    txtController.text = widget.oldValue ?? '';
    ColorScheme theme = themeManager.colorScheme.value;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: hasError ? AppColors.danger : theme.surfaceVariant),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: theme.surfaceVariant,
                ),
                spaceW(20),
                Expanded(
                  child: TextFormField(
                      key: Key(widget.name),
                      initialValue: widget.oldValue ?? '',
                      keyboardType: widget.textInputType,
                      textInputAction: widget.textInputAction,
                      obscureText: widget.secured!,
                      style: const TextStyle(fontFamily: arFontFamily),
                      maxLength: widget.maxLength,
                      decoration: InputDecoration(
                          labelText: widget.labelText,
                          suffixIcon: canValidate
                              ? hasError
                                  ? Icon(Icons.error, color: AppColors.danger)
                                  : Icon(Icons.check, color: AppColors.success)
                              : null,
                          border: InputBorder.none,
                          hintText: widget.hintText),
                      onChanged: (val) {
                        canValidate = true;
                        //validate length
                        String param = '';
                        String rule = '';

                        widget.rules?.forEach((ruleExpression, err) {
                          if (ruleExpression.toString().contains("|")) {
                            rule = ruleExpression.toString().split("|")[0];
                            param = ruleExpression.toString().split("|")[1];
                          } else {
                            rule = ruleExpression;
                            param = '';
                          }

                          switch (rule) {
                            case 'required':
                              setState(() {
                                hasError = val.isEmpty;
                                errorMessage = err;
                              });
                              break;
                            case "min":
                              int limit = int.parse(param);
                              setState(() {
                                hasError = (val.length < limit) ? true : false;
                                errorMessage = err;
                              });
                              break;
                            case "match":
                              setState(() {
                                hasError = (val != param);
                                errorMessage = err;
                              });
                              break;
                          }
                        });

                        if (!hasError) {
                          widget.regexValidation?.forEach((regexPattern, err) {
                            if (Fzregex.hasMatch(val, regexPattern)) {
                              setState(() {
                                hasError = false;
                                widget.onSuccess!(val);
                              });
                            } else {
                              setState(() {
                                hasError = true;
                                errorMessage = err;
                                widget.onError!(errorMessage);
                              });
                            }
                          });
                        }

                        hasError
                            ? widget.onError!(errorMessage)
                            : widget.onSuccess!(val);
                      }),
                ),
              ],
            ),
          ),
        ),
        hasError
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: getSi().setHeight(10)),
                child: Text(
                  errorMessage,
                  style: errorStyle,
                ),
              )
            : spaceH_1X()
      ],
    );
  }
}
