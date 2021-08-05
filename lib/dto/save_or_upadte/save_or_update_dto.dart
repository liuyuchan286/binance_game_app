/// id : 1

class SaveOrUpdateDto<T> {
  int id;

  Function callback;

  int index;

  String titleStr;

  T t;

  SaveOrUpdateDto({this.id, this.callback, this.index,this.titleStr,this.t});
}