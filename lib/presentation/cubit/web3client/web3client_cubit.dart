import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../core/config/keys_config.dart';
import '../../../core/config/urls_config.dart';
import '../../../injection_container.dart';

part 'web3client_state.dart';

class Web3clientCubit extends Cubit<Web3clientState> {
  Web3clientCubit({
    required this.client,
  })
      : super(
          Web3clientState(
            web3client: Web3Client(
              UrlsConfig.infuraRinkbeyProvider + KeysConfig.infuraPrivateKey,
              sl<Client>(),
            ),
          ),
        );

        final Client client;

  void changeNetwork({
    required String url,
  }) {
    emit(
      Web3clientState(
        web3client: Web3Client(url + KeysConfig.infuraPrivateKey, client),
      ),
    );
  }
}
