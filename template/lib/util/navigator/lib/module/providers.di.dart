import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/navigator/lib/routers/router.dart';

import '../routers/go_router/go_router.strategy.dart';

final routerProvider = Provider<AppRouter>((ref) => GoRouterStrategy());
