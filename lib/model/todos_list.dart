class TodoList {
  String? id, title, category, description;
  bool completedStatus;
  TodoList({
    this.id,
    this.title,
    this.description,
    this.category,
    this.completedStatus = false,
  });
}
