import 'package:edible/constants/colors.dart';
import 'package:edible/core/time/date.dart';
import 'package:edible/features/edible/presentation/widgets/add_floating_action_button.dart';
import 'package:edible/features/edible/presentation/widgets/eaten_edible_item.dart';

import '../../../../constants/strings.dart';
import 'package:intl/intl.dart';
import '../../data/models/user_model.dart';
import '../manager/edible_bloc.dart';
import 'add_edible_page.dart';
import '../widgets/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<EdibleBloc>(context).add(GetHomeEdibles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: AppBarTitle(),
      ),
      floatingActionButton: AddFloatingActionButton(
        onPressed: () {
          BlocProvider.of<EdibleBloc>(context).add(GoToEdiblePageEvent());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEdiblePage()),
          );
        },
      ),
      body: BlocConsumer<EdibleBloc, EdibleState>(
        listener: (context, state) {
          print(state.status);
        },
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, EdibleState state) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHomePageTitle(),
          SizedBox(
            height: 10.0,
          ),
          _buildScoreRow(state),
          SizedBox(
            height: 10.0,
          ),
          _buildHomePageEdibleList(state),
        ],
      ),
    );
  }

  Row _buildScoreRow(EdibleState state) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: mainColor,
          radius: 5.0,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          Strings.todayScore +
              (state.status == EdibleStateStatus.LOADED
                  ? state.user.todayPoint.toStringAsFixed(2)
                  : '...'),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget _buildHomePageEdibleList(EdibleState state) {
    if (state.status == EdibleStateStatus.LOADING ||
        state.status == EdibleStateStatus.PURE) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.status == EdibleStateStatus.ERROR) {
      return Center(child: Text(Strings.errorMessage));
    }
    return Expanded(
      child: ListView(
        children: _makeItems(state.user),
      ),
    );
  }

  List<Widget> _makeItems(UserModel model) {
    List<Widget> list = List();
    for (int i = model.amounts.length - 1; i >= 0; i--) {
      if (model.dates.elementAt(i) == Today.getDate())
        list.add(
          EatenEdibleItem(
            name: model.edibles.elementAt(i).name,
            amount: model.amounts.elementAt(i),
            point: model.points.elementAt(i),
          ),
        );
    }
    return list;
  }

  Container _buildHomePageTitle() {
    return Container(
      child: Text(
        Strings.headerQuestion,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
