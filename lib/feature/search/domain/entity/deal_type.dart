enum DealType {
  sale(id: 1, title: 'Продается'),
  rent(id: 2, title: 'В аренду'),
  leaseholdMortgate(id: 3, title: 'Ипотека под аренду'),
  dailyRent(id: 7, title: 'Посуточная аренда'),
  ;

  final int id;
  final String title;

  const DealType({required this.id, required this.title});
}
