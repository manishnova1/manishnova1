import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/common/service/dialog_service.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/printer_bloc/printer_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/image_submit_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../common/service/navigation_service.dart';
import '../../../../common/service/printing_service.dart';
import '../../../../constants/app_utils.dart';
import '../../../../data/local/sqlite.dart';
import '../../../../data/model/auth/login_model.dart';
import '../../../Utils/common_printer_dialog.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import 'offender_description.dart';

class unpaidfareNoticeSuccessfullHt extends StatefulWidget {
  final String caseNumber;

  const unpaidfareNoticeSuccessfullHt({Key? key, required this.caseNumber})
      : super(key: key);

  @override
  _unpaidfareNoticeSuccessfullHtState createState() =>
      _unpaidfareNoticeSuccessfullHtState();
}

class _unpaidfareNoticeSuccessfullHtState
    extends State<unpaidfareNoticeSuccessfullHt> {
  TextEditingController notesController = TextEditingController();
  LoginModel? user;
  bool isPrinterConnected(BuildContext context) {
    final printerBloc = BlocProvider.of<PrinterBloc>(context);
    return printerBloc.status == "Connected";
  }
  getprinterConnnected(){
    connectToPrinterIfNotConnected(context);
  }

  connectToPrinterIfNotConnected(BuildContext context) async {
    if (!isPrinterConnected(context)) {
      String printType = await AppUtils().getPrinterId();
      if (printType != null && printType != "") {
        locator<PrintingService>().connectToPrinter(printType);
      }
    }
  }
  openAppDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Confirmation',
                  ),
                )),
                Image.asset(
                  "Assets/icons/success.png",
                  width: 10.w,
                  fit: BoxFit.cover,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "Add Physical Description",
                              onAction: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OffenderDescriptionHt()));
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Return to Menu",
                              onAction: () {
                                locator<NavigationService>().pushAndRemoveUntil(
                                    UnPaidFareIssueMainRoute(
                                        isOfflineApiRequired: false));
                                BlocProvider.of<AddressUfnBloc>(context)
                                    .submitAddressMap
                                    .clear();
                                BlocProvider.of<ImageSubmitBloc>(context)
                                    .imageMapList
                                    .clear();
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  onPrintSucessDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Print Successful',
                  ),
                )),
                Image.asset(
                  "Assets/icons/success.png",
                  width: 10.w,
                  fit: BoxFit.cover,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "Add Physical Description",
                              onAction: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OffenderDescriptionHt()));
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Return to Menu",
                              onAction: () {
                                locator<NavigationService>().pushAndRemoveUntil(
                                    UnPaidFareIssueMainRoute(
                                        isOfflineApiRequired: false));
                                BlocProvider.of<AddressUfnBloc>(context)
                                    .submitAddressMap
                                    .clear();
                                BlocProvider.of<ImageSubmitBloc>(context)
                                    .imageMapList
                                    .clear();
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  getLoginModelData() async {
    user = await SqliteDB.instance.getLoginModelData();
  }

  @override
  void initState() {
    getLoginModelData();
    getprinterConnnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          bottomNavigationBar: InkWell(
            onTap: () async {
              openAppDialog(context);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              width: 100.w,
              height: 6.8.h,
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  subheadingTextBOLD(title: "Continue"),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: secondryColor,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: primaryColor,
            actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
          ),
          body: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: gradientDecoration,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: screenPadding,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w, color: primaryColor),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  headingTextOne(
                                      title:
                                          "Unpaid Fare \nNotice\nSuccessful"),
                                  Image.asset(
                                    "Assets/icons/success.png",
                                    width: 20.w,
                                    height: 10.h,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                              LargeSpace(),
                              MediumSpace(),
                              boxtextSmall(title: "Notice Reference:"),
                              subheadingTextBOLD(title: "${widget.caseNumber}"),
                              LargeSpace(),
                              SmallSpace(),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      BlocListener<PrinterBloc, PrinterState>(
                                        listener: (context, state) {
                                          if (state
                                              is PrinterCheckStatusHeadState) {
                                            if (state.status == "Connected") {
                                              CommonPrinterDialog()
                                                  .startPrintingDialog(context);
                                              BlocProvider.of<PrinterBloc>(
                                                      context)
                                                  .add(PrinterCaseEvent(
                                                      type: "UFN(HT)",
                                                      context: context));
                                            } else {
                                              CommonPrinterDialog()
                                                  .showPrinterStatusDialog(
                                                      context, state.status);
                                            }
                                          } else if (state
                                              is PrintingDoneState) {
                                            if (state.status == "Failed") {
                                              Navigator.pop(context);
                                              CommonPrinterDialog()
                                                  .cancelPrinterDialog(context,
                                                      onPressed: () {
                                                Navigator.pop(context, true);
                                                if (BlocProvider.of<
                                                                PrinterBloc>(
                                                            context)
                                                        .status ==
                                                    "Connected") {
                                                  BlocProvider.of<PrinterBloc>(
                                                          context)
                                                      .add(
                                                          PrinterCheckStatusEvent());
                                                } else {
                                                  CommonPrinterDialog()
                                                      .showPrinterDialog(
                                                          context);
                                                }
                                              });
                                            } else if (state.status == "Done") {
                                              Navigator.pop(context);
                                              locator<DialogService>()
                                                  .commonSuccessDialog(context,
                                                      continueAction: () {
                                                Navigator.pop(context);
                                                onPrintSucessDialog(context);
                                              }, rePrintAction: () {
                                                Navigator.pop(context);
                                                if (BlocProvider.of<
                                                                PrinterBloc>(
                                                            context)
                                                        .status ==
                                                    "Connected") {
                                                  BlocProvider.of<PrinterBloc>(
                                                          context)
                                                      .add(
                                                          PrinterCheckStatusEvent());
                                                } else {
                                                  CommonPrinterDialog()
                                                      .showPrinterDialog(
                                                          context);
                                                }
                                              });
                                            }
                                          } else if (state
                                              is PrinterCommandReadyToPrintState) {
                                            BlocProvider.of<PrinterBloc>(
                                                    context)
                                                .add(PrinterPrintCommandEvent(
                                                    state.zplCommand));
                                          }
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            if (BlocProvider.of<PrinterBloc>(
                                                        context)
                                                    .status ==
                                                "Connected") {
                                              BlocProvider.of<PrinterBloc>(
                                                      context)
                                                  .add(
                                                      PrinterCheckStatusEvent());
                                            } else {
                                              CommonPrinterDialog()
                                                  .showPrinterDialog(context);
                                            }
                                          },
                                          child: Container(
                                            width: 88.w,
                                            decoration: BoxDecoration(
                                              color: blueGrey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  boxtextBold(
                                                      title:
                                                          "Print Unpaid Fare Notice (HT)"),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(Icons.print,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: TopHeaderCase(
                      title: "Unpaid Fare Notice (HT) ",
                      icon: "Assets/icons/bandge.png")),
            ],
          ),
        ));
  }
}
