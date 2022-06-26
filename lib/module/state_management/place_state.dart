import 'package:mobx/mobx.dart';
import 'package:tour/data/model/place_model.dart';

part 'place_state.g.dart';

class Places = _Places with _$Places;

abstract class _Places with Store {
  @observable
  ObservableList<PlaceModel> places = ObservableList<PlaceModel>();

  @action
  void addFavouritePlace(PlaceModel place) {
    places.add(place);
  }

  @action
  void removeFavouritePlace(PlaceModel place) {
    places.removeWhere((x) => x == place);
  }
}
