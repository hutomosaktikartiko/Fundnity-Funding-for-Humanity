import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/custom_color.dart';
import '../../../core/config/custom_text_style.dart';
import '../../../core/config/size_config.dart';
import '../../cubit/cubits.dart';
import 'widgets/create_campaign_button.dart';
import 'widgets/create_campaign_progress.dart';

// Target Donasi -> Jumlah dana yang dibutuhkan, Waktu penggalangan
// Judul -> Judul, Foto,
// Deskripsi -> Edit style text

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({Key? key}) : super(key: key);

  @override
  _CreateCampaignScreenState createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {

  @override
  void initState() {
    super.initState();
    context.read<CreateCampaignProgressCubit>().changeIndex(index: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Campaign',
          style: CustomTextStyle.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
        ),
        children: [
          const SizedBox(
            height: 20,
          ),
          CreateCampaignProress(),
        ],
      ),
      bottomNavigationBar:  Container(
        color: BackgroundColor.bgGray,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
          vertical: SizeConfig.defaultMargin + 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CreateCampaignButton(),
          ],
        ),
      ),
    );
  }
}


