class PaginatedResponse<T> {
  final int totalCount;
  final List<T> data;

  PaginatedResponse(this.totalCount, this.data);
}
