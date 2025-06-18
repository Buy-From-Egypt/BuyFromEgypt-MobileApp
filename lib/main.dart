import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/auth_utils.dart';

import 'package:buy_from_egypt/features/splash/presentation/views/splash_view.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/views/onboarding_screens.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/auth_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/forget_password_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/otp_forget_password.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/update_password_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/successfully_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/preference_view.dart';
import 'package:buy_from_egypt/features/auth/presentation/views/pending_view.dart';

import 'package:buy_from_egypt/features/home/presentation/views/home_view.dart';
import 'package:buy_from_egypt/features/home/presentation/views/search_view.dart';
<<<<<<< HEAD
import 'package:buy_from_egypt/features/home/presentation/views/comment_view_im.dart';

import 'package:buy_from_egypt/features/home/presentation/view_model/post/post_repo_impl.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/post_cubit.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/cubit/create_post_cubit.dart';
=======
import 'package:buy_from_egypt/features/home/presentation/views/history_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/add_product_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/filter_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/market_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/order1_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/order2_view.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/save_view.dart';
import 'package:buy_from_egypt/features/onboarding/presentation/views/onboarding_screens.dart';
import 'package:buy_from_egypt/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
>>>>>>> 288028117915110d954381bc5d89feb102691a49

final logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 تثبيت التطبيق في الوضع العمودي
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 🔧 تخصيص شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // 📦 تهيئة الخدمات
  await initializeApp();

  // 📤 مشاركة الريبو بين PostCubit و CreatePostCubit
  final postRepo = PostRepoImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => PostCubit(postRepo: postRepo)..fetchPosts()),
        BlocProvider(create: (_) => CreatePostCubit(postRepo: postRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initializeApp() async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      logger.w('No internet connection during initialization');
    }

    await AuthUtils.clearUserSession();

    logger.i('App initialized successfully');
  } catch (e) {
    logger.e('Error initializing app', error: e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buy From Egypt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: AppRoutes.splash,
<<<<<<< HEAD
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => const SplashView());
          case AppRoutes.auth:
            return MaterialPageRoute(builder: (_) => const AuthView());
          case AppRoutes.onboarding:
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case AppRoutes.forgetPassword:
            return MaterialPageRoute(
                builder: (_) => const ForgetPasswordView());
          case AppRoutes.otpForgetPassword:
            final args = settings.arguments as Map<String, dynamic>?;
            final email = args?['email'] as String?;
            if (email == null)
              return _errorRoute('Email is required for OTP verification');
            return MaterialPageRoute(
                builder: (_) => OtpForgetPassword(email: email));
          case AppRoutes.updatePassword:
            final args = settings.arguments as Map<String, dynamic>?;
            final email = args?['email'] as String?;
            if (email == null)
              return _errorRoute('Email is required for password update');
            return MaterialPageRoute(
                builder: (_) => UpdatePasswordView(email: email));
          case AppRoutes.successfully:
            return MaterialPageRoute(builder: (_) => const SuccessfullyView());
          case AppRoutes.preference:
            return MaterialPageRoute(builder: (_) => const PreferenceView());
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => const HomeView());
          case AppRoutes.search:
            return MaterialPageRoute(builder: (_) => const SearchView());
          case AppRoutes.pending:
            final args = settings.arguments as Map<String, dynamic>?;
            final email = args?['email'] as String?;
            if (email == null) return _errorRoute('Email is required');
            return MaterialPageRoute(builder: (_) => PendingView(email: email));
          case AppRoutes.comment:
            final args = settings.arguments;
            if (args is! String || args.isEmpty) {
              return _errorRoute('Post ID is required');
            }
            return MaterialPageRoute(
              builder: (_) => CommentViewIm(postId: args),
            );

          default:
            return _errorRoute('404 - Page Not Found');
        }
=======
      routes: {
        AppRoutes.splash: (context) => const SplashView(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.auth: (context) => const AuthView(),
        AppRoutes.home: (context) => const HomeView(),
        AppRoutes.market: (context) => MarketView(),
        AppRoutes.orders1: (context) => const Order1View(),
        AppRoutes.orders2: (context) => const Orders2View(),
        AppRoutes.forgetPassword: (context) => const ForgetPasswordView(),
        AppRoutes.updatePassword: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String?;
          if (email == null) {
            return const Scaffold(
              body: Center(child: Text('Email is required for password update')),
            );
          }
          return UpdatePasswordView(email: email);
        },
        AppRoutes.otpForgetPassword: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String?;
          if (email == null) {
            return const Scaffold(
              body: Center(child: Text('Email is required for OTP verification')),
            );
          }
          return OtpForgetPassword(email: email);
        },
        AppRoutes.successfully: (context) => const SuccessfullyView(),
        AppRoutes.preference: (context) => const PreferenceView(),
        AppRoutes.pending: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final email = args?['email'] as String?;
          if (email == null) {
            return const Scaffold(
              body: Center(child: Text('Email is required')),
            );
          }
          return PendingView(email: email);
        },
        AppRoutes.search: (context) => const SearchView(),
        AppRoutes.filter: (context)=> const FilterView(),
        AppRoutes.addProduct: (context) => const AddProductView(),
        AppRoutes.save: (context) =>  SaveView(),
        AppRoutes.history: (context) => const HistoryView(),
>>>>>>> 288028117915110d954381bc5d89feb102691a49
      },
    );
  }

  Route _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
