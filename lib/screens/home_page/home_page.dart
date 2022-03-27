import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoviz_assign/global_widgets/top_navigation_button.dart';
import 'package:infoviz_assign/screens/about_page/about_page.dart';
import 'package:infoviz_assign/screens/home_page/bloc/crypto_data_bloc.dart';
import 'package:infoviz_assign/global_helper.dart';
import 'package:infoviz_assign/global_widgets/info_tooltip.dart';
import 'package:infoviz_assign/screens/home_page/widgets/cartesian_graphs_section.dart';
import 'package:infoviz_assign/screens/home_page/widgets/homepage_header.dart';
import 'package:infoviz_assign/screens/home_page/widgets/price_stats_widget.dart';
import 'package:infoviz_assign/screens/home_page/widgets/pricing_stats_section.dart';
import 'package:infoviz_assign/screens/home_page/widgets/semantics_percentage_section.dart';
import 'package:infoviz_assign/screens/home_page/widgets/semantics_radial_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get data from backend
    final _cryptoBloc = CryptoDataBloc();
    _cryptoBloc.add(GetCryptoData());
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _cryptoBloc),
        ],
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            decoration: const BoxDecoration(
              color: Color(0xFF000D19),
            ),
            child: BlocBuilder<CryptoDataBloc, CryptoDataState>(
              builder: (context, state) {
                if (state is CryptoDataLoading || state is CryptoDataInitial) {
                  return SizedBox(
                    height: height,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is CryptoDataLoaded) {
                  return const LoadedUI();
                } else if (state is CryptoDataError) {
                  return SizedBox(
                    height: height,
                    child: const Center(
                      child: Text(
                        "Error. Try again later.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: height,
                    child: const Center(
                      child: Text(
                        "No corresponding BLOC state",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoadedUI extends StatelessWidget {
  const LoadedUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          TopNavigationButton(
            text: 'Home',
            onPressed: (() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                )),
          ),
          const Spacer(),
          TopNavigationButton(
            text: 'About',
            onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                )),
          ),
        ],
      ),
      const SizedBox(height: 20),
      const HomepageHeader(),
      const SizedBox(height: 40),
      const CartesianGraphsSection(),
      const SizedBox(height: 25),
      const SemanticsPercentageSection(),
      const SizedBox(height: 30),
      const PricingStatsSection(),
      const SizedBox(height: 80),
      const Align(
        alignment: Alignment.topRight,
        child: Text(
          'Powered by CoinGecko API and Twitter API',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }
}
