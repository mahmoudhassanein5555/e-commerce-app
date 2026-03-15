sealed class ResultApi<T> {}

class SuccessAPI<T> extends ResultApi<T> {
  SuccessAPI(this.data);
  T? data;
}

class ErrorAPI<T> extends ResultApi<T> {
  ErrorAPI(this.messageError);
  String messageError;
}
