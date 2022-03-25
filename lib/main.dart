import 'package:dailybook/blocs/api/news_bloc.dart';
import 'package:dailybook/blocs/api/weather_bloc.dart';
import 'package:dailybook/blocs/note_bloc.dart';
import 'package:dailybook/blocs/todo_bloc.dart';
import 'package:dailybook/screens/mainscreen.dart';
import 'package:dailybook/screens/noteslist.dart';
import 'package:dailybook/services/apiservice.dart';
import 'package:dailybook/services/notesservice.dart';
import 'package:dailybook/services/taskservice.dart';
import 'package:flutter/material.dart';
import 'package:dailybook/screens/todoslist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}


void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TasksService()),
        RepositoryProvider(create: (context) => NotesService()),
        RepositoryProvider(create: (context) => WeatherService()),
        RepositoryProvider(create: (context) => NewsService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(lazy: false, create: (context) => TodoBloc(RepositoryProvider.of<TasksService>(context))..add(InitTodoEvent())),
          BlocProvider<NoteBloc>(lazy: false, create: (context) => NoteBloc(RepositoryProvider.of<NotesService>(context))..add(InitNoteEvent())),
          BlocProvider<WeatherBloc>(lazy: false, create: (context) => WeatherBloc(RepositoryProvider.of<WeatherService>(context))..add(InitWeatherEvent())),
          BlocProvider<NewsBloc>(lazy: false, create: (context) => NewsBloc(RepositoryProvider.of<NewsService>(context))..add(InitNewsEvent())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.dark,),
            home: Todos()
        ),
      ),
    );
  }
}

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TodoList(),
    NoteList(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(child: _widgetOptions.elementAt(_selectedIndex))
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered_rounded),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
