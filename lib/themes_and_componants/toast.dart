import 'package:toast/toast.dart';

ToastContext toastContext=ToastContext();
void initToast(context){
  toastContext.init(context);
}

void showToast(String msg, {int duration=1, int? gravity}) {
  Toast.show(msg, duration: duration, gravity: gravity);
}