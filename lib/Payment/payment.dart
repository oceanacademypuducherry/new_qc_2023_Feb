import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Get_X_Controller/API_Controller.dart';
import '../Get_X_Controller/UserStatusController.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _razorpay = Razorpay();
  final APIController _api = Get.find<APIController>();
  final UserStatusController userStatus = Get.find<UserStatusController>();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('success-------------------');
    print(response.orderId);
    print(response.paymentId);
    print(response.signature);
    _api.makeSubscribe(paymentId: response.paymentId);
    Get.back();

    print('success-------------------');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('failed-------------------');
    print(response.error);
    Get.back();
    print('failed-------------------');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('wallet selected-------------------');
    print(response.walletName);
    print(response);
    Get.back();
    print('wallet selected-------------------');
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  BorderRadius br = const BorderRadius.only(
      topLeft: Radius.circular(30), topRight: Radius.circular(30));

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
      fontSize: context.screenWidth / 20,
      fontWeight: FontWeight.w500,
      color: Color(0xff5F5F5F),
    );

    return Container(
      height: context.screenHeight / 1.8,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: br),
      child: Column(
        children: [
          Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Logo
                SizedBox(
                  height: context.screenWidth / 5,
                  width: context.screenWidth / 5,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(width: 20),

                /// price content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Premium', style: ts),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 4),
                              Text('₹', style: ts),
                              Spacer()
                            ],
                          ),
                          Text('3999',
                              style: ts.copyWith(
                                fontSize: context.screenWidth / 11,
                                color: Color(0xff538A85),
                              )),
                          Column(
                            children: [
                              Spacer(),
                              Text('/user', style: ts),
                              SizedBox(height: 4),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: context.screenWidth,
            child: const Divider(
              thickness: 1.5,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FeaturesLable(title: 'All Mission'),
                  const SizedBox(height: 10),
                  FeaturesLable(title: 'all Health improvements'),
                  const SizedBox(height: 10),
                  FeaturesLable(title: 'all Meditation'),
                  const SizedBox(height: 10),
                  FeaturesLable(title: 'all Breathing'),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          /// button
          GestureDetector(
            onTap: () {
              String email = userStatus.userData["email"] ?? "sample@gmail.com";
              var options = {
                'key': 'rzp_test_RS4jiFO7EVU6MY',
                'amount': 100,
                //in the smallest currency sub-unit.
                'name': 'Smoke free mind.',
                // 'order_id':
                //     'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                'description': 'Smoke free mind Premium',
                'timeout': 300,
                // in seconds
                'prefill': {
                  'contact': '',
                  'email': email,
                }
              };
              _razorpay.open(options);
            },
            child: Container(
              height: 60,
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: const Color(0xff538A85),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: const Text(
                "Unlock All features",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );

    return Center(
      child: MaterialButton(
        height: 40,
        onPressed: () {
          String email = userStatus.userData["email"] ?? "sample@gmail.com";
          var options = {
            'key': 'rzp_test_RS4jiFO7EVU6MY',
            'amount': 100,
            //in the smallest currency sub-unit.
            'name': 'Smoke free mind.',
            // 'order_id':
            //     'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
            'description': 'Smoke free mind Premium',
            'timeout': 300,
            // in seconds
            'prefill': {
              'contact': '',
              'email': email,
            }
          };
          _razorpay.open(options);
        },
        child: const Text(
          "Pay",
          style: TextStyle(color: Colors.black26, fontSize: 20),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FeaturesLable extends StatelessWidget {
  FeaturesLable({super.key, this.title = "Unlock All Features"});

  String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.done,
              color: Color(0xff538A85),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff538A85),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
