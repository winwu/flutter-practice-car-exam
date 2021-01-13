/*
 * @TBD
 * so far no need to extract these options.
 * */

class OptionItem {
  final String id;
  final String text;

  OptionItem(this.id, this.text);

  OptionItem.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        text = map['text'];
}