enum ApiState { idle, loading, success, error }

extension ApiStateExt on ApiState {
  bool get isIdle => this == ApiState.idle;

  bool get isLoading => this == ApiState.loading;

  bool get isSuccess => this == ApiState.success;

  bool get isError => this == ApiState.error;
}


