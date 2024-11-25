import 'package:cdbl/ui/dashboard/dashboard_items/change_password.dart';
import 'package:cdbl/ui/guest/about_us.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/faq.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/notices.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/contact_us.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/gallery.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/holidays.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/issuer_list.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/list_of_isin.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/more_page.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/news.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/downloads.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/queries.dart';
import 'package:cdbl/ui/guest/dashboard_items/e_services/email_notification.dart';
import 'package:cdbl/ui/guest/dashboard_items/e_services/online_balance.dart';
import 'package:cdbl/ui/guest/dashboard_items/e_services/sms.dart';
import 'package:cdbl/ui/guest/eservices.dart';
import 'package:cdbl/ui/guest/guest_dashboard.dart';
import 'package:cdbl/ui/guest/highlights.dart';
import 'package:cdbl/ui/holding/viewer.dart';
import 'package:cdbl/ui/profile/add_boid.dart';
import 'package:cdbl/ui/profile/bo_verification.dart';
import 'package:cdbl/ui/profile/modify_history.dart';
import 'package:cdbl/ui/profile/user_boid_list.dart';
import 'package:cdbl/ui/statement/statement_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:cdbl/ui/authentication/otp_verification.dart';
import 'package:cdbl/ui/authentication/register.dart';
import 'package:cdbl/ui/authentication/login.dart';
import 'package:cdbl/ui/dashboard/dashboard.dart';
import 'package:cdbl/ui/profile/user_profile.dart';
import 'package:cdbl/ui/holding/holding_list.dart';
import 'package:cdbl/ui/statement/statement.dart';
import 'package:cdbl/ui/holding/boid_list_holdings.dart';
import 'package:cdbl/ui/statement/boid_list_statement.dart';
import 'package:cdbl/ui/statement/isin_statement.dart';
import 'package:cdbl/ui/dashboard/dashboard_items/more/dps_list.dart';
import 'package:cdbl/ui/holding/holding_details.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => Login(),
  "/register": (BuildContext context) => Register(),
  "/verification": (BuildContext context) => Verification(),
  "/dashboard": (BuildContext context) => Dashboard(),
  "/user/profile": (BuildContext context) => UserProfileScreen(),
  "/balance/enquiry": (BuildContext context) => BalanceEnquiryScreen(),
  "/boid/list": (BuildContext context) => BOIDsPage(),
  "/boid/holdings": (BuildContext context) => BOIDsHoldings(),
  "/boid/statement": (BuildContext context) => BOIDsStatement(),
  "/statement": (BuildContext context) => StatementPage(),
  "/isin/statement": (BuildContext context) => IsinStatementScreen(),
  "/balance/details": (BuildContext context) => BalanceDetailsScreen(),
  "/downloads": (BuildContext context) => Downloads(),
  "/faq": (BuildContext context) => FAQ(),
  "/news": (BuildContext context) => News(),
  "/queries": (BuildContext context) => Queries(),
  "/more/options": (BuildContext context) => MoreItemsPage(),
  "/dps/list": (BuildContext context) => ListOfDPs(),
  "/isin/list": (BuildContext context) => IsinLists(),
  "/issuer": (BuildContext context) => IssuerList(),
  "/instructions": (BuildContext context) => Instructions(),
  "/holidays": (BuildContext context) => Holidays(),
  "/gallery": (BuildContext context) => Gallery(),
  "/contact": (BuildContext context) => ContactUs(),
  "/add/boid": (BuildContext context) => AddBoid(),
  "/boid/verification": (BuildContext context) => BoidVerification(),
  "/modify/history": (BuildContext context) => ModifyHistoryPage(),
  "/guest/dashboard": (BuildContext context) => GuestDashboard(),
  "/aboutus": (BuildContext context) => About_Us(),
  "/highlights": (BuildContext context) => Highlights(),
  "/eservices": (BuildContext context) => Eservices(),
  "/online/balance": (BuildContext context) => OnlineBalance(),
  "/sms": (BuildContext context) => SmsAlert(),
  "/email": (BuildContext context) => EmailNotification(),
  "/holding/viewer": (BuildContext context) => HoldingPdf(),
  "/statement/viewer": (BuildContext context) => StatementPdf(),
  "/change/password": (BuildContext context) => ChangePassword(),
};
