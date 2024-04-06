import 'package:flutter/material.dart';
import 'package:todo/colors/colors.dart';
import '../modal/todo.dart';
class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onDelete;
  const TodoItem({Key? key, required this.todo, required this.onTodoChanged, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double deviceWidth = MediaQuery.of(context).size.width;
          double deviceHeight = MediaQuery.of(context).size.height;

          double containerHeight = deviceHeight * 0.1; // 10% of device height
          double fontSize = deviceWidth * 0.05; // 5% of device width

          return Container(
            height: containerHeight,
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
            margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.01),
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
            child: Center(
              child: ListTile(
                onTap: (){
                  onTodoChanged(todo);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                leading: Icon(
                  color: successColor,
                  todo.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                ),
                title: Text(
                  todo!.name,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    decoration: todo!.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  onPressed: (){
                    onDelete(todo.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: warningColor,
                  ),
                ),
              ),
            ),
          );
        }
    );

  }
}
