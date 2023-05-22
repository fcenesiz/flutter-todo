
class Todo{

  late int id;
  String content;
  int done;

  Todo(this.content, this.done);
  Todo.withId({required this.id, required this.content, this.done = 0});

  Map<String, dynamic> toMap({bool withId = false}){
    if(withId){
      return {
        "id" : id,
        "content" : content,
        "done" : done
      };
    }
    return {
      "content" : content,
      "done" : done
    };
  }

  @override
  String toString() {
    return "Todo(id:$id, content:$content, done:$done)";
  }

}