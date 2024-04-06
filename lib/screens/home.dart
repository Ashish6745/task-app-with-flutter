import 'package:flutter/material.dart';
import 'package:todo/colors/colors.dart';
import '../modal/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //import from todoList from todo model
  final todoList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> searchTodo = [];

  @override
  void initState() {
    searchTodo = todoList; // use the todo list in the model as default
    super.initState();
  }

  Widget build(BuildContext context) {
    // Getting the screen size for responsiveness
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      for (var todo in searchTodo)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: handleToDoChange,
                          onDelete: deleteToDoItem,
                        ),
                      SizedBox(
                          height: screenSize.height *
                              0.1), // 10% of the screen height
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.02,
                          horizontal: screenSize.width * 0.05,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: secondaryColor),
                            color: successColor),
                        child: TextField(
                          controller: _todoController,
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                          ),
                          cursorColor: primaryColor,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add new task',
                              hintStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                              )),
                          keyboardAppearance: Brightness
                              .light, // Change this to Brightness.dark for a dark keyboard
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02,
                        horizontal: screenSize.width * 0.05,
                      ),
                      child: FloatingActionButton(
                        onPressed: () {
                          //print("Add");
                          addToDoItem(_todoController.text);
                        },
                        backgroundColor: successColor,
                        child: const Icon(Icons.add),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  // handle checkbox

  void handleToDoChange(Todo todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  // handle delete button
  void deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((todo) => todo.id == id);
    });
  }

  // adding new task
  void addToDoItem(String todo) {
    setState(() {
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: todo,
      ));
    });
    _todoController.clear();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        "Todo app".toUpperCase(),
        style: const TextStyle(
          color: primaryColor,
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
        ),
      ),
      centerTitle: true,
    );
  }

  // implementing search
  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      searchTodo = results;
    });
  }

  Widget SearchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        cursorColor: successColor,
        decoration: const InputDecoration(
            border: InputBorder.none,
            iconColor: primaryColor,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: secondaryColor,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            hintStyle: TextStyle(
              color: secondaryColor,
              fontSize: 16,
            )),
      ),
    );
  }
}
