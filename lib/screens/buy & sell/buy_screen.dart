import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scrollable_text_indicator/scrollable_text_indicator.dart';
import 'package:smartfunding/bloc/auth/401handel/handel_unauth_bloc.dart';
import 'package:smartfunding/bloc/auth/401handel/handel_unauth_event.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_bloc.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_event.dart';
import 'package:smartfunding/bloc/profile/profile_event.dart';
import 'package:smartfunding/bloc/profile/profile_state.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/screens/wallet_screen/widget/track_deposit.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/success_snack.dart';
import 'package:smartfunding/utils/terms&conditions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/pament_bloc/payment_state.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../utils/cache_image.dart';
import '../../utils/money_seprator_ir.dart';

class BuyScreen extends StatefulWidget {
  final Project _project;
  const BuyScreen(this._project, {super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _isKeyboardVisible = false;
  int _currentPage = 0;
  PageController _pageController = PageController();
  final TextEditingController _priceController = TextEditingController();
  bool isChecked = false;
  bool isPublic = true;
  bool _checkedWallet = false;
  bool showListTile = false;
  final String contractUrl = "https://smartfunding.ir/risk/";
  final String termsUrl = "https://smartfunding.ir/terms/";
  String? projectContractUrl; // Example URL

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProfileBloc>(context).add(ProfileStartEvent());
    BlocProvider.of<HandelBloc>(context).add(HandelStartEvent());

    if (widget._project.contract != null) {
      projectContractUrl = widget._project.contract!.originalUrl;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showTermsAndConditionsDialog(BuildContext context) {
    // Variable to track if the full text is displayed
    bool showFullText = false;
    ScrollController scrollController = ScrollController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.white,
            alignment: Alignment.center,
            surfaceTintColor: Colors.white,
            actionsAlignment: MainAxisAlignment.spaceAround,
            insetPadding:
                const EdgeInsets.symmetric(vertical: 150, horizontal: 20),
            title: Row(
              children: [
                const Icon(
                  Icons.gavel,
                  size: 35,
                  color: Color(0xff9496c1),
                ),
                const SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بیانیه ریسک',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
            content: ScrollableTextIndicator(
              indicatorBarWidth: 0.3,
              indicatorBarColor: Colors.grey,
              indicatorThumbColor: AppColorScheme.primaryColor,
              indicatorSpacing: 2,
              text: Text(
                termsAndConditions,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                    fontFamily: 'IR',
                    wordSpacing: 1,
                    height: 1.8),
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(
                      width: 0.5, color: AppColorScheme.primaryColor),
                  fixedSize: const Size(100, 40),
                  textStyle: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Perform action on decline
                  setState(() {
                    isChecked = false; // Update isChecked if declined
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'رد',
                  style: TextStyle(
                      color: AppColorScheme.primaryColor,
                      fontFamily: 'IR',
                      fontSize: 12),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(
                      width: 0.5, color: AppColorScheme.primaryColor),
                  backgroundColor: AppColorScheme.primaryColor,
                  fixedSize: const Size(100, 40),
                  textStyle: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Perform action on accept
                  setState(() {
                    isChecked = true; // Update isChecked if accepted
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'پذیرش',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'IR', fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int monthsDifference = widget._project.calculateMonthDifference();
    //_isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentResponseState) {
          state.goToPayment.fold((l) {
            showErrorSnackBar(context, l);
          }, (paymentUrl) async {
            final Uri url = Uri.parse(paymentUrl);
            await launchUrl(url, mode: LaunchMode.externalApplication);
          });
        }
        if (state is WalletResponseState) {
          state.walletPaid.fold(
            (l) {
              showErrorSnackBar(context, l);
            },
            (r) {
              showSuccessSnackBar(context, r);
              return Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColorScheme.scafoldCollor,
        appBar: AppBar(
          title: Text(
            'خرید طرح',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            // height: 700,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColorScheme.primaryColor,
                    ),
                  );
                }
                if (state is ProfileResponseState) {
                  return state.getProfile.fold((l) => Text(l), (r) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        widget._project.images != ''
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: 300,
                                      child: PageView.builder(
                                        pageSnapping: true,
                                        itemCount:
                                            widget._project.images!.length,
                                        controller: _pageController,
                                        allowImplicitScrolling: true,
                                        onPageChanged: (index) {
                                          // Update the current page when the user swipes
                                          setState(() {
                                            _currentPage = index;
                                          });
                                        },
                                        itemBuilder: (context, index) {
                                          return CachedImage(
                                            imageUrl: widget._project
                                                .images![index].originalUrl,
                                            topLeftradious: 5,
                                            topRightradious: 5,
                                            bottomLeftradious: 5,
                                            bottomRightradious: 5,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SmoothPageIndicator(
                                      controller: _pageController,
                                      onDotClicked: (index) {
                                        _pageController.animateToPage(
                                          index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      count: widget._project.images!.length,
                                      effect: const WormEffect(
                                        dotHeight: 10,
                                        dotWidth: 10,
                                        type: WormType.thin,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    child: Image.asset(
                                      "assets/images/placeholder.png",
                                      width: 450,
                                      height: 250,
                                    ),
                                  ),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('درصد',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    widget._project.expectedProfit!
                                        .toPersianDigit(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                              Text(
                                'پیش بینی سود سالیانه',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 0.4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'تومان',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    widget._project.minInvest!
                                        .toString()
                                        .toPersianDigit()
                                        .seRagham(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                              Text("حداقل مبلغ سرمایه گذاری",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall
                                  //textAlign: TextAlign.left,
                                  ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 0.4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'ماه',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    '12'.toPersianDigit(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                              Text("دوره سرمایه گذاری",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall
                                  //textAlign: TextAlign.left,
                                  ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 0.4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('درصد',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                      widget._project
                                          .expectedInMounth()
                                          .toPersianDigit(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                ],
                              ),
                              Text("نرخ بازدهی داخلی ماهانه",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      showListTile = true;
                                    });
                                  }
                                  if (value.isEmpty) {
                                    setState(() {
                                      showListTile = false;
                                    });
                                  }
                                },
                                style: const TextStyle(
                                  fontFamily: 'IR',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [PersianNumberFormatter()],
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.symmetric(horizontal: 40.0),

                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons
                                        .clear), // Change the icon as needed
                                    onPressed: () {
                                      _priceController
                                          .clear(); // Clears the text field
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: 'مبلغ سرمایه گذاری (تومان)',
                                  errorStyle: const TextStyle(
                                    fontFamily: 'IR',
                                    fontSize: 10,
                                    color: Colors.red,
                                  ),
                                  labelStyle:
                                      Theme.of(context).textTheme.headlineSmall,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'لطفا مبلغ سرمایه گذاری را وراد کنید';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('اسم من را به سایرین نمایش بده',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                    value: isPublic,
                                    side:
                                        const BorderSide(color: Colors.black54),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    onChanged: (value) {
                                      setState(() {
                                        isPublic = value!;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: 'بیانیه ریسک',
                                        style: TextStyle(
                                          fontFamily: 'IR',
                                          fontSize: 10,
                                          color: AppColorScheme.primaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launch(contractUrl);
                                          },
                                      ),
                                      TextSpan(
                                          text: '، ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      TextSpan(
                                        text: 'شرایط و قوانین',
                                        style: const TextStyle(
                                          fontFamily: 'IR',
                                          fontSize: 10,
                                          color: AppColorScheme.primaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launch(termsUrl);
                                          },
                                      ),
                                      projectContractUrl != null
                                          ? TextSpan(
                                              text: ' و ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )
                                          : TextSpan(),
                                      projectContractUrl != null
                                          ? TextSpan(
                                              text: 'قرارداد سرمایه گذاری',
                                              style: const TextStyle(
                                                fontFamily: 'IR',
                                                fontSize: 10,
                                                color:
                                                    AppColorScheme.primaryColor,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  launch(projectContractUrl!);
                                                },
                                            )
                                          : TextSpan(),
                                      TextSpan(
                                          text: ' را خواندم و می پذیرم',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                    ],
                                  ),
                                ),
                              ),
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  value: isChecked,
                                  side: const BorderSide(color: Colors.black54),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  onChanged: (value) {
                                    _showTermsAndConditionsDialog(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: BlocBuilder<PaymentBloc, PaymentState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (isChecked) {
                                      var price = _priceController.text
                                          .replaceAll(',', '')
                                          .toEnglishDigit();
                                      if (int.parse(price) > 200000000) {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          useSafeArea: true,
                                          context: context,
                                          isDismissible: false,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10))),
                                          builder: (context) {
                                            return SizedBox(
                                              height: 150,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    PhosphorIcon(
                                                      PhosphorIcons.warning(),
                                                      color: AppColorScheme
                                                          .primaryColor,
                                                    ),
                                                    const Text(
                                                        'برای مبالغ بالا دویست میلیون تومان باید فیش واریزی ارسال کنید.'),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            side: const BorderSide(
                                                                width: 0.5,
                                                                color: AppColorScheme
                                                                    .primaryColor),
                                                            fixedSize:
                                                                const Size(
                                                                    100, 40),
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'رد',
                                                            style: TextStyle(
                                                                color: AppColorScheme
                                                                    .primaryColor,
                                                                fontFamily:
                                                                    'IR',
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            side: const BorderSide(
                                                                width: 0.5,
                                                                color: AppColorScheme
                                                                    .primaryColor),
                                                            backgroundColor:
                                                                AppColorScheme
                                                                    .primaryColor,
                                                            fixedSize:
                                                                const Size(
                                                                    100, 40),
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return BlocProvider(
                                                                create: (context) =>
                                                                    PaymentBloc(),
                                                                child:
                                                                    TrackDposit(
                                                                  r,
                                                                  widget
                                                                      ._project
                                                                      .id!,
                                                                  price:
                                                                      _priceController
                                                                          .text,
                                                                ),
                                                              );
                                                            }));
                                                          },
                                                          child: const Text(
                                                            'انتقال',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'IR',
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        var price = _priceController.text
                                            .replaceAll(',', '')
                                            .toEnglishDigit();

                                        //show dialog
                                        BlocProvider.of<PaymentBloc>(context)
                                            .add(
                                          PaymentButtonClikedEvent(
                                            widget._project.id!,
                                            price,
                                            _checkedWallet,
                                            isPublic,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isChecked
                                      ? AppColorScheme.primaryColor
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    50,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state is PaymentLoadingState) ...{
                                      const CircularProgressIndicator(
                                        strokeWidth: 0.6,
                                        color: Colors.white,
                                        strokeCap: StrokeCap.round,
                                        strokeAlign: 3,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'انتقال به درگاه',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      )
                                    } else ...{
                                      Text(
                                        'ادامه',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      )
                                    }
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (isChecked &&
                                _formKey.currentState!.validate()) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return BlocProvider(
                                  create: (context) => PaymentBloc(),
                                  child: TrackDposit(
                                    r,
                                    widget._project.id!,
                                    price: _priceController.text,
                                  ),
                                );
                              }));
                            } else {
                              null;
                            }
                          },
                          child: Text(
                            'پرداخت از طریق ثبت فیش واریزی',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: isChecked
                                        ? AppColorScheme.primaryColor
                                        : Colors.grey),
                          ),
                        )
                      ],
                    );
                  });
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
