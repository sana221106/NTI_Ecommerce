import 'package:ecommerce/cores/Serveces/notification/notification_service.dart';
import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final Mainrepo mainrepo;
  final NotificationService notificationService;

  CartCubit({
    required this.mainrepo,
    required this.notificationService,
  }) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());

    final result = await mainrepo.getCart();

    result.fold(
      (ifLeft) {
        emit(
          CartFailure(
            errmessege: ifLeft.errmessege,
          ),
        );
      },
      (cart) {
        emit(
          CartSuccess(
            cart: cart,
          ),
        );
      },
    );
  }

  Future<void> addToCart({
    required String productId,
  }) async {
    emit(CartLoading());

    final result = await mainrepo.addToCart(
      productId: productId,
    );

    result.fold(
      (ifLeft) {
        emit(
          CartFailure(
            errmessege: ifLeft.errmessege,
          ),
        );
      },
      (cart) async {
        await notificationService.scheduleCartReminder();

        emit(
          CartSuccess(
            cart: cart,
          ),
        );
      },
    );
  }

  Future<void> updateCart({
    required String productId,
    required int count,
  }) async {
    emit(CartLoading());

    final result = await mainrepo.updateCart(
      productId: productId,
      count: count,
    );

    result.fold(
      (ifLeft) {
        emit(
          CartFailure(
            errmessege: ifLeft.errmessege,
          ),
        );
      },
      (cart) {
        emit(
          CartSuccess(
            cart: cart,
          ),
        );
      },
    );
  }

  Future<void> removeFromCart({
    required String productId,
  }) async {
    emit(CartLoading());

    final result = await mainrepo.removeFromCart(
      productId: productId,
    );

    result.fold(
      (ifLeft) {
        emit(
          CartFailure(
            errmessege: ifLeft.errmessege,
          ),
        );
      },
      (cart) {
        emit(
          CartSuccess(
            cart: cart,
          ),
        );
      },
    );
  }

  Future<void> clearCart() async {
    emit(CartLoading());

    final result = await mainrepo.clearCart();

    result.fold(
      (ifLeft) {
        emit(
          CartFailure(
            errmessege: ifLeft.errmessege,
          ),
        );
      },
      (cart) {
        emit(
          CartSuccess(
            cart: cart,
          ),
        );
      },
    );
  }
}