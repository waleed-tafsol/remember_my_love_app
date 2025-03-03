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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageName'] = this.packageName;
    data['productId'] = this.productId;
    data['transactionId'] = this.transactionId;
    data['purchaseToken'] = this.purchaseToken;
/*
    data['originalTransactionId'] = this.originalTransactionId;
*/
/*
    data['purchaseDate'] = this.purchaseDate;
*/
    data['status'] = this.status;
    if (this.verificationData != null) {
      data['verificationData'] = this.verificationData!.toJson();
    }
/*
    data['purchaseDate'] = this.purchaseDate;
*/
    data['isPending'] = this.isPending;
    data['isAcknowledged'] = this.isAcknowledged;
    return data;
  }
}

class VerificationData {
  String source;
  String receiptData;

  VerificationData({required this.source, required this.receiptData});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['receiptData'] = this.receiptData;
    return data;
  }
}
