import 'package:flutter/material.dart';
import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:expense_tracker/core/enums/viewstate.dart';
import 'package:expense_tracker/core/viewmodels/home_model.dart';
import 'package:expense_tracker/ui/views/base_view.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/app_drawer.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/app_fab.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/app_bar_title_widget.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/empty_transaction_widget.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/month_year_picker_widget.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/summary_widget.dart';
import 'package:expense_tracker/ui/widgets/home_view_widgets/transactions_listview_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(
          model.appBarTitle, // Ensure appBarTitle is passed correctly
          model,
        ),
        drawer: AppDrawer(context, key: UniqueKey()),
        floatingActionButton: Visibility(
          visible: model.show,
          child: AppFAB(
            model.closeMonthPicker,
            onPressed: () {}, // Add onPressed callback for AppFAB
          ),
        ),
        body: model.state == ViewState.busy
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SummaryWidget(
                        income: model.incomeSum,
                        expense: model.expenseSum,
                      ),
                      buildList(
                        model.transactions
                            .cast<Transaction>(), // Correct type casting
                        model,
                      ),
                    ],
                  ),
                  model.isCollapsed
                      ? PickMonthOverlay(
                          model: model,
                          showOrHide: model.isCollapsed,
                          context: context,
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }

  AppBar buildAppBar(String? title, HomeModel model) {
    // AppBar construction with nullable title
    return AppBar(
      title: AppBarTitle(
        title: title ?? 'Default Title', // Fallback title if null
        model: model,
        key: const Key('Home_Model'),
      ),
    );
  }

  Widget buildList(List<Transaction> transactions, HomeModel model) {
    // Ensure transactions and model are passed correctly
    return transactions.isEmpty
        ? EmptyTransactionsWidget(
            key: UniqueKey(),
          )
        : TransactionsListView(
            transactions: transactions, // Pass transactions to the list view
            model: model, // Pass model to the list view
            key: UniqueKey(), // Optional key for uniqueness
          );
  }
}
