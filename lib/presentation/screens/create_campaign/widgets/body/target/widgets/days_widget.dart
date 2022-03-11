import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/extenstions/date_time_parsing.dart';
import '../../../../../../../data/models/campaign_time_model.dart';
import '../../../../../../cubit/cubits.dart';
import '../../../custom_text_title.dart';
import 'target_day_item.dart';

class DaysWidget extends StatefulWidget {
  const DaysWidget({Key? key}) : super(key: key);

  @override
  State<DaysWidget> createState() => _DaysWidgetState();
}

class _DaysWidgetState extends State<DaysWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SelectedDateCubit>().setSelectedDate(selectedDate: null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextTitle(
          title: "Determine how long the campaign will run",
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
          child: BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
            builder: (context, selectedCreateCampaginTimeState) {
              return Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                children: [
                  ...mockListCampaignTimes
                      .asMap()
                      .map(
                        (key, value) => MapEntry(
                          key,
                          GestureDetector(
                            onTap: () => _onSelectTime(time: value.days),
                            child: TargetDayItem(
                              isActive: value.days ==
                                  selectedCreateCampaginTimeState.time,
                              text: "${value.days} days",
                              width: (SizeConfig.screenWidth -
                                      (SizeConfig.defaultMargin * 2.5)) /
                                  2,
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                  BlocConsumer<SelectedDateCubit, SelectedDateState>(
                    listener: (context, state) {
                      context
                          .read<CreateCampaignDataCubit>()
                          .setSelectedDateTime(
                            selectedTime: state.selectedDate,
                          );
                    },
                    builder: (context, state) {
                      return BlocBuilder<SelectedDateCubit, SelectedDateState>(
                        builder: (context, selectedDateState) {
                          return GestureDetector(
                            onTap: _selectDate,
                            child: TargetDayItem(
                              isActive: _checkDate(
                                selectedDate: selectedDateState.selectedDate,
                                time: selectedCreateCampaginTimeState.time,
                              ),
                              text:
                                  "${(selectedDateState.selectedDate.dateTimeToString()) ?? 'select date'}",
                              width: (SizeConfig.screenWidth -
                                      (SizeConfig.defaultMargin * 2.5)) /
                                  2,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _onSelectTime({
    required int? time,
  }) {
    context.read<CreateCampaignDataCubit>().setSelectedTime(selectedTime: time);
  }

  bool _checkDate({
    required DateTime? selectedDate,
    required int? time,
  }) {
    if (selectedDate == null) {
      return false;
    }

    for (CampaignTimeModel campaignTime in mockListCampaignTimes) {
      if (campaignTime.days == selectedDate.daysBetween()) {
        return false;
      }
    }

    return selectedDate.daysBetween() == time;
  }

  void _selectDate() {
    context.read<SelectedDateCubit>().openCalendar(context: context);
  }
}
