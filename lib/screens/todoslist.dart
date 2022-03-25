import 'package:dailybook/blocs/todo_bloc.dart';
import 'package:dailybook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dailybook/screens/auxilary/columnbuilder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  inform() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateNewTask(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
            widthFactor: 0.95,
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "To Do",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      inform();
                    }, child: const Text("+"), style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                        )
                    )),
                    )
                  ],
                ),
                SizedBox(height: 4,)
              ],
            )
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListOfTodos(),
          ),
        )
      ],
    );
  }
}

class ListOfTodos extends StatelessWidget {
  const ListOfTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      if (state is TodoLoadedState) {
        return ColumnBuilder(
            itemBuilder: (_, index) => GestureDetector(
              onLongPress: (){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text('Are You Sure To Delete This Task?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){
                          BlocProvider.of<TodoBloc>(context).add(RemoveTodoEvent(state.tasks[index].dateAdded));
                          Navigator.pop(context, 'Delete');},
                        child: const Text('Delete'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
              child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Card(
                        color: HexColor.fromHex(state.tasks[index].color),
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.tasks[index].title, maxLines: 1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                          Text(state.tasks[index].description, maxLines: 2, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                          SizedBox(height: 6,),
                          Text("Due Date: ${DateFormat('dd-MM-yyyy').format(state.tasks[index].dateDue)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200, fontStyle: FontStyle.italic),)
                        ],
                      ),
                    )),
                  ),
            ),
            itemCount: state.tasks.length);
      } else {
        return const Text("No Tasks To Do");
      }
    });
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _input1 = TextEditingController();
  final _input2 = TextEditingController();
  String textInputTitlePreview = "";
  String  textInputDescPreview= "";
  DateTime selectedDate = DateTime.now();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }


  void pickColor(BuildContext context) => showDialog(context: context, builder: (context) =>
      AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          )
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
  );

   _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    setState(() {
      if (selected != null && selected != selectedDate)
        selectedDate = selected;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create A New Task"), backgroundColor: Colors.grey[900],),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius:  BorderRadius.circular(32),
                  ),
                  child: TextField(
                    maxLines: 1,
                    controller: _input1,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Task Title',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onChanged: (text)=> setState(() {
                      textInputTitlePreview = text;
                    }),
                  ),
                ),
                SizedBox(height: 12,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius:  BorderRadius.circular(32),
                  ),
                  child: TextField(
                    maxLines: 2,
                    controller: _input2,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Task Description',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onChanged: (text)=> setState(() {
                      textInputDescPreview = text;
                    }),
                  ),
                ),
              SizedBox(height: 12,),
              Row(
                children: [
                  Text("Pick a Color"),
                  SizedBox(width: 32),
                  GestureDetector(child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: currentColor), height: 48, width: 48,), onTap: (){
                    setState(() {
                      pickColor(context);
                    });
                  },),
                ],
              ),
              SizedBox(height: 8,),
              Row(children: [
                Text("Select Due Date"),
                SizedBox(width: 16,),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _selectDate(context);
                  });
                }, child: Text("Select Date"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                    )),
                )
              ],),
              SizedBox(height: 24,),
              Row(
                children: [
                  Text("Preview"),
                ],
              ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Card(
                      color: currentColor,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(_input1.text,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight.w700)),
                            Text(
                              _input2.text,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Due Date: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w200,
                                  fontStyle:
                                  FontStyle.italic),
                            )
                          ],
                        ),
                      )),
                ),
              SizedBox(height: 6,),
                ElevatedButton(onPressed: (){
                  BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(textInputTitlePreview, textInputDescPreview, selectedDate, currentColor.toHex()));
                  Navigator.of(context).pop();
                }, child: Text("Save Task"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                    )),
                )
            ],

            ),
          ),
        ),
      ),
    );
  }
}

