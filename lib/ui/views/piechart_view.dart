import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/enums/viewstate.dart';
import 'package:expense_tracker/core/viewmodels/piechart_model.dart';
import 'package:expense_tracker/ui/views/base_view.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PieChartModel>(
      onModelReady: (model) => model.init(true),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Chart'),
        ),
        body: model.state == ViewState.busy
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: <Widget>[
                        ChipsChoice<int>.single(
                          value: model.selectedMonthIndex,
                          onChanged: (val) => model.changeSelectedMonth(val),
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: model.months,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                        ),
                        ChipsChoice<int>.single(
                          value: model.type == 'income' ? 0 : 1,
                          onChanged: (val) => model.changeType(val),
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: model.types,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                        ),
                        model.dataMap.isEmpty
                            ? const Text('No Data for this month')
                            : PieChart(dataMap: model.dataMap),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
