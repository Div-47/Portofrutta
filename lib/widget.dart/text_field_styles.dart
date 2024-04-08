import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import "package:flutter_svg/flutter_svg.dart";

Widget whiteTextField(String tableText, TextEditingController controller, name,
    bool isReadOnly, String onSaved, FormFieldValidator<String> validation,
    {void Function(String)? onchange,
    bool? isPassword,
    List<TextInputFormatter>? formatter,void Function()? onTap,}) {
  return Container(
    alignment: Alignment.centerLeft,
    child: TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      style: inputTextStyle13(),
      inputFormatters: formatter,
      keyboardType: name,
      cursorColor: ColorResource.white,
      obscureText: isPassword != null ? isPassword : false,
      decoration: InputDecoration(
        errorStyle: errorTextStyle(),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResource.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResource.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResource.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResource.white, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        labelText: tableText,
        labelStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      validator: validation,
      onSaved: (value) => onSaved = value!.trim(),
      onChanged: onchange,
      onTap: onTap,
    ),
  );
}

Widget greyUnderlineTextField(
    // String tableText,
    TextEditingController controller,
    name,
    bool isReadOnly,
    // String onSaved,
    FormFieldValidator<String> validation,
    {void Function(String)? onchange,
    bool? isPassword,
    List<TextInputFormatter>? formatter}) {
  return Container(
    alignment: Alignment.centerLeft,
    child: TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      // style: inputTextStyle13(),
      inputFormatters: formatter,
      keyboardType: name,
      cursorColor: ColorResource.black,
      obscureText: isPassword != null ? isPassword : false,
      decoration: InputDecoration(
        errorStyle: errorRedTextStyle(),
        // contentPadding: EdgeInsets.symmetric(
        //   vertical: 15,
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResource.white, width: 1),
        //     borderRadius: BorderRadius.all(Radius.circular(25))),
        // errorBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: ColorResource.red, width: 1),
        //     borderRadius: BorderRadius.all(Radius.circular(25))),
        // focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResource.white, width: 1),
        //     borderRadius: BorderRadius.all(Radius.circular(25))),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResource.white, width: 1),
        //     borderRadius: BorderRadius.all(Radius.circular(25))),

        // labelText: tableText,
        labelStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      validator: validation,
      // onSaved: (value) => onSaved = value!.trim(),
      onChanged: onchange,
    ),
  );
}

Widget greyTextField(String tableText, TextEditingController controller, name,
    bool isReadOnly, String onSaved, FormFieldValidator<String> validation,
    {void Function(String)? onchange,
    bool? isPassword,
    List<TextInputFormatter>? formatter,void Function()? onTap,}) {
  return Container(
    alignment: Alignment.centerLeft,
    child: TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      style: headingStyleBlack14(),
      keyboardType: name,
      cursorColor: ColorResource.grey,
      inputFormatters: formatter,
      decoration: InputDecoration(
        errorStyle: errorTextStyle(),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),

        // errorBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResource.appColor),
        //     borderRadius: BorderRadius.all(Radius.circular(25))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResource.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResource.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        labelText: tableText,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      validator: validation,
      onSaved: (value) => onSaved = value!.trim(),
      onChanged: onchange,
      onTap: onTap,
    ),
  );
}

Widget whiteCapitalTextField(
    String tableText,
    TextEditingController controller,
    name,
    bool isReadOnly,
    String onSaved,
    FormFieldValidator<String> validation) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        controller: controller,
        readOnly: isReadOnly,
        style: inputTextStyle13(),
        keyboardType: name,
        cursorColor: ColorResource.grey,
        decoration: InputDecoration(
          errorStyle: errorTextStyle(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.appColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.appColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: tableText,
          labelStyle: TextStyle(color: Colors.black, fontSize: 16),
        ),
        validator: validation,
        onSaved: (value) => onSaved = value!.trim(),
      ),
    ),
  );
}

Widget whiteTextFieldPhone(
    String tableText,
    TextEditingController controller,
    name,
    bool isReadOnly,
    String onSaved,
    FormFieldValidator<String> validation) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        style: inputTextStyle13(),
        keyboardType: name,
        cursorColor: ColorResource.grey,
        // inputFormatters: [
        //   MaskTextInputFormatter(mask: "(###) ###-####"),
        // ],
        decoration: InputDecoration(
          errorStyle: errorTextStyle(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.appColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.appColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: tableText,
          labelStyle: TextStyle(color: Colors.black, fontSize: 16),
        ),
        validator: validation,
        onSaved: (value) => onSaved = value!.trim(),
      ),
    ),
  );
}

Widget whiteSearchBox(String tableText, TextEditingController controller) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
          controller: controller,
          style: (TextStyle(color: ColorResource.black, fontSize: 18)),
          keyboardType: TextInputType.text,
          cursorColor: ColorResource.grey,
          decoration: InputDecoration(
            fillColor: ColorResource.searchBackColor,
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            prefixIcon: IconButton(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              onPressed: () {},
            ),
            suffixIcon: InkWell(
                onTapCancel: () {},
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/cancel.svg'),
                  onPressed: () {},
                )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            hintText: tableText,
            labelStyle: TextStyle(color: Colors.black, fontSize: 16),
          )),
    ),
  );
}

Widget grayBorderTextField(String tableText) {
  return Container(
      alignment: Alignment.centerLeft,
      child: Theme(
        data: new ThemeData(
          primaryColor: Colors.grey,
        ),
        child: new TextField(
          cursorColor: ColorResource.grey,
          enabled: true,
          style: TextStyle(color: ColorResource.black, fontSize: 18),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            labelText: tableText,
            labelStyle: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      )
      /*  decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),

            labelText: tableText,
            labelStyle: TextStyle(color: Colors.black, fontSize: 16),
          )),*/

      );
}

Widget whiteSearchKeywordBox(
    String tableText, TextEditingController controller) {
  return Container(
    height: 45,
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: ColorResource.grey,
      ),
      child: TextFormField(
          controller: controller,
          style: (TextStyle(color: ColorResource.black, fontSize: 16)),
          keyboardType: TextInputType.text,
          cursorColor: ColorResource.grey,
          decoration: InputDecoration(
            fillColor: ColorResource.searchBackColor,
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            hintText: tableText,
          )),
    ),
  );
}

Widget whiteSearchKeywordBoxforObservation(
    String tableText,
    TextEditingController controller,
    ValueChanged<String> onChanged,
    String labelText) {
  return Container(
    height: 45,
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: ColorResource.grey,
      ),
      child: TextFormField(
        controller: controller,
        style: (TextStyle(color: ColorResource.black, fontSize: 16)),
        keyboardType: TextInputType.text,
        cursorColor: ColorResource.grey,
        decoration: InputDecoration(
            fillColor: ColorResource.searchBackColor,
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            hintText: tableText,
            labelText: labelText),
        onChanged: onChanged,
      ),
    ),
  );
}

Widget whiteReadOnlyTextBox(
    String tableText, TextEditingController controller) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: ColorResource.grey,
      ),
      child: SizedBox(
        child: TextFormField(
            readOnly: true,
            controller: controller,
            style: (TextStyle(color: ColorResource.black, fontSize: 16)),
            keyboardType: TextInputType.text,
            cursorColor: ColorResource.grey,
            decoration: InputDecoration(
              fillColor: ColorResource.searchBackColor,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              hintText: tableText,
            )),
      ),
    ),
  );
}

Widget whiteReadOnlyTextBoxforObservation(
    String tableText, TextEditingController controller, onchanged) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: ColorResource.grey,
      ),
      child: SizedBox(
        child: TextFormField(
          readOnly: true,
          controller: controller,
          style: (TextStyle(color: ColorResource.black, fontSize: 16)),
          keyboardType: TextInputType.text,
          cursorColor: ColorResource.grey,
          decoration: InputDecoration(
            fillColor: ColorResource.searchBackColor,
            contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            hintText: tableText,
          ),
          onChanged: onchanged,
        ),
      ),
    ),
  );
}

Widget whiteTextFieldForDiscount(
    String tableText,
    TextEditingController controller,
    name,
    bool isReadOnly,
    String onSaved,
    FormFieldValidator<String> validation,
    onchange) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Theme(
      data: new ThemeData(
        primaryColor: Color(0xffbbbbbb),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        style: inputTextStyle13(),
        keyboardType: name,
        cursorColor: ColorResource.grey,
        onChanged: onchange,
        decoration: InputDecoration(
          errorStyle: errorTextStyle(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.appColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.appColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          labelText: tableText,
          labelStyle: TextStyle(color: Colors.black, fontSize: 16),
        ),
        validator: validation,
        // onSaved: (value) => onSaved = value.trim(),
      ),
    ),
  );
}

Widget squareBoxTextField(TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.multiline,
    minLines: 2,
    maxLines: 5,
    decoration: InputDecoration(
      errorStyle: errorTextStyle(),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResource.appColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResource.appColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      labelText: "",
      labelStyle: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}
