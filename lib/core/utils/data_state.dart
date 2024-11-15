class DataState<T> {
  final Status status;
  final T? body;
  final String? message;

  const DataState.loading()
      : status = Status.loading,
        body = null,
        message = null;
  const DataState.completed(this.body)
      : status = Status.completed,
        message = '';

  const DataState.error(this.message)
      : status = Status.error,
        body = null;
}

enum Status { loading, completed, error }
