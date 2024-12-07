class FailureEntity {
  final String? code;
  final String? message;

  FailureEntity({
    this.code,
    this.message,
  });
}

class FetchFailure extends FailureEntity {
  FetchFailure()
      : super(code: '500', message: 'Có lỗi xảy ra. Vui lòng thử lại sau.');
}
