import 'package:flutter/material.dart' show BuildContext;

import '../../../../core/extension/src/app_localizations_x.dart';

enum DealType {
  sale(id: 1),
  rent(id: 2),
  leaseholdMortgate(id: 3),
  dailyRent(id: 7),
  ;

  final int id;
  const DealType({required this.id});

  String toLocalizeString(BuildContext context) {
    switch (this) {
      case sale:
        return context.l10n.for_sale;
      case rent:
        return context.l10n.for_rent;
      case leaseholdMortgate:
        return context.l10n.leasehold_mortgage;
      case dailyRent:
        return context.l10n.daily_rent;
    }
  }
}
