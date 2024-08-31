import 'package:flutter/material.dart' show BuildContext;

import '../../../../core/extension/src/app_localizations_x.dart';

enum RealEstateType {
  apartments(
    id: 1,
    filters: ['floor'],
  ),
  houses(
    id: 2,
    filters: [],
  ),
  countryHouses(
    id: 3,
    filters: [],
  ),
  landPlots(
    id: 4,
    filters: [],
  ),
  commercial(
    id: 5,
    filters: ['floor'],
  ),
  hotels(
    id: 6,
    filters: ['floor'],
  ),
  ;

  final int id;
  final List<String> filters;

  const RealEstateType({
    required this.id,
    required this.filters,
  });

  String toLocalizeString(BuildContext context) {
    switch (this) {
      case apartments:
        return context.l10n.apartments;
      case houses:
        return context.l10n.houses;
      case countryHouses:
        return context.l10n.country_houses;
      case landPlots:
        return context.l10n.land_plots;
      case commercial:
        return context.l10n.commercial;
      case hotels:
        return context.l10n.hotels;
    }
  }
}
