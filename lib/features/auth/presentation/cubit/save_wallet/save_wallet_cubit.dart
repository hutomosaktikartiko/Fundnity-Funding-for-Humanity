import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../../../core/utils/directory_info.dart';
import '../../../../../core/utils/permission_info.dart';

part 'save_wallet_state.dart';

class SaveWalletCubit extends Cubit<SaveWalletState> {
  SaveWalletCubit({
    required this.directoryInfo,
    required this.permissionInfo,
  }) : super(SaveWalletInitial());

  final DirectoryInfo directoryInfo;
  final PermissionInfo permissionInfo;

  Future<ReturnValueModel> saveWallet({
    required String? wallet,
  }) async {
    try {
      if (!await permissionInfo.directoryPermission) {
        throw "External storage permission denied";
      }

      final Directory? directory = await directoryInfo.documentsDirectory;
      if (directory == null) {
        throw "Download directory not found";
      }

      final File result = await File(directory.path + "/Backup-Wallet-${DateTime.now().millisecondsSinceEpoch}.json").writeAsString(wallet ?? "");

      return ReturnValueModel(
        isSuccess: true,
        message: "Success save your wallet to ${result.path}."
      );
    } catch (error) {
      throw error;
    }
  }
}
