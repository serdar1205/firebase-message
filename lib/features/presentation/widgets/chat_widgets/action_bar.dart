import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'k_textfield.dart';

class ActionBar extends StatefulWidget {
  const ActionBar({
    super.key,
    required this.focusNode,
    required this.onSendClicked,
    required this.onMicrophoneClicked,
    required this.textEditingController,
  });

  final FocusNode focusNode;
  final VoidCallback onSendClicked;
  final VoidCallback onMicrophoneClicked;
  final TextEditingController textEditingController;

  @override
  _ActionBarState createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  bool isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      isTextEmpty = widget.textEditingController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 80,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.stroke),
            child: SvgPicture.asset(IconsAssets.attach),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: KTextField(
                focusNode: widget.focusNode,
                controller: widget.textEditingController,
                isSubmitted: false,
                hintText: "Сообщение",
              ),
            ),
          ),
          InkWell(
            onTap:
                isTextEmpty ? widget.onMicrophoneClicked : widget.onSendClicked,
            child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.stroke,
              ),
              child: isTextEmpty
                  ? SvgPicture.asset(IconsAssets.microphone)
                  : Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
