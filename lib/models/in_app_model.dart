class InAppModel {
  String packageName;
  String productId;
  String transactionId;
/*
  String originalTransactionId;
*/
  String status;
  String purchaseToken;
  bool isPending;
  VerificationData verificationData;
  bool isAcknowledged;

  InAppModel(
      {required this.packageName,
      required this.productId,
      required this.transactionId,
      // required this.originalTransactionId,
/*
      required this.purchaseDate,
*/
      required this.status,
      required this.isPending,
/*
  String purchaseDate;
*/

        required this.purchaseToken,
      required this.verificationData,
      required this.isAcknowledged});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageName'] = packageName;
    data['productId'] = productId;
    data['transactionId'] = transactionId;
    data['purchaseToken'] = purchaseToken;
/*
    data['originalTransactionId'] = this.originalTransactionId;
*/
/*
    data['purchaseDate'] = this.purchaseDate;
*/
    data['status'] = status;
    data['verificationData'] = verificationData.toJson();
  /*
    data['purchaseDate'] = this.purchaseDate;
*/
    data['isPending'] = isPending;
    data['isAcknowledged'] = isAcknowledged;
    return data;
  }
}

class VerificationData {
  String source;
  String receiptData;

  VerificationData({required this.source, required this.receiptData});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source'] = source;
    data['receiptData'] = receiptData;
    return data;
  }
}
