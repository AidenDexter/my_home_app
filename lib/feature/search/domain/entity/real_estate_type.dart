enum RealEstateType {
  apartments(
    id: 1,
    title: 'Квартиры',
    filters: ['floor', 'rooms'],
  ),
  houses(
    id: 2,
    title: 'Дома',
    filters: ['rooms'],
  ),
  countryHouses(
    id: 3,
    title: 'Дачи',
    filters: ['rooms'],
  ),
  landPlots(
    id: 4,
    title: 'Земля',
    filters: [],
  ),
  commercial(
    id: 5,
    title: 'Коммерческая',
    filters: ['floor', 'rooms'],
  ),
  hotels(
    id: 6,
    title: 'Гостиницы',
    filters: ['floor', 'rooms'],
  ),
  ;

  final int id;
  final String title;
  final List<String> filters;

  const RealEstateType({
    required this.id,
    required this.title,
    required this.filters,
  });
}
