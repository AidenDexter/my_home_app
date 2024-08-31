import 'package:json_annotation/json_annotation.dart';

import '../../../search/domain/entity/search_response.dart';

part 'home_response.g.dart';

@JsonSerializable(createToJson: false)
class HomeResponse {
  HomeResponse({
    required this.data,
    required this.success,
  });

  final List<Sections>? data;
  final bool? success;

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    final sections = <Sections>[];
    for (final section in json['data'] as List<dynamic>) {
      if ((section as Map<String, dynamic>)['type'] == 'dev_projects') continue;
      if (section['type'] == 'myhome_services') continue;
      if (section['type'] == 'livo_auction') continue;
      sections.add(Sections.fromJson(section));
    }
    return HomeResponse(
      data: sections,
      success: json['success'] as bool?,
    );
  }
}

@JsonSerializable(createToJson: false)
class Sections {
  Sections({
    required this.type,
    required this.children,
  });

  final String type;
  final List<SearchItem> children;

  factory Sections.fromJson(Map<String, dynamic> json) => _$SectionsFromJson(json);
}
