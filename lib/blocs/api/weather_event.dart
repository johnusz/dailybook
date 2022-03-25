part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class InitWeatherEvent extends WeatherEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}