import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/controllers/text_editing_controller.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/order/place_order/category_screen.dart';
import 'package:insta_king/presentation/views/order/place_order/dropdown_model.dart';
import 'package:insta_king/presentation/views/order/place_order/service_screen.dart';
import 'package:insta_king/presentation/views/order/place_order/widget.dart';
import 'package:insta_king/presentation/views/shared_widgets/mini_tags.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class PlaceOrder extends ConsumerStatefulWidget {
  const PlaceOrder({super.key});

  @override
  ConsumerState createState() => PlaceOrderState();
}

class PlaceOrderState extends ConsumerState<PlaceOrder> {
  late TextEditingController linkController = TextEditingController();

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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ));
                    },
                    child: buildLoadingContainer(
                      categoriesController.isCatSet
                          ? categoriesController.selectedCategoryName
                          : 'Choose Category',
                      'Category',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ServiceScreen(),
                      ));
                    },
                    child: buildLoadingContainer(
                      categoriesController.isServiceSet
                          ? categoriesController.selectedServiceName
                          : 'Choose Service',
                      'Services',
                    ),
                  ),
                  CollectPersonalDetailModel(
                    leadTitle: "Link",
                    hintT: 'https://link-to-your-social',
                    isPasswordT: false,
                    controller: linkController,
                  ),
                  CollectPersonalDetailModel(
                    leadTitle: "Quantity",
                    hintT: '1',
                    isPasswordT: false,
                    controller: quantityController,
                    isdigit: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      textValueNotifier.textValue = value;
                    },
                  ),
                  Column(
                    children: [
                      MiniTags(
                        textOnTag: 'Min ${formatBalance(
                          categoriesController
                                  .getOneServiceDetailsModel.data?.min
                                  .toString() ??
                              '',
                          noShowNaira: true,
                        )} - Max ${formatBalance(
                          categoriesController
                                  .getOneServiceDetailsModel.data?.max
                                  .toString() ??
                              '',
                          noShowNaira: true,
                        )}',
                      ),
                      MiniTags(
                        textOnTag:
                            'Per 1k - ${formatBalance(categoriesController.getOneServiceDetailsModel.data?.price.toString() ?? '')}',
                      ),
                      MiniTags(
                        textOnTag:
                            'TOTAL: ${formatBalance(categoriesController.calculatePricePerUnit(categoriesController.getOneServiceDetailsModel.data?.price ?? '0.0', ref.watch(textValueProvider).textValue))}',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  noticeBoard(context)
                      .afmPadding(EdgeInsets.only(bottom: 10.sp)),
                  CustomButton(
                    pageCTA: 'Place Order',
                    toSignOrLogin: () {
                      orderController
                          .toPlaceOrder(categoriesController.selectedService,
                              linkController.text, quantityController.text)
                          .then(
                            (value) => Navigator.pop(context),
                          );
                    },
                  ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
                ],
              ).afmPadding(
                EdgeInsets.all(
                  20.sp,
                ),
              ),
            ),
          ],
        ).afmNeverScroll,
      ),
    );
  }

  late CategoriesController categoriesController =
      ref.watch(instaCategoriesController);
  late OrderController orderController =
      ref.read(instaOrderController.notifier);
  late TextEditingController quantityController =
      ref.read(textControllerProvider);
  late TextValueNotifier textValueNotifier = ref.read(textValueProvider);
}




                    // SharedDropDown(
                    //   key: GlobalKey<FormFieldState<String>>(),
                    //   future: Future.delayed(Durations.long4, () {
                    //     return categoriesController.toGetAllCategories();
                    //   }),
                    //   text: 'Choose Category',
                    //   selectedValue: selectedCategoryValue,
                    //   dropdownItems: categoryDropDownItems,
                    //   onChanged: (String? newCategoryValue) {
                    //     setState(() {
                    //       categoriesController
                    //           .setSelectedValue(newCategoryValue ?? '');
                    //       categoriesController
                    //           .toGetDropdownItemsById(newCategoryValue!);
                    //     });
                    //   },
                    // ),
                    // SharedDropDown(
                    //   key: GlobalKey<FormFieldState<String>>(),
                    //   future: Future.wait([
                    //     categoriesController.toGetAllCategories(),
                    //     categoriesController
                    //         .setSelectedValue(selectedCategoryValue),
                    //   ]),
                    //   text: 'Choose Service',
                    //   selectedValue: selectedServiceValue,
                    //   dropdownItems: servicesDropDownItems,
                    //   onChanged: (String? newServiceValue) {
                    //     setState(() {
                    //       categoriesController.setNewValue(newServiceValue);
                    //     });
                    //   },
                    // ),