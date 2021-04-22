import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:employment_app/my_packages/custom_country_state_city.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:country_state_city_picker/country_state_city_picker.dart';

class CountryStateCityView extends StatefulWidget {
  CountryStateCityView({Key key,this.selectedCountry,this.selectedState,this.selectedCity}) : super(key: key);

  String selectedCountry;
  String selectedState;
  String selectedCity;

  @override
  _CountryStateCityViewState createState() => _CountryStateCityViewState();
}

class _CountryStateCityViewState extends State<CountryStateCityView> {


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [

      ],
    ));
  }

  clearCountry(){
    setState(() {
      widget.selectedCountry=null;
      widget.selectedState=null;
      widget.selectedCity=null;
    });

  }
}
