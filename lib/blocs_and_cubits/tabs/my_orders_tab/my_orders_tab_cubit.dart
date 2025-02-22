import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zimozi_store/models/orders/my_orders_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_orders_service.dart';

part 'my_orders_tab_state.dart';

class MyOrdersTabCubit extends Cubit<MyOrdersTabState> {
  MyOrdersTabCubit() : super(MyOrdersTabInitialState());

  List<MyOrdersModel> allOrders = [];

  Future<void> getAllOrders() async {
    emit(MyOrdersTabLoadingState());
    allOrders = await FirebaseOrderService.getAllOrders();
    if (allOrders.isEmpty) {
      emit(MyOrdersTabEmptyState(message: "No orders found!"));
    } else {
      emit(MyOrdersTabLoadedState());
    }
  }
}
