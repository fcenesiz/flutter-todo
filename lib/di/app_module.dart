import 'package:todo/domain/util/db_helper.dart';

class AppModule{

  static final DbHelper _dbHelper = DbHelper();
  static DbHelper get dbHelper => _dbHelper;

}