import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_bloc.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_event.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_state.dart';
import 'package:smartfunding/constant/color.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:intl/intl.dart' as intl;
import 'package:smartfunding/data/model/profile/responseData.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/money_seprator_ir.dart';
import 'package:smartfunding/utils/success_snack.dart';

import '../../../bloc/projects/project_bloc.dart';
import '../../dashboard_screen.dart';

class TrackDposit extends StatefulWidget {
  final ResponseData responseData;
  final int projectId;
  final String? price;
  const TrackDposit(this.responseData, this.projectId, {super.key, this.price});

  @override
  State<TrackDposit> createState() => _TrackDpositState();
}

class _TrackDpositState extends State<TrackDposit> {
  @override
  void initState() {
    BlocProvider.of<PaymentBloc>(context).add(GetDepositEvent());
    super.initState();

    priceReceiptController.text = widget.price!;
  }

  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController priceReceiptController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController tackCodeController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  XFile? pickedImage;
  final ImagePicker picker = ImagePicker();
  bool _isLoading = false;
  bool birthClick = false;
  int? year;
  int? mounth;
  int? day;

  void dispose() {
    priceReceiptController.dispose();
    dateController.dispose();
    tackCodeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true;
    });

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearImage() {
    setState(() {
      pickedImage = null;
    });
  }

  Future<String?> _showDatePickerBottomSheet(BuildContext context) async {
    String pickedDate = "";
    String formattedEndDate =
        intl.DateFormat('yyyy/MM/dd').format(DateTime.now());

    final selectedDate = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            LinearDatePicker(
              startDate: "1399/12/31",
              endDate: formattedEndDate.toPersianDate().toEnglishDigit(),
              initialDate: intl.DateFormat('yyyy/MM/dd').format(DateTime.now()),
              addLeadingZero: true,
              dateChangeListener: (String date) {
                pickedDate = date;
              },
              showDay: true,
              labelStyle: const TextStyle(
                fontFamily: 'IR',
                fontSize: 13.0,
                color: AppColorScheme.primaryColor,
              ),
              selectedRowStyle: const TextStyle(
                fontFamily: 'IR',
                fontSize: 13.0,
                color: AppColorScheme.primaryColor,
              ),
              unselectedRowStyle: const TextStyle(
                fontFamily: 'IR',
                fontSize: 10.0,
                color: Colors.grey,
              ),
              yearText: "سال",
              monthText: "ماه",
              dayText: "روز",
              showLabels: true,
              columnWidth: MediaQuery.of(context).size.width / 3.5,
              showMonthName: true,
              isJalaali: true,
            ),
            //const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: AppColorScheme.primaryColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "انصراف",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: AppColorScheme.primaryColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(pickedDate);
                      },
                      child: Text(
                        "تایید",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );

    return selectedDate;
  }

  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is StoreTrackDepositResponseState) {
          return state.goToPayment.fold(
            (l) {
              showErrorSnackBar(context, l);
            },
            (r) {
              showSuccessSnackBar(context, r);
              priceReceiptController.clear();
              tackCodeController.clear();
              dateController.clear();
              _clearImage();
            },
          );
        }
      },
      
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text('ثبت فیش واریزی'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              PhosphorIconsRegular.arrowLeft,
              color: AppColorScheme.primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ProjectBloc(),
                      child: const DashboardScreen(),
                    );
                  },
                ),
              );
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<PaymentBloc>(context).add(GetDepositEvent());
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: AppColorScheme.scafoldCollor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    PhosphorIconsRegular.warning,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('راهنما و شماره حساب',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'IR',
                                          color: Colors.blue)),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                '''لطفا برای مبلغ زیر 2۰۰ میلیون تومان از طریق پرداخت اینترنتی اقدام فرمایید.در صورت پرداخت از طریق بانک، اطلاعات فیش واریزی را در این قسمت ثبت نمایید.''',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'IR',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'شماره حساب',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'IR',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Clipboard.setData(const ClipboardData(
                                            text: '10115483932'));
                                        //showCopyConfirmationDialog(context);
                                      },
                                      icon: const Icon(
                                        PhosphorIconsRegular.clipboard,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      label: Text(
                                        '10115483932'.toPersianDigit(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'IR',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'شماره شبا',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'IR',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Clipboard.setData(const ClipboardData(
                                            text:
                                                'IR490700010002211548393002'));
                                        // showCopyConfirmationDialog(context);
                                      },
                                      icon: const Icon(
                                        PhosphorIconsRegular.clipboard,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      label: Text(
                                        'IR490700010002211548393002'
                                            .toPersianDigit(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'IR',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                textWidthBasis: TextWidthBasis.longestLine,
                                textAlign: TextAlign.center,
                                text: const TextSpan(children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: PhosphorIcon(
                                        PhosphorIconsRegular.warningCircle,
                                        color: Colors.red,
                                      )),
                                  TextSpan(
                                      text:
                                          ' درج کد/شناسه ملی پرداخت‌کننده در قسمت «شناسه پرداخت» فرم‌های پایا یا ساتنای واریز به حساب بانکی اسمارت فاندینگ الزامی است.',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'IR',
                                          color: Colors.red))
                                ]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey2,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: SizedBox(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    inputFormatters: [
                                      PersianNumberFormatter(),
                                    ],
                                    style: const TextStyle(
                                        fontSize: 12, fontFamily: 'IR'),
                                    controller: priceReceiptController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      //contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 15),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontFamily: 'IR'),
                                      labelText: 'مبلغ (تومان)',
                                      labelStyle: const TextStyle(
                                          fontSize: 10, fontFamily: 'IR'),

                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),

                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons
                                            .clear), // Change the icon as needed
                                        onPressed: () {
                                          priceReceiptController
                                              .clear(); // Clears the text field
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'لطفا مبلغ را وارد کنید';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                        fontSize: 12, fontFamily: 'IR'),
                                    controller: tackCodeController,
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      //contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 15),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontFamily: 'IR'),
                                      labelText: 'کد رهگیری',
                                      labelStyle: const TextStyle(
                                          fontSize: 10, fontFamily: 'IR'),

                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),

                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons
                                            .clear), // Change the icon as needed
                                        onPressed: () {
                                          tackCodeController
                                              .clear(); // Clears the text field
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'لطفا کد رهگیری را وارد کنید';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(fontSize: 12),
                                    readOnly: true,
                                    textDirection: TextDirection.ltr,
                                    onTap: () async {
                                      birthClick = true;
                                      final selectedDate =
                                          await _showDatePickerBottomSheet(
                                              context);
                                      if (selectedDate != null) {
                                        setState(() {
                                          dateController.text = selectedDate;
                                        });
                                        // print(selectedDate);
                                        var date = selectedDate.split("/");
                                        year = int.parse(date[0]);
                                        mounth = int.parse(date[1]);
                                        day = int.parse(date[2]);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: dateController,
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons
                                            .clear), // Change the icon as needed
                                        onPressed: () {
                                          dateController
                                              .clear(); // Clears the text field
                                        },
                                      ),
                                      //contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 15),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontFamily: 'IR'),
                                      labelText: 'تاریخ واریز',
                                      labelStyle: const TextStyle(
                                          fontSize: 10, fontFamily: 'IR'),

                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'لطفا تاریخ واریز خود را وارد کنید';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: _pickImage,
                                    child: _isLoading
                                        ? Container(
                                            height: 90,
                                            width: double.infinity,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : pickedImage == null
                                            ? Container(
                                                height: 90,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      style: BorderStyle.solid),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                        Icons.cloud_upload),
                                                    Text(
                                                      'لطفا عکس فیش واریزی را آپلود کنید',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    height: 200,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: FileImage(File(
                                                            pickedImage!.path)),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    top: 5,
                                                    child: IconButton(
                                                      icon: PhosphorIcon(
                                                        PhosphorIcons.trash(
                                                          PhosphorIconsStyle
                                                              .duotone,
                                                        ),
                                                        color: AppColorScheme
                                                            .primaryColor,
                                                      ),
                                                      onPressed: _clearImage,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    top: 40,
                                                    child: IconButton(
                                                      icon: PhosphorIcon(
                                                        PhosphorIcons.pen(
                                                          PhosphorIconsStyle
                                                              .duotone,
                                                        ),
                                                        color: AppColorScheme
                                                            .primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        _clearImage();
                                                        _pickImage();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColorScheme.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        fixedSize: Size(
                                            MediaQuery.of(context).size.width,
                                            40)),
                                    onPressed: () {
                                      if (_formKey2.currentState!.validate()) {
                                        final amount = int.parse(
                                            priceReceiptController.text
                                                .replaceAll(',', '')
                                                .toEnglishDigit());
                                        Jalali j = Jalali(year!, mounth!, day!);
                                        final date =
                                            "${j.toGregorian().year}-${j.toGregorian().month}-${j.toGregorian().day}"
                                                .toEnglishDigit();
                                        final refId = tackCodeController.text
                                            .toEnglishDigit();
                                        if (pickedImage != null) {
                                          BlocProvider.of<PaymentBloc>(context)
                                              .add(StoreTrackDepositEvent(
                                                  widget.projectId,
                                                  amount,
                                                  refId,
                                                  date,
                                                  pickedImage!));
                                        } else {
                                          showErrorSnackBar(context,
                                              'لطفا عکس فیش را بارگذاری کنید');
                                        }
                                        ;
                                      }
                                    },
                                    child:
                                        BlocBuilder<PaymentBloc, PaymentState>(
                                      builder: (context, state) {
                                        if (state is DisposeLoadingState) {
                                          return const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'در حال ذخیره',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontFamily: 'IR'),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              SizedBox(
                                                height: 30,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        return const Text(
                                          'ثبت',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'IR'),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (context, state) {
                            if (state is DisposeGetLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColorScheme.primaryColor,
                                ),
                              );
                            }
                            if (state is GetDepositResponseState) {
                              return state.getDeposit.fold((l) => Text(l),
                                  (withdraw) {
                                if (withdraw.data!.isNotEmpty) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'تاریخچه فیش ها',
                                          style: TextStyle(
                                              fontFamily: 'IR',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ListView.builder(
                                            controller: scrollController,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    // tileColor: Colors.red,

                                                    selectedColor: Colors.white,
                                                    titleTextStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                    subtitleTextStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                    isThreeLine: true,
                                                    title: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                            'مبلغ درخواستی :',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'IR')),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              withdraw
                                                                  .data![index]
                                                                  .amount
                                                                  .toString()
                                                                  .toPersianDigit()
                                                                  .seRagham(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'IR'),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              'تومان',
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                fontFamily:
                                                                    'IR',
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    leading: Icon(
                                                      Icons
                                                          .currency_exchange_outlined,
                                                      color: withdraw
                                                                  .data![index]
                                                                  .status ==
                                                              1
                                                          ? Colors.blueAccent
                                                          : withdraw
                                                                      .data![
                                                                          index]
                                                                      .status ==
                                                                  2
                                                              ? Colors.green
                                                              : Colors.red,
                                                    ),
                                                    subtitle: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 8),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  'وضعیت :',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'IR')),
                                                              withdraw
                                                                          .data![
                                                                              index]
                                                                          .status ==
                                                                      1
                                                                  ? const Text(
                                                                      'در حال بررسی',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .blueAccent,
                                                                          fontFamily:
                                                                              'IR'),
                                                                    )
                                                                  : withdraw.data![index].status ==
                                                                          2
                                                                      ? Text(
                                                                          'تایید شده',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  12,
                                                                              fontFamily:
                                                                                  'IR',
                                                                              color: Colors.green[
                                                                                  600]))
                                                                      : Text(
                                                                          'لغو شده',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'IR',
                                                                              color: Colors.red[700]))
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 8),
                                                          child: Text(
                                                            'تاریخ ثبت: ${withdraw.data![index].createdAt.toPersianDate()}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'IR'),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    thickness: 0.2,
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: withdraw.data!.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
