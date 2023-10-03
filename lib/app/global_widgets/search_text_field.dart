import '../../main.dart';
import '../config/app_string.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SearchTextField extends FormField {
  SearchTextField({
    Key? key,
    double? width,
    String? label,
    String? value,
    ValueChanged? onChange,
    FormFieldSetter? onSaved,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmitted,
    Function(String)? onChanged,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    bool? enable,
  }) : super(
          key: key,
          builder: (state) {
            return TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (v) {
                if (onSubmitted != null) {
                  onSubmitted(v);
                }
              },
              onChanged: (v) {
                if (onChanged != null) {
                  onChanged(v);
                }
              },
              decoration: InputDecoration(
                hintText: buscarStr,
                focusColor: themeApp.colorWhite2,
                hoverColor: themeApp.colorWhite2,
                filled: true,
                fillColor: themeApp.colorWhite2,
                contentPadding: const EdgeInsets.all(12),
                isDense: true,
                border: OutlineInputBorder(),
                counterText: '',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeApp.white),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeApp.white),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeApp.white),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                prefixIcon: InkWell(
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: themeApp.colorGenericIcon,
                  ),
                ),
              ),
            );
          },
        );
}
