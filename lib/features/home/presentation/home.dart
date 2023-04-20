import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/const/const.dart';
import '../../../core/utils/text_style.dart';
import '../../../injector.dart';
import '../../dashboard/presentation/bloc/breaking_news/breaking_news_bloc.dart';
import '../../dashboard/presentation/bloc/top_news/top_news_bloc.dart';
import '../../dashboard/presentation/dashboard.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BreakingNewsBloc>(
          create: (context) => sl<BreakingNewsBloc>()..add(const BreakingNewsRequested()),
        ),
        BlocProvider<TopNewsBloc>(
          create: (context) => sl<TopNewsBloc>()..add(TopNewsRequested(category: categoryStringList.first)),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() =>
      HomeScreenState();
}

class HomeScreenState
    extends State<HomeScreen> {

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 43, vertical: 20);

  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color selectedColor = AppColors.brown;
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];


  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DashBoard(),
    SizedBox(child: Container(
      width: double.infinity,
      height: 30000,
      color: Colors.green,
    )),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: SnakeNavigationBar.color(
          height: 66,
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          elevation: 4,
          ///configuration for SnakeNavigationBar.color
          snakeViewColor: const Color(0xFFE0E0E0),
          selectedItemColor:
          snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: unselectedColor,

          ///configuration for SnakeNavigationBar.gradient
          // snakeViewGradient: selectedGradient,
          // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
          // unselectedItemGradient: unselectedGradient,

          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,

          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/home_icon.svg',
                  semanticsLabel: 'home_icon',
                  colorFilter: ColorFilter.mode(_selectedIndex == 0? AppColors.red : AppColors.navBarText, BlendMode.srcIn)
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/favorite_icon.svg',
                  semanticsLabel: 'favorite_icon',
                  colorFilter: ColorFilter.mode(_selectedIndex == 1? AppColors.red : AppColors.navBarText, BlendMode.srcIn)
                ),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/profile_icon.svg',
                  semanticsLabel: 'profile_icon',
                  colorFilter: ColorFilter.mode(_selectedIndex == 2? AppColors.red : AppColors.navBarText, BlendMode.srcIn)
                ),
                label: 'Profile'),
          ],
          selectedLabelStyle: navBar.copyWith(color: AppColors.brown),
          unselectedLabelStyle: navBar,
        ),
      ),
    );
  }
}
