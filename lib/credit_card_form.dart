import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'credit_card_model.dart';
import 'flutter_credit_card.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    @required this.onCreditCardModelChange,
    this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
    this.labelStyle = const TextStyle(fontSize: 18.0),
    this.inputSeparationHeight = 18.0,
    this.useUnderlineInputBorder = false,
    this.useYearWithFourDigits = false,
    this.localizedText = const LocalizedText(),
  })  : assert(localizedText != null),
        super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;
  final TextStyle labelStyle;
  final double inputSeparationHeight;
  final bool useUnderlineInputBorder;
  final bool useYearWithFourDigits;
  final LocalizedText localizedText;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  Color themeColor;

  void Function(CreditCardModel) onCreditCardModelChange;
  CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/0000');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (widget.useUnderlineInputBorder) ? Text(widget.localizedText.cardNumberLabel, style: widget.labelStyle) : Container(),
            TextFormField(
              controller: _cardNumberController,
              cursorColor: widget.cursorColor ?? themeColor,
              style: TextStyle(
                color: widget.textColor,
              ),
              decoration: (widget.useUnderlineInputBorder) ?
              InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                ),
                hintText: widget.localizedText.cardNumberHint,
              ) :
              InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.localizedText.cardNumberLabel,
                hintText: widget.localizedText.cardNumberHint,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: widget.inputSeparationHeight),
            (widget.useUnderlineInputBorder) ? Text(widget.localizedText.expiryDateLabel, style: widget.labelStyle) : Container(),
            TextFormField(
              controller: _expiryDateController,
              cursorColor: widget.cursorColor ?? themeColor,
              style: TextStyle(
                color: widget.textColor,
              ),
              decoration: (widget.useUnderlineInputBorder) ?
              InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                ),
                hintText: widget.localizedText.expiryDateHint,
              ) :
              InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.localizedText.expiryDateLabel,
                hintText: widget.localizedText.expiryDateHint,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: widget.inputSeparationHeight),
            (widget.useUnderlineInputBorder) ? Text(widget.localizedText.cvvLabel, style: widget.labelStyle) : Container(),
            TextField(
              focusNode: cvvFocusNode,
              controller: _cvvCodeController,
              cursorColor: widget.cursorColor ?? themeColor,
              style: TextStyle(
                color: widget.textColor,
              ),
              decoration: (widget.useUnderlineInputBorder) ?
              InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                ),
                hintText: widget.localizedText.cvvHint,
              ) :
              InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.localizedText.cvvLabel,
                hintText: widget.localizedText.cvvHint,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (String text) {
                setState(() {
                  cvvCode = text;
                });
              },
            ),
            SizedBox(height: widget.inputSeparationHeight),
            (widget.useUnderlineInputBorder) ? Text(widget.localizedText.cardHolderLabel, style: widget.labelStyle) : Container(),
            TextFormField(
              controller: _cardHolderNameController,
              cursorColor: widget.cursorColor ?? themeColor,
              style: TextStyle(
                color: widget.textColor,
              ),
              decoration: (widget.useUnderlineInputBorder) ?
              InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                ),
                hintText: widget.localizedText.cardHolderHint,
              ) :
              InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.localizedText.cardHolderLabel,
                hintText: widget.localizedText.cardHolderHint,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }
}
