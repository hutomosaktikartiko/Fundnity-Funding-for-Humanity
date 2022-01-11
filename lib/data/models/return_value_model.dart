/// The type value is [Generic Type]
/// 
/// isSuccess default is [false]
class ReturnValueModel<T> {
  bool isSuccess;
  T? value;
  String? message;

  ReturnValueModel({
    this.value,
    this.isSuccess = false,
    this.message,
  });
}