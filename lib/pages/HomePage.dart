import 'package:bkn_cashbook_app/constant/route_constants.dart';
import 'package:bkn_cashbook_app/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
            child: Column(
          children: [
            Text(
              "Laporan Keuangan Bulan Ini",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Total Pengeluaran: \Rp $totalExpense",
              
            ),
            Text("Total Pemasukan: \Rp $totalIncome",
              
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/gambar.png', height: 250, width: 450),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/income.png',
                        label: "Tambah Pemasukan",
                        onTap: () {
                          Navigator.pushNamed(context, addIncomeRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/expense.png',
                        label: "Tambah Pengeluaran",
                        onTap: () {
                          Navigator.pushNamed(context, addExpenseRoute);
                        }),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/lists.png',
                        label: "Detail Cash Flow",
                        onTap: () {
                          Navigator.pushNamed(context, detailCashFlowRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/settings.png',
                        label: "Pengaturan",
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        }),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
