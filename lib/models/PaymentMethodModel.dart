class PaymentMethodModel {
  final String id;
  final bool visibility;
  final Card card;
  final int created;
  final String customer;
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String type;
  final String? name;

  PaymentMethodModel({
    required this.id,
    required this.visibility,
    required this.card,
    required this.created,
    required this.customer,
    required this.livemode,
    required this.metadata,
    required this.type,
    required this.name,
  });

  // Factory constructor to parse the JSON
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      visibility: false,
      card: Card.fromJson(json['card']),
      created: json['created'],
      customer: json['customer'],
      livemode: json['livemode'],
      metadata: Map<String, dynamic>.from(json['metadata']),
      type: json['type'],
      name: json['billing_details']['name'],
    );
  }

  // To JSON method for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card': card.toJson(),
      'created': created,
      'customer': customer,
      'livemode': livemode,
      'metadata': metadata,
      'type': type,
    };
  }
}

class Card {
  final String brand;
  final String country;
  final String displayBrand;
  final int expMonth;
  final int expYear;
  final String last4;
  final String fingerprint;

  Card({
    required this.brand,
    required this.country,
    required this.displayBrand,
    required this.expMonth,
    required this.expYear,
    required this.last4,
    required this.fingerprint,
  });

  // Factory constructor to parse the JSON
  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      brand: json['brand'],
      country: json['country'],
      displayBrand: json['display_brand'],
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
      last4: json['last4'],
      fingerprint: json['fingerprint'],
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'country': country,
      'display_brand': displayBrand,
      'exp_month': expMonth,
      'exp_year': expYear,
      'last4': last4,
      'fingerprint': fingerprint,
    };
  }
}
