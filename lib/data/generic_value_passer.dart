class GenericValuePasser {
  String? valueString;
  Object? valueObject;
  List<Object>? valueObjectList;
  bool? valueBool;

  GenericValuePasser(
      {this.valueString,
      this.valueObject,
      this.valueObjectList,
      this.valueBool});

  String? get getString => this.valueString;
  bool? get getBool => valueBool;
  Object? get getObject => valueObject;
  List<Object>? get getObjectList => valueObjectList;
}
