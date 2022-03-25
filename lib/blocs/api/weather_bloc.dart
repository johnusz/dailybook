import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dailybook/models/weather_model.dart';
import 'package:dailybook/services/apiservice.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;
  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<InitWeatherEvent>((event, emit) async{
      final weather = await weatherService.fetchWeather();
      emit(InitWeatherState(weather));
    });
  }

}
