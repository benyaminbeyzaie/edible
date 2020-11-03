import 'package:edible/constants/strings.dart';
import 'package:edible/features/edible/presentation/widgets/add_edibles_list.dart';

import '../../data/models/edible_model.dart';
import '../manager/edible_bloc.dart';
import 'edible_info_page.dart';
import '../widgets/app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEdiblePage extends StatefulWidget {
  @override
  _AddEdiblePageState createState() => _AddEdiblePageState();
}

class _AddEdiblePageState extends State<AddEdiblePage> {
  List<EdibleModel> showingEdibleModel;
  @override
  void initState() {
    BlocProvider.of<EdibleBloc>(context).add(GetEdiblesData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<EdibleBloc>(context).add(GetHomeEdibles());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: AppBarTitle(),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (value) {
              BlocProvider.of<EdibleBloc>(context).add(SearchByName(value));
            },
            //controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          ),
        ),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildList() {
    return BlocConsumer<EdibleBloc, EdibleState>(listener: (context, state) {
      print(state.status.toString());
    }, builder: (context, state) {
      if (state.status == EdibleStateStatus.LOADING ||
          state.status == EdibleStateStatus.PURE) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.status == EdibleStateStatus.ERROR) {
        return Center(child: Text(state.message));
      } else {
        if (state.showingEdibles == null) {
          return Center(child: Text(Strings.tryAgainLater));
        }
        if (state.showingEdibles.length == 0) {
          return Center(
            child: Text(
              Strings.notFounded,
            ),
          );
        }
        //return Center();
        return EdibleItem(edibles: state.showingEdibles);
      }
    });
  }
}
