import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/helpers/transaction_details.dart';

class Transaction {
  static void initializeTransaction({
    required String receiverUpiAddress,
    required String receiverName,
    required String transactionRef,
    required String amount,
    String? url,
    String? transactionNote,
  }) async {
    try {
      MethodChannel platform = const MethodChannel('splitty-app');
      final transactionDetails = TransactionDetails(
        payeeAddress: receiverUpiAddress,
        payeeName: receiverName,
        transactionRef: transactionRef,
        amount: amount,
        url: url,
        transactionNote: transactionNote,
      );
      final result = await platform.invokeMethod<int>(
          'initializeTransaction', transactionDetails.toJson());
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }
}
