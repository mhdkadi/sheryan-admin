import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sheryan_admin/app/core/theme/colors.dart';
import 'package:sheryan_admin/app/core/utils/intl.dart';
import 'package:sheryan_admin/app/core/widgets/shimmer_widget.dart';
import 'package:sheryan_admin/app/core/widgets/widget_state.dart';

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final bool negative = newValue.text.contains("-");
    final int? value = int.tryParse(newValue.text
        .replaceAll(",", "")
        .replaceAll("-", "")
        .replaceAll(".", ""));

    if (value != null) {
      return newValue.copyWith(
        text: negative ? "-${value.format()}" : value.format(),
        selection: TextSelection.fromPosition(TextPosition(
          offset:
              negative ? "-${value.format()}".length : value.format().length,
        )),
      );
    } else {
      return newValue.copyWith(
        text: "",
        selection: TextSelection.fromPosition(const TextPosition(
          offset: 0,
        )),
      );
    }
  }
}

class ReactiveCustomTextField extends StatefulWidget {
  const ReactiveCustomTextField({
    required this.widgetState,
    required this.formControlName,
    required this.hintText,
    this.showBorder = false,
    this.maxLines = 1,
    this.minLines,
    this.onChangedFormat,
    this.inputFormatters,
    this.validationMessages,
    this.onSubmitted,
    this.textInputAction,
    this.suffixIcon,
    this.onChanged,
    this.maxLength = 40,
    Key? key,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
  }) : super(key: key);
  final WidgetState widgetState;
  final void Function()? onSubmitted;
  final void Function(String text)? onChangedFormat;
  final void Function(String text)? onChanged;
  final String formControlName;
  final String hintText;
  final Map<String, String Function(Object)>? validationMessages;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool showBorder;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<ReactiveCustomTextField> createState() =>
      _ReactiveCustomTextFieldState();
}

class _ReactiveCustomTextFieldState extends State<ReactiveCustomTextField> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      key: Key(widget.formControlName),
      textInputAction: widget.textInputAction,
      formControlName: widget.formControlName,
      readOnly: widget.widgetState == WidgetState.loading,
      validationMessages: widget.validationMessages,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      minLines: widget.minLines,
      onTap: (_) {
        if (controller.selection.extent.offset == 0) {
          setState(() {
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          });
        }
      },
      onChanged: (control) {
        if (widget.onChanged != null) {
          widget.onChanged!(controller.text);
        }
      },
      controller: controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      onSubmitted: widget.widgetState != WidgetState.loading &&
              widget.onSubmitted != null
          ? (_) => widget.onSubmitted!()
          : null,
      style: const TextStyle(color: AppColors.font),
      cursorColor: AppColors.secondry,
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: AppColors.font, fontSize: 13),
          hintText: widget.hintText,
          counterText: "",
          enabledBorder: widget.showBorder
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondry),
                )
              : null,
          border: widget.showBorder
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondry),
                )
              : null,
          suffixIcon: widget.suffixIcon),
    );
  }
}

Map<String, dynamic>? phone(AbstractControl<dynamic> control) {
  return control.value == null || phoneRegExp.hasMatch(control.value)
      ? null
      : {'phone': true};
}

RegExp phoneRegExp = RegExp(r'(^(0?9)[0-9]{8}$)');

class HeaderTextField extends StatelessWidget {
  const HeaderTextField({
    required this.widgetState,
    required this.formControlName,
    required this.hintText,
    required this.header,
    this.showBorder = false,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.onChangedFormat,
    this.onSubmitted,
    this.suffixIcon,
    this.maxLength = 40,
    this.validationMessages,
    this.onChanged,
    this.textInputAction,
    Key? key,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
  }) : super(key: key);
  final WidgetState widgetState;
  final void Function()? onSubmitted;
  final String formControlName;
  final String hintText;
  final String header;
  final Map<String, String Function(Object)>? validationMessages;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool showBorder;
  final int? maxLines;
  final void Function(String text)? onChangedFormat;
  final void Function(String text)? onChanged;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ReactiveCustomTextField(
            obscureText: obscureText,
            showBorder: showBorder,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            onChangedFormat: onChangedFormat,
            minLines: minLines,
            validationMessages: validationMessages,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            suffixIcon: suffixIcon,
            maxLength: maxLength,
            widgetState: widgetState,
            onSubmitted: onSubmitted,
            formControlName: formControlName,
            hintText: hintText),
      ],
    );
  }
}

class TextFieldModel {
  const TextFieldModel({
    required this.onSubmitted,
    required this.formControlName,
    required this.hintText,
    required this.header,
    this.validationMessages,
    Key? key,
    this.keyboardType = TextInputType.emailAddress,
  });
  final void Function() onSubmitted;
  final String formControlName;
  final String hintText;
  final String header;
  final Map<String, String Function(Object)>? validationMessages;
  final TextInputType keyboardType;
}

class ReactiveCustomDropdownField<T> extends StatelessWidget {
  const ReactiveCustomDropdownField({
    required this.widgetState,
    required this.formControlName,
    required this.hintText,
    required this.items,
    this.showBorder = false,
    this.validationMessages,
    this.onChanged,
    Key? key,
  }) : super(key: key);
  final Map<String, String Function(Object)>? validationMessages;
  final WidgetState widgetState;
  final String formControlName;
  final String hintText;
  final void Function(FormControl<T>)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField<T>(
      formControlName: formControlName,
      readOnly: widgetState == WidgetState.loading,
      underline: Container(),
      borderRadius: BorderRadius.circular(15),
      menuMaxHeight: 400,
      decoration: InputDecoration(
        enabledBorder: showBorder
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              )
            : null,
        border: showBorder
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              )
            : null,
      ),
      validationMessages: validationMessages,
      dropdownColor: AppColors.primary.withOpacity(0.9),
      iconEnabledColor: Colors.black,
      isExpanded: true,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).primaryColor,
      ),
      items: items,
      hint: Text(hintText,
          style: const TextStyle(
            color: AppColors.font,
            fontSize: 13,
          )),
      onTap: (_) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onChanged,
    );
  }
}

class HeaderDropdownField<T> extends StatelessWidget {
  const HeaderDropdownField({
    required this.widgetState,
    required this.formControlName,
    required this.hintText,
    required this.items,
    required this.header,
    this.showBorder = false,
    this.validationMessages,
    this.onChanged,
    Key? key,
  }) : super(key: key);
  final Map<String, String Function(Object)>? validationMessages;
  final WidgetState widgetState;
  final String formControlName;
  final String hintText;
  final void Function(FormControl<T>)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final String header;
  final bool showBorder;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ReactiveCustomDropdownField(
          widgetState: widgetState,
          showBorder: showBorder,
          formControlName: formControlName,
          hintText: hintText,
          onChanged: onChanged,
          validationMessages: validationMessages,
          items: items,
        ),
      ],
    );
  }
}

class StateHeaderDropdownField<T> extends StatelessWidget {
  const StateHeaderDropdownField({
    required this.widgetState,
    required this.formControlName,
    required this.hintText,
    required this.items,
    required this.header,
    required this.onRetry,
    this.showBorder = false,
    this.fieldState,
    this.validationMessages,
    this.onChanged,
    Key? key,
  }) : super(key: key);
  final Map<String, String Function(Object)>? validationMessages;
  final WidgetState widgetState;
  final WidgetState? fieldState;
  final String formControlName;
  final String hintText;
  final void Function(FormControl<T>)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final String header;
  final bool showBorder;
  final void Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      switch (fieldState) {
        case WidgetState.loading:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 9),
              ShimmerWidget(
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  height: 65,
                  width: double.infinity)
            ],
          );
        case WidgetState.error:
          return SizedBox(
            height: 98,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Center(
                  child: IconButton(
                    onPressed: onRetry,
                    icon: const Icon(
                      Icons.refresh,
                      color: AppColors.font,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        default:
          return HeaderDropdownField<T>(
            widgetState: widgetState,
            header: header,
            showBorder: showBorder,
            formControlName: formControlName,
            hintText: hintText,
            onChanged: onChanged,
            validationMessages: validationMessages,
            items: items,
          );
      }
    });
  }
}
