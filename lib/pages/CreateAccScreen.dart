import 'dart:convert';
import 'package:OrderIt/auth.dart';
import 'package:OrderIt/cities.dart';
import 'package:OrderIt/classes/User.dart';
import 'package:OrderIt/pages/BottomNav.dart';
import 'package:OrderIt/pages/LoginScreen.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:credit_card_validate/credit_card_validate.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../database.dart';

class CreateAcc extends StatefulWidget {
  @override
  _CreateAccState createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  @override
  void initState() {
    Hive.openBox('users');
    Hive.openBox('current_user');
    Hive.openBox('current_user_email'); 
    Hive.openBox('cartao');
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  Auth _a = Auth();

  bool isTheFirstTime = true;

  var creditCardMaskFormatter = new MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
  var dateMaskFormatter = new MaskTextInputFormatter(
      mask: '##/##', filter: {"#": RegExp(r'[0-9]')});

  var phoneMaskFormatter = new MaskTextInputFormatter(
      mask: '(##) ##### - ####', filter: {"#": RegExp(r'[0-9]')});

  IconData brandIcon;

  String name = "";
  String email = "";
  String phone = "";
  String city = "";
  String cpf = "";
  String brand;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController repeatPassC = TextEditingController();
  TextEditingController payMethodC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController cpfC = TextEditingController();

  TextEditingController ccnaC = TextEditingController();
  TextEditingController ccnC = TextEditingController();
  TextEditingController scC = TextEditingController();
  TextEditingController ccvC = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPass = FocusNode();
  final _focusPhone = FocusNode();
  final _focusRPass = FocusNode();
  final _focusCPF = FocusNode();

  final _focusCCN = FocusNode();
  final _focusCCNa = FocusNode();
  final _focusCCSn = FocusNode();
  final _focusCCV = FocusNode();

  String option;
  String selectedCity = "Escolha uma cidade ao lado";
  String selectedMethod = "Escolha um método ao lado";

  var cities = new List<Cities>();
  var filteredCities = new List<Cities>();

  _selectedCityText(int index) {
    setState(() {
      selectedCity = filteredCities[index].city;
    });
  }

  _getCitiesToList() {
    Cities().getCities().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        cities = list.map((model) => Cities.fromJson(model)).toList();
        filteredCities = cities;
        cityC.text = selectedCity;
      });
    });
  }

  _CreateAccState() {
    _getCitiesToList();
  }

  Widget _buildList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return FlatButton(
            child: Text(filteredCities[index].city),
            onPressed: () {
              setState(() {
                _selectedCityText(index);
                Navigator.pop(context);
              });
            },
          );
        },
        itemCount: filteredCities.length,
      ),
    );
  }

  Widget _genericInputField(
      String title,
      String hintText,
      TextEditingController c,
      TextInputType tit,
      bool ot,
      bool ac,
      FocusNode fn,
      TextInputAction tia) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 20, top: 10),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                textInputAction: tia,
                focusNode: fn,
                onFieldSubmitted: (value) {
                  fn.nextFocus();
                },
                obscureText: ot,
                keyboardType: tit,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                controller: c,
                autocorrect: ac,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genericCPFField(
      String title,
      String hintText,
      TextEditingController c,
      TextInputType tit,
      bool ot,
      bool ac,
      FocusNode fn,
      TextInputAction tia) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 20, top: 10),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                textInputAction: tia,
                focusNode: fn,
                onFieldSubmitted: (value) {
                  fn.nextFocus();
                },
                obscureText: ot,
                keyboardType: tit,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                controller: c,
                autocorrect: ac,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genericInputPhoneField(
      String title,
      String hintText,
      TextEditingController c,
      TextInputType tit,
      bool ot,
      bool ac,
      FocusNode fn,
      TextInputAction tia) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 20, top: 10),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                inputFormatters: [phoneMaskFormatter],
                textInputAction: tia,
                focusNode: fn,
                onFieldSubmitted: (value) {
                  fn.nextFocus();
                },
                obscureText: ot,
                keyboardType: tit,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                controller: c,
                autocorrect: ac,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genericModalSheet(
      String title, String hintText, TextEditingController tec) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 51.5,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: Text(selectedMethod),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  margin: EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: FlatButton(
                      child: Text("Selecione"),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: false,
                            isDismissible: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Scaffold(
                                  body: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  isDismissible: true,
                                                  builder: (context) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height -
                                                              100,
                                                      child: Scaffold(
                                                        resizeToAvoidBottomPadding:
                                                            true,
                                                        resizeToAvoidBottomInset:
                                                            false,
                                                        body: Column(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SingleChildScrollView(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        100,
                                                                    height: 20,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            "Número do cartão"),
                                                                      ],
                                                                    ),
                                                                    margin: EdgeInsets.only(
                                                                        top: 20,
                                                                        left:
                                                                            10),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              10),
                                                                  child:
                                                                      TextFormField(
                                                                    onChanged:
                                                                        (value) {
                                                                      IconData
                                                                          ccBrandIcon;
                                                                      brand = CreditCardValidator
                                                                          .identifyCardBrand(
                                                                              ccnC.text);

                                                                      if (brand !=
                                                                          null) {
                                                                        if (brand ==
                                                                            'visa') {
                                                                          ccBrandIcon =
                                                                              FontAwesomeIcons.ccVisa;
                                                                        } else if (brand ==
                                                                            'master_card') {
                                                                          ccBrandIcon =
                                                                              FontAwesomeIcons.ccMastercard;
                                                                        } else if (brand ==
                                                                            'american_express') {
                                                                          ccBrandIcon =
                                                                              FontAwesomeIcons.ccAmex;
                                                                        } else if (brand ==
                                                                            'discover') {
                                                                          ccBrandIcon =
                                                                              FontAwesomeIcons.ccDiscover;
                                                                        }
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        brandIcon =
                                                                            ccBrandIcon;
                                                                      });
                                                                    },
                                                                    onFieldSubmitted:
                                                                        (v) {
                                                                      _focusCCN
                                                                          .nextFocus();
                                                                    },
                                                                    focusNode:
                                                                        _focusCCN,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    controller:
                                                                        ccnC,
                                                                    inputFormatters: [
                                                                      creditCardMaskFormatter
                                                                    ],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        suffixIcon: brandIcon != null
                                                                            ? FaIcon(
                                                                                brandIcon,
                                                                                size: 28,
                                                                              )
                                                                            : null,
                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                                  ),
                                                                  width: 300,
                                                                  height: 80,
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              20),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              bottom:
                                                                                  10,
                                                                              left:
                                                                                  20),
                                                                          child:
                                                                              Text("Nome escrito do cartão")),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        ccnaC,
                                                                    focusNode:
                                                                        _focusCCNa,
                                                                    onFieldSubmitted:
                                                                        (v) {
                                                                      _focusCCNa
                                                                          .nextFocus();
                                                                    },
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    decoration:
                                                                        InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                                  ),
                                                                  width: 300,
                                                                  height: 100,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                          "Código de segurança"),
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              10),
                                                                    ),
                                                                    Container(
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              scC,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          focusNode:
                                                                              _focusCCSn,
                                                                          onFieldSubmitted:
                                                                              (v) {
                                                                            _focusCCSn.nextFocus();
                                                                          },
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          maxLength:
                                                                              3,
                                                                          decoration:
                                                                              InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                                        )),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                          "Valido até..."),
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              10),
                                                                    ),
                                                                    Container(
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        child:
                                                                            TextFormField(
                                                                          onFieldSubmitted:
                                                                              (value) {
                                                                            _focusCCV.unfocus();
                                                                          },
                                                                          controller:
                                                                              ccvC,
                                                                          focusNode:
                                                                              _focusCCV,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          inputFormatters: [
                                                                            dateMaskFormatter
                                                                          ],
                                                                          decoration:
                                                                              InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                                        )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child: RaisedButton(
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                      color: Colors.black,
                                                                      textColor: Colors.white,
                                                                      onPressed: () {
                                                                        if (ccnaC.text.isEmpty ||
                                                                            ccnC.text.isEmpty ||
                                                                            scC.text.isEmpty ||
                                                                            ccvC.text.isEmpty) {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                title: Text("Atenção!"),
                                                                                content: Text("Preencha todos os campos!"),
                                                                                actions: [
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text("Ok"))
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        } else if (ccnC.text.length <
                                                                            13) {
                                                                          ccnC.text =
                                                                              null;
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return new AlertDialog(
                                                                                title: Text('Atenção!'),
                                                                                content: Text('Número de cartão inválido'),
                                                                                actions: [
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text("Ok"))
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        } else if (ccnaC.text.length <
                                                                            10) {
                                                                          ccnaC.text =
                                                                              null;
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return new AlertDialog(
                                                                                title: Text('Atenção'),
                                                                                content: Text('Precisamos do seu nome completo!'),
                                                                                actions: [
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text("Ok"))
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        } else if (CreditCardValidator.isCreditCardValid(cardNumber: ccnC.text.toString()) ==
                                                                            false) {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return new AlertDialog(
                                                                                title: Text('Atenção'),
                                                                                content: Text('Número do cartão inválido!'),
                                                                                actions: [
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text("Ok"))
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            selectedMethod =
                                                                                "Cartão de crédito";
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      child: Text("Validar dados e continuar")),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  context: context);
                                            },
                                            child: ListTile(
                                              leading: Icon(Icons.credit_card),
                                              title: Text("Cartão de crédito"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber[300],
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Criar uma conta no OrderIt!",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  _genericInputField(
                      "Nome completo",
                      "Digite seu nome aqui",
                      nameC,
                      TextInputType.text,
                      false,
                      true,
                      _focusName,
                      TextInputAction.next),
                  _genericCPFField(
                      "CPF",
                      "Digite o número do seu CPF aqui",
                      cpfC,
                      TextInputType.number,
                      false,
                      false,
                      _focusCPF,
                      TextInputAction.next),
                  _genericInputField(
                      "Seu melhor e-mail",
                      "Digite seu email aqui",
                      emailC,
                      TextInputType.emailAddress,
                      false,
                      false,
                      _focusEmail,
                      TextInputAction.next),
                  _genericInputPhoneField(
                      "Número de celular",
                      "Digite o número do seu celular",
                      phoneC,
                      TextInputType.numberWithOptions(),
                      false,
                      false,
                      _focusPhone,
                      TextInputAction.next),
                  _genericInputField(
                      "Escolha uma senha (mínimo 10 caracteres)",
                      "Digite sua senha aqui",
                      passC,
                      TextInputType.text,
                      true,
                      false,
                      _focusPass,
                      TextInputAction.next),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Repita a senha",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 20, top: 10),
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              focusNode: _focusRPass,
                              onFieldSubmitted: (value) {
                                _focusRPass.unfocus();
                              },
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Redigite a senha aqui",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              controller: repeatPassC,
                              autocorrect: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _genericModalSheet("Escolha um método de pagamento",
                      "Escolha um método", payMethodC),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "De qual cidade você é?",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 51.5,
                                width: MediaQuery.of(context).size.width - 180,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, left: 10),
                                  child: Text(selectedCity),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.32,
                                margin: EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black)),
                                  child: FlatButton(
                                    child: Text("Selecione"),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          isDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return SafeArea(
                                              child: Scaffold(
                                                body: Wrap(children: [
                                                  Container(
                                                    margin: EdgeInsets.all(20),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: TextField(
                                                        autocorrect: true,
                                                        textInputAction:
                                                            TextInputAction
                                                                .search,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            hintText:
                                                                "Procure aqui",
                                                            icon: Icon(
                                                                Icons.search)),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            filteredCities = cities
                                                                .where((element) => (element
                                                                        .city
                                                                        .toLowerCase()
                                                                        .contains(value
                                                                            .toLowerCase()) ||
                                                                    element.city
                                                                        .toUpperCase()
                                                                        .contains(
                                                                            value.toUpperCase())))
                                                                .toList();
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child:
                                                        SingleChildScrollView(
                                                            child:
                                                                _buildList()),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 130,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 10,
                            color: Colors.black,
                            onPressed: () {
                              nameC.text = null;
                              emailC.text = null;
                              phoneC.text = null;
                              passC.text = null;
                              repeatPassC.text = null;
                              ccnC.text = null;
                              ccnaC.text = null;
                              ccvC.text = null;
                              cityC.text = null;
                              payMethodC.text = null;
                              scC.text = null;
                              cpfC.text = null;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 10,
                            color: Colors.black,
                            onPressed: () async {
                              if ((nameC.text.isEmpty ||
                                      cpfC.text.isEmpty ||
                                      emailC.text.isEmpty ||
                                      phoneC.text.isEmpty ||
                                      passC.text.isEmpty ||
                                      repeatPassC.text.isEmpty) ||
                                  selectedCity ==
                                      "Escolha uma cidade ao lado" ||
                                  selectedMethod ==
                                      "Escolha um método ao lado") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Atenção!"),
                                      content:
                                          Text("Preencha todos os campos!"),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (EmailValidator.validate(emailC.text) ==
                                  false) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      title: Text('Atenção'),
                                      content: Text('E-mail inválido!'),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (phoneC.text.length < 11) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      title: Text('Atenção'),
                                      content: Text('Telefone inválido'),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (repeatPassC.text != passC.text) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      title: Text('Atenção'),
                                      content: Text('As senhas não coincidem!'),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (nameC.text.length < 15) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      title: Text('Atenção'),
                                      content: Text(
                                          'Precisamos do seu nome completo!'),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (CPFValidator.isValid(cpfC.text) ==
                                  false) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      title: Text('Atenção'),
                                      content: Text('Número do CPF inválido!'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Ok"))
                                      ],
                                    );
                                  },
                                );
                              } else {
                                User u = User(nameC.text, emailC.text,
                                    phoneC.text, selectedCity, cpfC.text);                                

                                setState(() {
                                  name = nameC.text;
                                  city = selectedCity;
                                  phone = phoneC.text;
                                  email = emailC.text;
                                  cpf = cpfC.text;
                                });

                                // Db().insertUser(u);
                                // Db().insertUserPayMethod(ccnC.text, ccnaC.text, scC.text, ccvC.text);


                                try {
                                  await Hive.box('users').put(email, {
                                    'name': name,
                                    'city': city,
                                    'phone': phone,
                                    'email': email,
                                    'cpf': cpf
                                  });

                                  await Hive.box('current_user').put(email, {
                                    'name': name,
                                    'city': city,
                                    'phone': phone,
                                    'email': email,
                                    'cpf': cpf
                                  });

                                  await Hive.box('cartao').put(email, {
                                    'numero': ccnC.text,
                                    'validade': scC.text
                                  });

                                  await Hive.box('current_user_email')
                                      .put('email', email);                                  
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return new AlertDialog(
                                        title: Text('Erro!'),
                                        content: Text(
                                            'Erro ao gravar no banco de dados'),
                                        actions: [
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }

                                try {
                                  _a.createUser(email, passC.text, context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNav()));
                                } catch (erro) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return new AlertDialog(
                                        title: Text('Erro!'),
                                        content: Text('Houve um erro!'),
                                        actions: [
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Text(
                              "Criar conta!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
