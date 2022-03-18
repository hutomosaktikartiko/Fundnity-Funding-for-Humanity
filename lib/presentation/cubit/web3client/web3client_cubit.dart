import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../core/config/keys_config.dart';
import '../../../core/config/urls_config.dart';

part 'web3client_state.dart';

class Web3ClientCubit extends Cubit<Web3ClientState> {
  Web3ClientCubit({
    required this.client,
  }) : super(Web3ClientState()){
    setDefaultNetwork();
  }

  final Client client;

  void setDefaultNetwork() {
    emit(Web3ClientState(
      web3client: Web3Client(
        UrlsConfig.alchemyRinkbey + KeysConfig.alchemyPrivateKey,
        client,
      ),
    ));
  }

  void changeNetwork({
    required String url,
  }) {
    emit(Web3ClientState(
      web3client: Web3Client(url + KeysConfig.infuraPrivateKey, client),
    ));
  }
}
