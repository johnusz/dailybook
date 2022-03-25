import 'package:dailybook/blocs/note_bloc.dart';
import 'package:dailybook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dailybook/screens/auxilary/columnbuilder.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  inform() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateNewNote(),
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
                        "Notes",
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
            child: ListOfNotes(),
          ),
        )
      ],
    );
  }
}

class ListOfNotes extends StatelessWidget {
  const ListOfNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteLoadedState) {
        return ColumnBuilder(
            itemBuilder: (_, index) => GestureDetector(
              onLongPress: (){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Delete Note'),
                    content: const Text('Are You Sure To Delete This Note?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){
                          BlocProvider.of<NoteBloc>(context).add(RemoveNoteEvent(state.notes[index].dateAdded));
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
              onDoubleTap: (){
                int idOfNote = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateNote(id: idOfNote),
                    ));
              },
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: Card(
                    color: HexColor.fromHex(state.notes[index].color),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.notes[index].title, maxLines: 1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                          Text(state.notes[index].description, maxLines: null, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                          SizedBox(height: 6,),
                        ],
                      ),
                    )),
              ),
            ),
            itemCount: state.notes.length);
      } else {
        return const Text("No Notes Saved");
      }
    });
  }
}

class CreateNewNote extends StatefulWidget {
  const CreateNewNote({Key? key}) : super(key: key);

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  final _input1 = TextEditingController();
  final _input2 = TextEditingController();
  String textInputTitlePreview = "";
  String  textInputDescPreview= "";

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
// raise the [showDialog] widget


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create A New Note"), backgroundColor: Colors.grey[900],),
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
                      hintText: 'Note Title',
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
                    maxLines: null,
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
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 6,),
                ElevatedButton(onPressed: (){
                  BlocProvider.of<NoteBloc>(context).add(AddNoteEvent(textInputTitlePreview, textInputDescPreview, DateTime.now(), currentColor.toHex()));
                  Navigator.of(context).pop();
                }, child: Text("Save Note"), style: ButtonStyle(
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



class UpdateNote extends StatefulWidget {
  const UpdateNote({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  String textInputTitlePreview = "";
  String  textInputDescPreview= "";

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
// raise the [showDialog] widget


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update a Note"), backgroundColor: Colors.grey[900],),
      body: SingleChildScrollView(
        child: BlocBuilder<NoteBloc, NoteState>( builder: (context, state) {
          if(state is NoteLoadedState){
            var id = widget.id;
            return   Center(
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
                      child: TextFormField(
                        initialValue: state.notes[id].title,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
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
                      child: TextFormField(
                        initialValue: state.notes[id].description,
                        maxLines: null,
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
                                Text(textInputTitlePreview,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight:
                                        FontWeight.w700)),
                                Text(textInputDescPreview,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: 6,),
                    ElevatedButton(onPressed: (){
                      BlocProvider.of<NoteBloc>(context).add(UpdateNoteEvent(textInputTitlePreview, textInputDescPreview, state.notes[id].dateAdded, currentColor.toHex()));
                      Navigator.of(context).pop();
                    }, child: Text("Save Note"), style: ButtonStyle(
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
            );
          } else {
            return Text("Error");
          }
        }),

        ),
      );
  }
}

