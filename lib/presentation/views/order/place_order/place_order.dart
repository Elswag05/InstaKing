import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/order/place_order/dropdown_model.dart';
import 'package:insta_king/presentation/views/shared_widgets/mini_tags.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_dropdown.dart';

class PlaceOrder extends ConsumerStatefulWidget {
  const PlaceOrder({super.key});

  @override
  ConsumerState<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends ConsumerState<PlaceOrder> {
  late final OrderController orderController = ref.watch(instaOrderController);
  late final orders =
      ref.read(instaCategoriesController.notifier).toGetAllServiceDetail();
  late final response = ref.watch(instaCategoriesController);
  late String selectedCategoryValue;
  late String selectedServiceValue;
  final GlobalKey<State<DropDownWidget>> futureServiceKey =
      GlobalKey<State<DropDownWidget>>();
  final GlobalKey<State<DropDownWidget>> futureCategoryKey =
      GlobalKey<State<DropDownWidget>>();
  late TextEditingController linkController;
  late TextEditingController quantityController;

  List<DropdownMenuItem<String>> get categoryDropDownItems {
    return response.allCategoriesModel;
  }

  List<DropdownMenuItem<String>> get servicesDropDownItems {
    return response.allServicesModel;
  }

  @override
  void initState() {
    ref.read(instaCategoriesController.notifier).toGetAllCategories();
    selectedCategoryValue = '703';
    selectedServiceValue = '9486';
    linkController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const RecurringAppBar(appBarTitle: "Place Order")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SharedDropDown(
                  key: futureCategoryKey,
                  text: 'Choose Category',
                  future: response.toGetAllCategories(),
                  selectedValue: selectedCategoryValue,
                  dropdownItems: categoryDropDownItems,
                  onChanged: (String? newCategoryValue) {
                    // response.toGetDropdownItemsById(selectedCategoryValue);
                    setState(() {
                      selectedCategoryValue = newCategoryValue!;
                      response.toGetDropdownItemsById(selectedCategoryValue);
                    });
                  },
                ),
                SharedDropDown(
                  key: futureServiceKey,
                  text: 'Choose Service',
                  future:
                      response.toGetDropdownItemsById(selectedCategoryValue),
                  selectedValue: response.selectedServiceValue,
                  dropdownItems: servicesDropDownItems,
                  onChanged: (String? newServiceValue) {
                    setState(() {
                      response.setNewValue(newServiceValue);
                      selectedServiceValue = newServiceValue!;
                    });
                  },
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Link",
                  hintT: 'https://link-to-your-social',
                  isPasswordT: true,
                ),
                CollectPersonalDetailModel(
                  leadTitle: "Quantity",
                  hintT: '1',
                  isPasswordT: true,
                  isdigit: [FilteringTextInputFormatter.digitsOnly],
                ),
                Column(
                  children: [
                    MiniTags(
                        textOnTag:
                            'Min ${formatBalance(response.getOneServiceDetailsModel.data!.min.toString())}- Max ${formatBalance(response.getOneServiceDetailsModel.data!.max.toString())}'),
                    MiniTags(
                        textOnTag:
                            'Per 1k: ${formatBalance(response.getOneServiceDetailsModel.data!.price.toString())}'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notice: ',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: InstaColors.errorColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: InstaColors.lightColor,
                        border: Border.all(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          '''1. Please make sure your page is not Private.
2. Kindly refrain from placing a second order on the same link until your initial order is completed.
3. Please be note that there may be speed changes in service delivery during periods of high demand.''',
                          style: TextStyle(
                            fontFamily: 'Montesserat',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  pageCTA: 'Place Order',
                  toSignOrLogin: () {
                    orderController.toPlaceOrder(response.selectedServiceValue,
                        linkController.text, quantityController.text);
                  },
                ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
              ],
            ).afmPadding(
              EdgeInsets.all(
                20.sp,
              ),
            ),
          ),
          // .afmGetFuture(
          //   Future.wait(
          //     [
          //       response.toGetAllCategories(),
          //       response.toGetDropdownItemsById(selectedCategoryValue),
          //     ],
          //   ),
          // ),
          Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageIcon(
                      AssetImage(
                        EnvAssets.getIconPath('bell'),
                      ),
                      size: 25.sp,
                    ).afmWrapUp.afmPadding(EdgeInsets.only(right: 10.w)),
                    Text(
                      'Announcements',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).afmPadding(EdgeInsets.only(
                  bottom: 10.h, /*left: 15.w*/
                )),
                // const OrderViews(),
                // const OrderViews(),
                // const OrderViews(),
                // const OrderViews(),
              ],
            ),
          )
              .afmBorderRadius(
                BorderRadius.circular(10.r),
              )
              .afmPadding(
                EdgeInsets.only(
                  left: 20.sp,
                  right: 20.sp,
                  bottom: 20.h,
                ),
              ),
        ],
      ).afmNeverScroll),
    );
  }
}
