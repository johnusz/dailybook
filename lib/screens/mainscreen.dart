import 'package:dailybook/blocs/api/weather_bloc.dart';
import 'package:dailybook/blocs/api/news_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dailybook/screens/auxilary/newswebview.dart';
import 'package:dailybook/screens/auxilary/columnbuilder.dart';
import 'package:dailybook/blocs/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? urltoNews;
  String? titleofNews;

  inform() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YourWebView(urltoNews!, titleofNews!),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FractionallySizedBox(
            widthFactor: 0.95,
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ),
                Spacer()
              ],
            )),
        Expanded(
            child: RefreshIndicator(
              color: Colors.orange,
              onRefresh: () async{
                  BlocProvider.of<WeatherBloc>(context).add(InitWeatherEvent());
                  BlocProvider.of<NewsBloc>(context).add(InitNewsEvent());
              },
              child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upcoming",
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                          if (state is TodoLoadedState) {
                            if (state.tasks.length <= 3){
                              return ColumnBuilder(
                                  itemBuilder: (_, index) => (() {
                                    if (state.tasks[index].dateDue
                                        .isAfter(DateTime.now())) {
                                      return FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Card(
                                            color: HexColor.fromHex(state.tasks[index].color),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.tasks[index].title,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w700)),
                                                  Text(
                                                    state.tasks[index]
                                                        .description,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "Due Date: ${DateFormat('dd-MM-yyyy').format(state.tasks[index].dateDue)}",
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
                                      );
                                    }
                                    return const SizedBox(width: 0, height: 0,);
                                  }()),
                                  itemCount: state.tasks.length);
                            } else {
                              return ColumnBuilder(
                                  itemBuilder: (_, index) => (() {
                                    if (state.tasks[index].dateDue
                                        .isAfter(DateTime.now())) {
                                      return FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Card(
                                            color: HexColor.fromHex(state.tasks[index].color),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.tasks[index].title,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w700)),
                                                  Text(
                                                    state.tasks[index]
                                                        .description,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "Due Date: ${DateFormat('dd-MM-yyyy').format(state.tasks[index].dateDue)}",
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
                                      );
                                    }
                                    return const SizedBox(width: 0, height: 0,);
                                  }()),
                                  itemCount: 3);
                            }

                          } else {
                            return const Text("No Tasks To Do");
                          }
                        }),
                        SizedBox(height: 8),
                      ]),
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Weather",
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state){
                          if (state is InitWeatherState) {
                            var listofweather = state.weather.main;
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Weather In ${state.weather.name}, ${state.weather.sys!.country}"),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              'http://openweathermap.org/img/wn/${state.weather.weather![0].icon}@2x.png',
                                              width: 56,
                                            ),
                                            Text(
                                                "${state.weather.weather![0].main}")
                                          ],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${((listofweather?.temp)! - 273).toStringAsFixed(1)} °C / ${((((listofweather?.temp)! - 273) * 1.8) + 32).toStringAsFixed(1)} °F",
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Feels Like: ${((listofweather?.feelsLike)! - 273).toStringAsFixed(1)} °C / ${((((listofweather?.feelsLike)! - 273) * 1.8) + 32).toStringAsFixed(1)} °F",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Min: ${((listofweather?.tempMin)! - 273).toStringAsFixed(1)} °C / ${((((listofweather?.tempMin)! - 273) * 1.8) + 32).toStringAsFixed(1)} °F",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "Max: ${((listofweather?.tempMax)! - 273).toStringAsFixed(1)} °C / ${((((listofweather?.tempMax)! - 273) * 1.8) + 32).toStringAsFixed(1)} °F",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "Humidity: ${(listofweather?.humidity)}%",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Pressure: ${(listofweather?.pressure)} hPa",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "Wind Speed: ${(state.weather.wind!.speed)} m/s",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "Wind Direction: ${state.weather.wind!.deg}°",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            );
                          }
                        }  )
                      ]),
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "News",
                        maxLines: 1,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
                        if (state is InitNewsState) {
                          var listofnews = state.articles.articles;
                          return ColumnBuilder(
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    urltoNews = listofnews[index].url;
                                    titleofNews = listofnews[index].title;
                                    inform();
                                  });
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(children: <Widget>[
                                          if (listofnews[index].image !=
                                              null) ...[
                                            Image.network(
                                              listofnews[index].image!,
                                              width: 96,
                                              errorBuilder: (BuildContext
                                              context,
                                                  Object exception,
                                                  StackTrace? stackTrace) {
                                                return SizedBox(
                                                    width: 96,
                                                    child: Center(
                                                        child: const Icon(
                                                            Icons.error)));
                                              },
                                            ),
                                          ] else ...[
                                            SizedBox(
                                                width: 96,
                                                child: Icon(
                                                    Icons.question_mark))
                                          ],
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              listofnews[index].title ??
                                                  "This Article has no title",
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(height: 10),
                                        Text(
                                          listofnews[index].description ??
                                              "This article doesn't contain description",
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: state.articles.articles.length);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                )
              ],
          ),
        ),
            ))
      ],
    );
  }
}
