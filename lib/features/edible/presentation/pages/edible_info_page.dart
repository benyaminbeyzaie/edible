import 'package:edible/constants/colors.dart';
import 'package:edible/constants/strings.dart';
import 'package:edible/core/time/date.dart';
import 'package:edible/features/edible/presentation/widgets/edible_info_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/edible_model.dart';
import '../manager/edible_bloc.dart';
import '../widgets/app_bar_title.dart';
import 'home_page.dart';

class EdibleInfoPage extends StatefulWidget {
  final EdibleModel edibleModel;

  EdibleInfoPage({this.edibleModel});

  @override
  _EdibleInfoPageState createState() => _EdibleInfoPageState();
}

class _EdibleInfoPageState extends State<EdibleInfoPage> {
  double _scoreYouGet = 0.0;
  var _selectedUnit = 'gram';
  var _selectedUnitIndex = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.edibleModel.units);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.edibleModel.name,
                style: TextStyle(
                  fontSize: 32.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  width: 10.0,
                  height: 40.0,
                  color: mainColor,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  Strings.score + _scoreYouGet.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    Strings.amount,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildTextField(),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  flex: 2,
                  child: _buildDropdownButton(),
                ),
              ],
            ),
            Expanded(
              flex: 8,
              child: EdibleInfoList(
                nutritionalData: widget.edibleModel.nutritionalData,
                selectedUnit: _selectedUnitIndex,
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildAddButton(context),
            )
          ],
        ),
      ),
    );
  }

  MaterialButton _buildAddButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      color: mainColor,
      child: Text(
        Strings.add,
        style: TextStyle(color: onBackgroundColor, fontSize: 18.0),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
        BlocProvider.of<EdibleBloc>(context).add(AddEdibleToUserDataBaseEvent(
            amount: _controller.text,
            date: Today.getDate(),
            edibleModel: widget.edibleModel,
            points: _scoreYouGet));
      },
    );
  }

  DropdownButton<String> _buildDropdownButton() {
    return DropdownButton<String>(
      value: _selectedUnit,
      icon: Icon(Icons.arrow_downward),
      isExpanded: true,
      iconSize: 20,
      elevation: 16,
      style: TextStyle(color: darkColor),
      underline: Container(
        height: 2,
        color: darkColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          _selectedUnit = newValue;
          _selectedUnitIndex = widget.edibleModel.units.indexOf(_selectedUnit);
        });
      },
      items: widget.edibleModel.units
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  TextField _buildTextField() {
    return TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _scoreYouGet =
              widget.edibleModel.pointsPerSmallestSteps[_selectedUnitIndex] *
                  (int.parse(value) /
                      widget.edibleModel.smallestSteps[_selectedUnitIndex]);
          setState(() {});
        },
        decoration:
            InputDecoration(contentPadding: EdgeInsets.only(bottom: -20.0)));
  }
}
