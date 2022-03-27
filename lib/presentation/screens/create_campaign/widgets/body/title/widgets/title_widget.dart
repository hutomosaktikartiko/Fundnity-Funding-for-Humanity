import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../../cubit/cubits.dart';
import '../../../custom_text_title.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  TextEditingController? titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextTitle(title: "Title this campaign"),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          controller: titleController,
          enabledBorderColor: UniversalColor.gray4,
          textInputAction: TextInputAction.done,
          onChanged: _onSave,
          onEditingComplete: _onSave,
          style: CustomTextStyle.blackTextStyle.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  void _onSave() {
    context.read<CreateCampaignDataCubit>().setTitle(
          title: titleController?.text,
        );
  }
}
