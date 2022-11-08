import 'package:equatable/equatable.dart';

abstract class TaxonomyEvent extends Equatable{
  @override
  List<Object> get props =>[];
}
class TaxonomyFetched extends TaxonomyEvent{}