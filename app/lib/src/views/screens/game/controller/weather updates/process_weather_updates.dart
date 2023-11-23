import 'package:app/src/core/entities/game/weather/temperature%20updates/weather_temperature_subscriber.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';

class ProcessWeatherUpdates implements WeatherTemperatureSubscriber {
  ProcessWeatherUpdates({required this.presenter});
  IGamePresenter presenter;

  @override
  void onWeatherUpdate(Temperature temperature) {
    presenter.setGameTemperature(temperature.temperatureF);
  }
}
