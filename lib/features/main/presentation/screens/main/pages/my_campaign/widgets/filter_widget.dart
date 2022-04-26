import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../data/models/filter_model.dart';
import '../../../../../cubit/selected_filter_campaign/selected_filter_campaign_cubit.dart';
import 'filter_campaign_card.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  void initState() {
    super.initState();
    _setDefaultFilter();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedFilterCampaignCubit,
        SelectedFilterCampaignState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: mockListFiltersMyCampaign
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Padding(
                      padding: EdgeInsets.only(
                        left: (key == 0) ? SizeConfig.defaultMargin : 5,
                        right: (key == mockListFiltersMyCampaign.length - 1)
                            ? SizeConfig.defaultMargin
                            : 0,
                      ),
                      child: GestureDetector(
                        onTap: () => _onSelectedFilter(
                          activeFilter: state.filter,
                          context: context,
                          filter: value,
                        ),
                        child: FilterCampaignCard(
                          filter: value.filter,
                          isActive: value == state.filter,
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        );
      },
    );
  }

  void _onSelectedFilter({
    required FilterModel? filter,
    required BuildContext context,
    required FilterModel? activeFilter,
  }) {
    if (activeFilter == filter) {
      // Set selectedFilterCampaignCubit to select first filter
      _setDefaultFilter();
    } else {
      context
          .read<SelectedFilterCampaignCubit>()
          .setSelectedFilter(filter: filter);
    }
  }

  void _setDefaultFilter() {
    context.read<SelectedFilterCampaignCubit>().setDefaultFilter();
  }
}
