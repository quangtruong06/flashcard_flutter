import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flashcard_flutter/bloc/taxonomy_bloc/taxonomy_event.dart';
import 'package:flashcard_flutter/bloc/taxonomy_bloc/taxonomy_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../utils/Globals.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class TaxonomyData extends Equatable{
  final int? taxonomyId, totalFlashCards;
  final String? name, imageUrl;
  const TaxonomyData({
    required this.name,required this.imageUrl,required this.totalFlashCards,required this.taxonomyId
});
  @override
  List<Object?> get props => [taxonomyId,totalFlashCards,name,imageUrl];
}
const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
class TaxonomyBloc extends Bloc<TaxonomyEvent,TaxonomyState>{
  final http.Client httpClient;

  TaxonomyBloc({required this.httpClient}):super(const TaxonomyState()){
    on<TaxonomyFetched>(onTaxonomyFetch,transformer: throttleDroppable(throttleDuration));
  }
  Future<void> onTaxonomyFetch(TaxonomyFetched event,Emitter<TaxonomyState> emit)async{
    if(state.hasReachedMax) return;
    try{
      if(state.status == TaxnomomyStatus.initial){
        final taxonomies = await fetchedTaxonomies();
        return emit(state.copyWith(status: TaxnomomyStatus.success,taxonomy: taxonomies,hasReachedMax: false));
      }
      final taxonomies = await fetchedTaxonomies(state.taxonomy.length);
      taxonomies.isEmpty? emit(state.copyWith(hasReachedMax: true)): emit(state.copyWith(
        status: TaxnomomyStatus.success,taxonomy: List.of(state.taxonomy)..addAll(taxonomies),hasReachedMax: false
      ));
    }catch(_){
      emit(state.copyWith(status: TaxnomomyStatus.failure));
    }
  }
  Future<List<TaxonomyData>> fetchedTaxonomies([int startIndex = 0])async{
    final respone = await http.get(Uri.parse(API_TAXONOMIES,));
    if (respone.statusCode == 200) {
      List data = jsonDecode(respone.body);
      return data.map((dynamic json) {
        final map = json as Map<String,dynamic>;
        return TaxonomyData( name: map['Name'],
            imageUrl: map['ImageUrl'],
            totalFlashCards: map['TotalFlashCards'],
            taxonomyId: map['TaxonomyId']);
      }).toList();
    } else {
      throw Exception("Data not found");
    }
  }
}