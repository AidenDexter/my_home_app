enum RealEstateType {
  apartments(
    id: 1,
    title: 'Квартиры',
    filters: ['floor'],
  ),
  houses(
    id: 2,
    title: 'Дома',
    filters: [],
  ),
  countryHouses(
    id: 3,
    title: 'Дачи',
    filters: [],
  ),
  landPlots(
    id: 4,
    title: 'Земля',
    filters: [],
  ),
  commercial(
    id: 5,
    title: 'Коммерческая',
    filters: ['floor'],
  ),
  hotels(
    id: 6,
    title: 'Гостиницы',
    filters: ['floor'],
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
