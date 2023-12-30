import 'package:travel/Models/model.dart';

List<HotPlaceModel> hotplaces = [];

void addHotPlace({required String place, required String image}) {
  hotplaces.add(HotPlaceModel(place: place, image: image));
  print(hotplaces);
}
