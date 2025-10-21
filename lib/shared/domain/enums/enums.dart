enum DeviceTypeEnum {
  mobile,
  tablet,
  desktop,
}

enum ToastTypeEnum { success, error, info }

enum StateCheckerEnum { loading, done, failed, initial }

enum ResultTypeEnum {
  success('success'),
  error('error'),
  validationError('validation-error'),
  unAuthenticated('unAuthenticated');

  const ResultTypeEnum(this.value);

  final String value;
}
