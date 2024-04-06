class Todo {
  String? id;
  String name;
  bool isCompleted;
  Todo({required this.id, required this.name, this.isCompleted = false});


  // array of Todo Objects
  static List<Todo> todoList() {
    return [
      Todo(
        id: '1',
        name: 'Go to Gym',
        isCompleted: false,
      ),
      Todo(
        id: '2',
        name: 'Library time',
        isCompleted: true,
      ),
    ];
  }
}
