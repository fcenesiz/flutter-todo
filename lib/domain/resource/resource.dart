sealed class Resource<Type>{
  final Type? data;
  Resource(this.data);
}

class Success<Type> extends Resource<Type>{
  final Type data;
  Success(this.data) : super(data);
}

class Failure<Type> extends Resource<Type>{
  final String msg;
  Failure(this.msg) : super(null);
}

String toString(Resource resource) => switch(resource){
  Success _ => resource.data.toString(),
  Failure _ => resource.msg.toString()
};

String toTypeString(Resource resource) => switch(resource){
  Success _ => "Success",
  Failure _ => "Failure"
};