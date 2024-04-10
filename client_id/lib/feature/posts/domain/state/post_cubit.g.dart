// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostStateImpl _$$PostStateImplFromJson(Map<String, dynamic> json) =>
    _$PostStateImpl(
      postList: (json['postList'] as List<dynamic>?)
              ?.map((e) => PostEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PostStateImplToJson(_$PostStateImpl instance) =>
    <String, dynamic>{
      'postList': instance.postList,
    };
