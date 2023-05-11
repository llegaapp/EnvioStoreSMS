class PaginationFilter {
  int? skip;
  int? limit;

  @override
  String toString() => 'PaginationFilter(skip: $skip, limit: $limit)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationFilter && o.skip == skip && o.limit == limit;
  }

  @override
  int get hashCode => skip.hashCode ^ limit.hashCode;
}
