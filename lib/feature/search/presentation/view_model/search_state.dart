import 'package:e_commerce_app/feature/search/domain/entities/search_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<SearchEntity> products;

  SearchSuccess({required this.products});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
