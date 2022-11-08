import 'package:equatable/equatable.dart';
import 'package:flashcard_flutter/bloc/taxonomy_bloc/taxonomy_bloc.dart';

enum TaxnomomyStatus { initial, success, failure }

class TaxonomyState extends Equatable {
  final TaxnomomyStatus status;
  final List<TaxonomyData> taxonomy;
  final bool hasReachedMax;

  const TaxonomyState(
      {this.status = TaxnomomyStatus.initial,
      this.taxonomy = const <TaxonomyData>[],
      this.hasReachedMax = false});

  TaxonomyState copyWith({
    TaxnomomyStatus? status,
    List<TaxonomyData>? taxonomy,
    bool? hasReachedMax,
  }) {
    return TaxonomyState(
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        taxonomy: taxonomy ?? this.taxonomy);
  }

  @override
  String toString() {
    return '''TaxonomyState { status: $status, hasReachedMax: $hasReachedMax, taxonomy: ${taxonomy.length} }''';
  }

  @override
  List<Object?> get props => [status, taxonomy, hasReachedMax];
}
