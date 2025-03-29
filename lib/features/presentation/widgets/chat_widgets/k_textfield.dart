import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/constants/colors/app_colors.dart';

class KTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? prefixText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool isSubmitted;
  final bool? isEnabled;
  final MaskTextInputFormatter? formatter;
  final bool upperCase;
  final Function(String)? onChange;
  final TextStyle? labelStyle;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final bool? isDense;
  final bool? autofocus;
  final bool? obscureText;

  const KTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.validator,
    this.isEnabled,
    required this.isSubmitted,
    this.formatter,
    this.upperCase = false,
    this.onChange,
    this.labelStyle,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.isDense,
    this.autofocus,
    this.obscureText,
  });

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool active = false;

  @override
  void initState() {
    active = widget.controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      obscureText: widget.obscureText ?? false,
      contextMenuBuilder: kContextMenuBuilder,
      autofocus: widget.autofocus ?? false,
      autovalidateMode: widget.isSubmitted
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.formatter != null ? [widget.formatter!] : null,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      enabled: widget.isEnabled,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.prefixIcon != null
          ? (val) {
              if (widget.onChange != null) {
                widget.onChange!(val);
              }
              if (active && widget.controller.text.isEmpty) {
                setState(() {
                  active = false;
                });
              } else if (!active && widget.controller.text.isNotEmpty) {
                setState(() {
                  active = true;
                });
              }
            }
          : widget.onChange,
      validator: widget.validator ??
          (value) {
            if (value != null && value.isNotEmpty) {
              return null;
            }
            return 'Required'; //AppLocalizations.of(context)!.requiredToFill;
          },
      decoration: InputDecoration(
        isDense: widget.isDense,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: active
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).cardColor,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Container(
                margin: const EdgeInsets.only(right: 13.0),
                height: 24, // Desired height
                width: 24, // Desired width
                child: widget.suffixIcon,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24, // Control height
          maxWidth: 44, // Control width
        ),
        prefixText: widget.prefixText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.gray,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          //   fontFamily: TextFonts.sfPro,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          //   fontFamily: TextFonts.sfPro,
        ),
        alignLabelWithHint: true,
        fillColor: AppColors.stroke,
        filled: true,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusColor: Theme.of(context).primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorMaxLines: 2,
        prefixStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          //fontFamily: TextFonts.sfPro,
          // height: 1.0,
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        //fontFamily: TextFonts.sfPro,
      ),
    );
  }
}

class PhoneNumField extends StatelessWidget {
  final TextEditingController phoneCtrl;
  final bool isSubmitted;
  final String? hint;
  final String? label;
  final bool showContactPicker;
  final Function(String)? onChange;

  const PhoneNumField({
    super.key,
    required this.phoneCtrl,
    required this.isSubmitted,
    this.hint,
    this.label,
    this.showContactPicker = true,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return KTextField(
      controller: phoneCtrl,
      isSubmitted: isSubmitted,
      keyboardType: TextInputType.number,
      prefixText: '+993 | ',
      maxLength: 8,
      labelText: label ?? '',
      onChange: onChange,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'to fill'; //AppLocalizations.of(context)!.requiredToFill;
        } else if (val.length < 8) {
          return 'phoneNumberIncorrect'; //AppLocalizations.of(context)!.phoneNumberIncorrect;
        }
        num? v = num.tryParse(val);
        if (v == null) {
          return 'phoneNumberIncorrect'; //AppLocalizations.of(context)!.phoneNumberIncorrect;
        }
        return null;
      },
    );
  }
}

Widget kContextMenuBuilder(
    BuildContext context, EditableTextState editableTextState) {
  return AdaptiveTextSelectionToolbar.editable(
    clipboardStatus: ClipboardStatus.pasteable,
    onPaste: () async {
      if (await Clipboard.hasStrings()) {
        final val = await Clipboard.getData('text/plain');
        if (val != null && val.text != null) {
          String text = val.text!;
          if (text.startsWith('+993')) {
            text = text.replaceFirst('+993', '');
          } else if (text.startsWith('993')) {
            text = text.replaceFirst('993', '');
          }

          text = text.replaceAll(' ', '');
          if (val.text != text) {
            await Clipboard.setData(ClipboardData(text: text));
          }
        }
      }
      editableTextState.pasteText(SelectionChangedCause.toolbar);
    },
    onCopy: () =>
        editableTextState.copySelection(SelectionChangedCause.toolbar),
    onCut: () => editableTextState.cutSelection(SelectionChangedCause.toolbar),
    onLiveTextInput: null,
    onSelectAll: () =>
        editableTextState.selectAll(SelectionChangedCause.toolbar),
    anchors: editableTextState.contextMenuAnchors,
    onLookUp: () {},
    onSearchWeb: () {},
    onShare: () {},
  );
}
