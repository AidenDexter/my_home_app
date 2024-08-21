enum RealEstateType {
  apartments(id: 1, title: 'Квартиры'),
  houses(id: 2, title: 'Дома'),
  countryHouses(id: 3, title: 'Дачи'),
  landPlots(id: 4, title: 'Земля'),
  commercial(id: 5, title: 'Коммерческая'),
  hotels(id: 6, title: 'Гостиницы'),
  ;

  final int id;
  final String title;

  const RealEstateType({required this.id, required this.title});
}
