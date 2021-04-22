import 'package:employment_app/globals/validation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'custom_status_model.dart' as CustomStatusModel;
import 'package:employment_app/style/Style.dart';

class CustomSelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final ValueChanged<String> onClear;
  final TextStyle style;
  final Color dropdownColor;

  const CustomSelectState(
      {Key key,
      this.onCountryChanged,
      this.onStateChanged,
      this.onCityChanged,
        this.onClear,
      this.style,
      this.dropdownColor})
      : super(key: key);

  @override
  _CustomSelectStateState createState() => _CustomSelectStateState();
}

final formCountry = GlobalKey<FormState>();

class _CustomSelectStateState extends State<CustomSelectState> {
  List<String> _cities = ["Choose City"];
  List<String> _country = ["Choose Country"];
  String selectedCity = "Choose City";
  String selectedCountry = "Choose Country";
  String selectedState = "Choose State";
  List<String> _states = ["Choose State"];
  var responses;

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString(
        // 'packages/country_state_city_picker/lib/assets/country.json');
        'lib/assets/json/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    countryres.forEach((data) {
      var model = CustomStatusModel.CustomStatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) return;
      setState(() {
        _country.add(model.emoji + "    " + model.name);
      });
    });

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => CustomStatusModel.CustomStatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      if (!mounted) return;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          print(statename.toString());

          _states.add(statename.toString());
        }
      });
    });

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => CustomStatusModel.CustomStatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      selectedState = "Choose State";
      _states = ["Choose State"];
      selectedCountry = value;
      this.widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      selectedCity = "Choose City";
      _cities = ["Choose City"];
      selectedState = value;
      this.widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      selectedCity = value;
      this.widget.onCityChanged(value);
    });
  }

  void onClear(){
    setState(() {
      selectedCountry=null;
      selectedState=null;
      selectedCity=null;
    });
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formCountry,
    child:
       Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Container(
           child:
               Text('Country', style: regularPrimaryColorSemiBold()),
         ),
         SizedBox(
           height: screenHeight(context) * 0.005,
         ),
        DropdownButtonFormField<String>(
          dropdownColor: widget.dropdownColor,
          isExpanded: true,
          validator: (value) => value==null?"Please select":null,
          items: _country.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Row(
                children: [
                  Text(
                    dropDownStringItem,
                    style: widget.style,
                  )
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => _onSelectedCountry(value),
          value: selectedCountry,
        ),
        SizedBox(
          height: screenHeight(context)*0.035,
        ),
        Container(
          child:
          Text('State', style: regularPrimaryColorSemiBold()),
        ),
        SizedBox(
          height: screenHeight(context) * 0.005,
        ),
        DropdownButtonFormField<String>(
          dropdownColor: widget.dropdownColor,
          isExpanded: true,
          validator: (value) => value==null?"Please select":null,
          items: _states.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem, style: widget.style),
            );
          }).toList(),
          onChanged: (value) => _onSelectedState(value),
          value: selectedState,
        ),
        SizedBox(
          height: screenHeight(context)*0.035,
        ),
        Container(
          child:
          Text('City', style: regularPrimaryColorSemiBold()),
        ),
        SizedBox(
          height: screenHeight(context) * 0.005,
        ),
        DropdownButtonFormField<String>(
          dropdownColor: widget.dropdownColor,
          isExpanded: true,
          validator: (value) => value==null?"Please select":null,
          items: _cities.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem, style: widget.style),
            );
          }).toList(),
          onChanged: (value) => _onSelectedCity(value),
          value: selectedCity,
        ),
      ],
    )
    );
  }
}
