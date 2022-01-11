import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ethereum_state.dart';

class EthereumCubit extends Cubit<EthereumState> {
  EthereumCubit() : super(EthereumInitial());
}
