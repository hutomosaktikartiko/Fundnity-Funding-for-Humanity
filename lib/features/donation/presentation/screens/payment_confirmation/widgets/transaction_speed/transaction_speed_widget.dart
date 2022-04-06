import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../cubit/gas_tracker/gas_tracker_cubit.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class TransactionSpeedWidget extends StatefulWidget {
  const TransactionSpeedWidget({Key? key}) : super(key: key);

  @override
  _TransactionSpeedWidgetState createState() => _TransactionSpeedWidgetState();
}

class _TransactionSpeedWidgetState extends State<TransactionSpeedWidget> {
  @override
  void initState() {
    super.initState();
    context.read<GasTrackerCubit>().getGasTracker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Transaction Speed",
          style: CustomTextStyle.gray1TextStyle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<GasTrackerCubit, GasTrackerState>(
          builder: (context, state) {
            if (state is GasTrackerLoaded) {
              return Loaded(
                listGas: state.listGas,
              );
            } else if (state is GasTrackerLoadingFailure) {
              return Error(message: state.message);
            } else if (state is GasTrackerLoading) {
              return Loading();
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
