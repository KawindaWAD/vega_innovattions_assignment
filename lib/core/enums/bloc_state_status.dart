enum Status { initial, loadInProgress, loadSuccess, loadFailure }

final statusValues = EnumValues({
  "initial": Status.initial,
  "loadInProgress": Status.loadInProgress,
  "loadSuccess": Status.loadSuccess,
  "loadFailure": Status.loadFailure,
});

class EnumValues<T> {
  late Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
