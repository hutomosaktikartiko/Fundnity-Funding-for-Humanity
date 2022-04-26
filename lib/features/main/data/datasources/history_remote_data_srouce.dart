import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/history_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryModel>> getListHistory({
    required String? address,
  });
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore firestore;

  HistoryRemoteDataSourceImpl({
    required this.firestore,
  });
  
  @override
  Future<List<HistoryModel>> getListHistory({
    required String? address,
  }) async {
    try {
      final QuerySnapshot result = await firestore.collection('users').doc(address).collection('history').get();

      List results = result.docs;

      return results.map((doc) => HistoryModel.fromJson(doc.data())).toList();
    } catch (error) {
      throw error;
    }
  }
}