// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:evently/data/auth/auth_remote_data_source.dart' as _i1036;
import 'package:evently/data/auth/auth_repository_impl.dart' as _i827;
import 'package:evently/data/auth/users_remote_data_source.dart' as _i591;
import 'package:evently/data/events/events_remote_data_source.dart' as _i967;
import 'package:evently/data/events/events_repository_impl.dart' as _i35;
import 'package:evently/domain/repositories/auth_repository.dart' as _i557;
import 'package:evently/domain/repositories/events_repository.dart' as _i91;
import 'package:evently/models/event.dart' as _i210;
import 'package:evently/providers/my_user_provider.dart' as _i601;
import 'package:evently/services/geocoding_service.dart' as _i856;
import 'package:evently/services/location_service.dart' as _i717;
import 'package:evently/ui/auth/login_view/cubit/login_cubit.dart' as _i176;
import 'package:evently/ui/auth/register_view/cubit/register_cubit.dart'
    as _i66;
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_cubit.dart'
    as _i171;
import 'package:evently/ui/home_view/add_event_view/view_model/pick_location_view_model.dart'
    as _i420;
import 'package:evently/ui/home_view/cubit/favorites_cubit.dart' as _i1028;
import 'package:evently/ui/home_view/my_events_view/cubit/my_events_cubit.dart'
    as _i476;
import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_cubit.dart'
    as _i816;
import 'package:evently/ui/home_view/tab/home_tab/cubit/home_tab_cubit.dart'
    as _i850;
import 'package:evently/ui/home_view/tab/map_tab/view_model/map_tab_view_model.dart'
    as _i1055;
import 'package:evently/ui/home_view/view_model/user_location_view_model.dart'
    as _i593;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1036.AuthRemoteDataSource>(
      () => _i1036.AuthRemoteDataSource(),
    );
    gh.lazySingleton<_i591.UsersRemoteDataSource>(
      () => _i591.UsersRemoteDataSource(),
    );
    gh.lazySingleton<_i967.EventsRemoteDataSource>(
      () => _i967.EventsRemoteDataSource(),
    );
    gh.lazySingleton<_i856.GeocodingService>(() => _i856.GeocodingService());
    gh.lazySingleton<_i717.LocationService>(() => _i717.LocationService());
    gh.factory<_i420.PickLocationViewModel>(
      () => _i420.PickLocationViewModel(
        gh<_i717.LocationService>(),
        gh<_i856.GeocodingService>(),
      ),
    );
    gh.factory<_i593.UserLocationViewModel>(
      () => _i593.UserLocationViewModel(gh<_i717.LocationService>()),
    );
    gh.lazySingleton<_i91.EventsRepository>(
      () => _i35.EventsRepositoryImpl(gh<_i967.EventsRemoteDataSource>()),
    );
    gh.lazySingleton<_i557.AuthRepository>(
      () => _i827.AuthRepositoryImpl(
        gh<_i1036.AuthRemoteDataSource>(),
        gh<_i591.UsersRemoteDataSource>(),
      ),
    );
    gh.factory<_i601.MyUserProvider>(
      () => _i601.MyUserProvider(gh<_i557.AuthRepository>()),
    );
    gh.factory<_i176.LoginCubit>(
      () => _i176.LoginCubit(gh<_i557.AuthRepository>()),
    );
    gh.factory<_i66.RegisterCubit>(
      () => _i66.RegisterCubit(gh<_i557.AuthRepository>()),
    );
    gh.factory<_i1028.FavoritesCubit>(
      () => _i1028.FavoritesCubit(gh<_i91.EventsRepository>()),
    );
    gh.factory<_i476.MyEventsCubit>(
      () => _i476.MyEventsCubit(gh<_i91.EventsRepository>()),
    );
    gh.factory<_i850.HomeTabCubit>(
      () => _i850.HomeTabCubit(gh<_i91.EventsRepository>()),
    );
    gh.factoryParam<_i171.AddEventCubit, _i210.Event?, dynamic>(
      (eventToEdit, _) =>
          _i171.AddEventCubit(gh<_i91.EventsRepository>(), eventToEdit),
    );
    gh.factoryParam<_i816.EventDetailsCubit, _i210.Event, dynamic>(
      (event, _) => _i816.EventDetailsCubit(
        gh<_i91.EventsRepository>(),
        gh<_i856.GeocodingService>(),
        event,
      ),
    );
    gh.factory<_i1055.MapTabViewModel>(
      () => _i1055.MapTabViewModel(
        gh<_i717.LocationService>(),
        gh<_i91.EventsRepository>(),
        gh<_i856.GeocodingService>(),
      ),
    );
    return this;
  }
}
