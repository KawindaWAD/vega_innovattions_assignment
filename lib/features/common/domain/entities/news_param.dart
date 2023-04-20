/// Parameter that need to send within news api
class NewsParams {
  final String? country;
  final String? category;
  final String? q;
  final String? sortBy;
  final int? pageSize;
  final int page;

  const NewsParams({
    this.country,
    this.category,
    this.q,
    this.sortBy,
    this.pageSize = 20,
    required this.page,
  });

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'category': category,
      'q': q,
      'sortBy': sortBy,
      'pageSize': pageSize,
      'page': page,
    };
  }

  factory NewsParams.fromMap(Map<String, dynamic> map) {
    return NewsParams(
      country: map['country'],
      category: map['category'],
      q: map['q'],
      sortBy: map['sortBy'],
      pageSize: map['pageSize'] as int,
      page: map['page'] as int,
    );
  }
}