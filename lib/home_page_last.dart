import 'dart:async';
import 'dart:developer';

import 'package:crowdfunding/core/config/contract_config.dart';
import 'package:crowdfunding/core/config/keys_config.dart';
import 'package:crowdfunding/core/config/urls_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Web3Client? web3Client;
  Client httpClient = Client();

  @override
  void initState() {
    super.initState();
    // Connect web3Client with [provider] and httpClient
    web3Client = Web3Client(UrlsConfig.infuraRinkbeyProvider, httpClient);
    log("WEB3Client $web3Client");
    getBalance();
  }

  // Get balance of [address] by [provider]
  Future<void> getBalance() async {
    if (web3Client != null) {
      // Get ethereum Address from privateKey
      // EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex(KeysConfig.privateKeyAkun1);
      // log("PrivateKey ${ethPrivateKey.address}");
      // Get balance from [address] or [privateKey]
      EtherAmount balance =
          await web3Client!.getBalance(EthereumAddress.fromHex(KeysConfig.addressAkun1));
      log("Balance ${balance.getValueInUnit(EtherUnit.ether)}");

      loadContract();
    }
  }

  // TODO: Connect to contract
  // Connect to contract
  // Apakah perlu connect dengan contract [offline] .abi juga? -> Ya
  // Kalau langsung connect dengan contract yang sudah dideploy [online] apakah bisa? -> Tidak, tetap butuh contract yang offline

  // Load Contract from abi file
  Future<void> loadContract() async {
    // Read the abi file
    String campaignAbi = await rootBundle.loadString("assets/contracts/campaign.json");
    log("Campaign Abi $campaignAbi");

    final DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(campaignAbi, "Campaigns"),
      EthereumAddress.fromHex(ContractConfig.crowdfunding),
    );

    log("Contract $contract");

    await callContract(contract);
    transaction(contract);
  }

  // Call contract
  Future<void> callContract(DeployedContract deployedContract) async {
    // Call function fileCount
    int fileCount = 0;
    try {
      final List result = await web3Client!.call(
        contract: deployedContract,
        function: deployedContract.function('fileCount'),
        params: [],
      );

      setState(() {
        fileCount = result[0].toInt();
      });
    } catch (error) {
      log("Call fileCount error $error");
    }
    log("FILECOUNT $fileCount");

    // Call function files
    List<List> files = [];

    for (int i = 1; i <= fileCount; i++) {
      try {
        final List result = await web3Client!.call(
          contract: deployedContract,
          function: deployedContract.function('files'),
          params: [BigInt.from(i)],
        );
        setState(() {
          files.add(result);
        });
      } catch (error) {
        log("Call Files[$i] error $error");
      }
    }
    log("FIlES $files");
  }

  // Transaction contract
  Future<void> transaction(DeployedContract contract) async {
    // Transaction function uploadFile
    try {
      final result = await web3Client!.sendTransaction(
        EthPrivateKey.fromHex(KeysConfig.privateKeyAkun1),
        Transaction.callContract(
          contract: contract,
          function: contract.function('uploadFile'),
          parameters: ["sd", BigInt.from(1), "sd", "sd", "sd"],
          maxGas: 100000,
        ),
        chainId: 3,
      );

      // getTransactionByHash(result);

      log("UploadFile $result");
    } catch (error) {
      log("Transaction uploadFile error $error");
    }
  }

  // fungsi pendingTransactions()
  // Package ini memanggil method eth_newPendingTransactionFilter dari infura
  // tetapi infura RPC terbaru tidak memiliki method eth_newPendingTransactionFilter
  // Jadi bisa dikatakan kalau package ini belum update

  // Opsinya stream data dari getTransactionByHash
  // Atau dicek berkala dari getTransactionByHash

  // Check transaction by hash for transaction was mined
  Future<void> getTransactionByHash(String hash) async {
    try {
      final TransactionInformation infoTransactionHash =
          await web3Client!.getTransactionByHash(hash);

      log("Info Transaction Hash $infoTransactionHash");

      if (infoTransactionHash.to != null) {
        try {
          final String resultCallRaw = await web3Client!.callRaw(
            contract: infoTransactionHash.to!,
            sender: infoTransactionHash.from,
            data: infoTransactionHash.input,
          );

          log("Result Call Raw $resultCallRaw");
        } catch (error) {
          log("Call Raw error $error");
        }
      }
    } catch (error) {
      log("Get Transaction By Hash error $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
