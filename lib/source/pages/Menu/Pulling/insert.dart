import 'package:pulling/source/data/Menu/Pulling/cubit/insert_scan_cubit.dart';
import 'package:pulling/source/data/Menu/Pulling/cubit/pulling_cubit.dart';
import 'package:pulling/source/data/Menu/Pulling/cubit/save_pulling_cubit.dart';
import 'package:pulling/source/widget/customAlertDialog.dart';
import 'package:pulling/source/widget/customBtnSave.dart';
import 'package:pulling/source/widget/customBtnScanQr.dart';
import 'package:pulling/source/widget/customLoading.dart';
import 'package:pulling/source/widget/customTextField.dart';
import 'package:pulling/source/widget/customTextFieldRead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsertPulling extends StatefulWidget {
  const InsertPulling({super.key});

  @override
  State<InsertPulling> createState() => _InsertPullingState();
}

class _InsertPullingState extends State<InsertPulling> {
  TextEditingController controllerManual = TextEditingController();
  // INSERT MANUAL
  TextEditingController controllerWO = TextEditingController();
  TextEditingController controllerBoxNumber = TextEditingController();
  TextEditingController controllerWorkCenterFrom = TextEditingController();
  TextEditingController controllerWorkCenterTo = TextEditingController();
  TextEditingController controllerQtyOk = TextEditingController();
  TextEditingController controllerQtyAvailable = TextEditingController();
  TextEditingController controllerQtyRepair = TextEditingController();
  TextEditingController controllerQtyNG = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? wc_to_id, wc_from_id, last_wc, qty_real;
  bool isManual = false;
  save() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<SavePullingCubit>(context).savePulling(
        controllerBoxNumber.text,
        controllerQtyOk.text,
        controllerQtyRepair.text,
        controllerQtyNG.text,
        wc_to_id,
        wc_from_id,
        qty_real,
        last_wc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Pulling'),
        actions: [
          CupertinoSwitch(
              value: isManual,
              onChanged: (value) {
                setState(() {
                  isManual = value;
                });
              }),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                isManual == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controllerManual,
                              // onEditingComplete: () {
                              //   if (controllerManual.text != '') {
                              //     BlocProvider.of<InsertScanCubit>(context).insertManual(controllerManual.text);
                              //   }
                              // },
                              decoration: InputDecoration(
                                hintText: 'Masukan Kode',
                                suffixIcon: InkWell(
                                    onTap: () {
                                      if (controllerManual.text != '') {
                                        BlocProvider.of<InsertScanCubit>(context).insertManual(controllerManual.text);
                                      }
                                    },
                                    child: Icon(Icons.search)),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Divider(thickness: 2)
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButtonScanQR(
                          onTap: () {
                            BlocProvider.of<InsertScanCubit>(context).scanInsert();
                          },
                          text: 'Scan QR Code',
                        ),
                      ),
                BlocListener<InsertScanCubit, InsertScanState>(
                  listener: (context, state) {
                    if (state is InsertScanLoading) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const CustomLoading();
                        },
                      );
                    }
                    if (state is InsertScanLoaded) {
                      Navigator.pop(context);
                      var statusCode = state.statusCode;
                      var json = state.json;
                      if (statusCode == 200) {
                        setState(() {
                          controllerWO = TextEditingController(text: json['rows'][0]['wo_code']);
                          controllerBoxNumber = TextEditingController(text: json['rows'][0]['box_number']);
                          controllerWorkCenterFrom = TextEditingController(text: json['rows'][0]['wc_from']);
                          controllerWorkCenterTo = TextEditingController(text: json['rows'][0]['wc_to']);
                          controllerQtyAvailable = TextEditingController(text: json['rows'][0]['qty_available']);
                          wc_to_id = json['rows'][0]['wc_to_id'];
                          wc_from_id = json['rows'][0]['wc_from_id'];
                          last_wc = json['last_wc'].toString();
                          qty_real = json['rows'][0]['qty_real'].toString();
                        });
                      } else {
                        MyAlertDialog.warningDialog(context, json['msg']);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomFormFieldRead(
                            controller: controllerWO,
                            label: 'Work Order',
                            // msgError: 'Kolom harus di isi',
                          ),
                          CustomFormFieldRead(
                            controller: controllerBoxNumber,
                            label: 'Box Number',
                            msgError: 'Kolom harus di isi',
                          ),
                          CustomFormFieldRead(
                            controller: controllerWorkCenterFrom,
                            label: 'Work Center From',
                            // msgError: 'Kolom harus di isi',
                          ),
                          CustomFormFieldRead(
                            controller: controllerWorkCenterTo,
                            label: 'Work Center To',
                            // msgError: 'Kolom harus di isi',
                          ),
                          CustomFormFieldRead(
                            controller: controllerQtyAvailable,
                            label: 'Quantity Available',
                            // msgError: 'Kolom harus di isi',
                          ),
                          CustomFormField(
                            controller: controllerQtyOk,
                            label: 'Quantity OK',
                            inputType: TextInputType.number,
                            // msgError: 'Kolom harus di isi',
                          ),
                          CustomFormField(
                            controller: controllerQtyRepair,
                            label: 'Quantity Repair',
                            inputType: TextInputType.number,
                            // msgError: 'Kolom harus di isi',
                          ),
                          CustomFormField(
                            controller: controllerQtyNG,
                            label: 'Quantity NG',
                            inputType: TextInputType.number,
                            // msgError: 'Kolom harus di isi',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocListener<SavePullingCubit, SavePullingState>(
                  listener: (context, state) {
                    if (state is SavePullingLoading) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const CustomLoading();
                        },
                      );
                    }
                    if (state is SavePullingLoaded) {
                      Navigator.pop(context);
                      var message = state.json;
                      var statusCode = state.statusCode;
                      if (statusCode == 200) {
                        MyAlertDialog.successDialog(
                          context,
                          message,
                          () {
                            Navigator.pop(context);
                            BlocProvider.of<PullingCubit>(context).getCurrentPulling();
                          },
                        );
                      } else {
                        MyAlertDialog.warningDialog(context, message);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      height: 50,
                      child: CustomButtonSave(
                        onPressed: () {
                          save();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
