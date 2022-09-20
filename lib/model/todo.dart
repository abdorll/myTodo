class ToDo {
  String? id;
  String? todoText;
  String? description;
  bool isCopleted;
  String? icon;
  ToDo({
    required this.id,
    required this.todoText,
    this.description = '',
    this.icon = '',
    this.isCopleted = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Excercise', isCopleted: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isCopleted: true),
      ToDo(
        id: '03',
        todoText: 'Check Emails',
      ),
      ToDo(
        id: '04',
        todoText: 'Team Meeting',
      ),
      ToDo(
        id: '05',
        todoText: 'Work on mobile apps for 2 hour',
      ),
      ToDo(
        id: '06',
        todoText: 'Dinner with Jenny',
      ),
    ];
  }
}
