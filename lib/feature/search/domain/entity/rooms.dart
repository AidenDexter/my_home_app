enum Rooms {
  one(id: 1, title: '1'),
  two(id: 2, title: '2'),
  three(id: 3, title: '3'),
  four(id: 4, title: '4'),
  five(id: 5, title: '5'),
  six(id: 7, title: '6'),
  seven(id: 8, title: '7'),
  eight(id: 9, title: '8'),
  nine(id: 10, title: '9'),
  tenOlus(id: 11, title: '10+');

  final int id;
  final String title;
  const Rooms({required this.id, required this.title});
}

enum BedRooms {
  one(id: 1, title: '1'),
  two(id: 2, title: '2'),
  three(id: 3, title: '3'),
  four(id: 4, title: '4'),
  five(id: 5, title: '5'),
  six(id: 6, title: '6'),
  seven(id: 7, title: '7'),
  eight(id: 8, title: '8'),
  nine(id: 9, title: '9'),
  tenOlus(id: 10, title: '10+');

  final int id;
  final String title;
  const BedRooms({required this.id, required this.title});
}
