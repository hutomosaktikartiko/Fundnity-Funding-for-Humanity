import 'dart:async';
import 'dart:developer';

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
  // Akun 1
  String address = "0x4994986400D969EeA1f90bE393A5F1B1b72a664A";
  String privateKey =
      "b8f06d9458c3d173fb25939ad8dbfd0e218ee2547f19fa05cf29d2519c361af2";

  // Rinkbey provider
  String rinkbeyProvider =
      "https://rinkeby.infura.io/v3/08ac79d88b5d4aea961ca36af7ea6ee7";

  // Ropsten provider
  String ropstenProvider =
      "https://ropsten.infura.io/v3/08ac79d88b5d4aea961ca36af7ea6ee7";

  // Local provider
  String localApiUrl = "http://10.0.2.2:7545/";

  // Contract Address
  String contractAddress = "0x4EE9aA39F40526F342725E77A6FBb9188319D4e9";

  Web3Client? web3Client;
  Client httpClient = Client();

  @override
  void initState() {
    super.initState();
    // Connect web3Client with [provider] and httpClient
    web3Client = Web3Client(ropstenProvider, httpClient);
    log("WEB3Client $web3Client");
    getBalance();
  }

  // Get balance of [address] by [provider]
  Future<void> getBalance() async {
    if (web3Client != null) {
      // Get ethereum Address from privateKey
      EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex(privateKey);
      log("PrivateKey ${ethPrivateKey.address}");
      // Get balance from [address] or [privateKey]
      EtherAmount balance =
          await web3Client!.getBalance(EthereumAddress.fromHex(address));
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
    String abi = await rootBundle.loadString("assets/contracts/abi.json");
    log("ABI $abi");

    final DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(abi, "DStorage"),
      EthereumAddress.fromHex(contractAddress),
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
        EthPrivateKey.fromHex(privateKey),
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

      pendingTransaction(result);
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

  StreamController<TransactionInformation>? streamController;

  Future<void> pendingTransaction(String hash) async {
    // try {
    //   final pendingTransaction = web3Client!.pendingTransactions();

    //   log("Pending Transaction ${pendingTransaction.first}");
    // } catch (error) {
    //   log("Pending Transaction error $error");
    // }

    final Stream<TransactionInformation> streamTransaction =
        web3Client!.getTransactionByHash(hash).asStream();

    setState(() {
      streamController?.addStream(streamTransaction);
    });

    // streamTransaction.listen((info) {
    // log("Transaction Info ${streamController.}");
    // });
  }

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
    print(streamController?.sink);
    return Container();
  }
}
