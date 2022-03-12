import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/custom_color.dart';
import '../../../../../../../core/config/custom_text_style.dart';
import '../../../../../../cubit/cubits.dart';
import '../../../../../../widgets/custom_text_field.dart';
import '../../../custom_text_title.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String? description;

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  TextEditingController? descriptionController;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextTitle(title: "Your campaign description"),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          controller: descriptionController,
          enabledBorderColor: UniversalColor.gray4,
          textInputAction: TextInputAction.done,
          onChanged: _onSave,
          onEditingComplete: _onSave,
          style: CustomTextStyle.blackTextStyle.copyWith(
            fontSize: 15,
          ),
          minLines: 5,
          maxLines: 10,
        ),
      ],
    );
  }

  void _onSave() {
    context.read<CreateCampaignDataCubit>().setDescription(
          description: descriptionController?.text,
        );
  }
}
