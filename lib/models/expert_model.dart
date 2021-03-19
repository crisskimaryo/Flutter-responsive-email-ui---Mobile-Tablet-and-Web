import 'package:flutter/foundation.dart';

class ExpertModel {
  final String id;
  final String name;
  final String businessName;
  final String userType;
  final String profileImageUrl;
  final String email;
  final String phone;
  final String bio;
  final bool status;
  final int chats;
  final dynamic onCreated;
  final String experience;
  final List category;
  final List categories;
  String categoryString;
  final bool approved;

  final int totalPost;
  final int totalReview;
  final int clientRate;
  final String clientReview;
  final dynamic rateCreated;
  final dynamic rating;
  final int followers;
  final bool following;
  List<dynamic> expertPhotos;
  final dynamic geoLocation;
  final String locationName;
  final String locationDesc;

  ExpertModel({
    this.id,
    this.name,
    this.businessName,
    this.userType,
    this.profileImageUrl,
    this.email,
    this.phone,
    this.bio,
    this.status,
    this.onCreated,
    this.chats,
    this.experience,
    this.category,
    this.categories,
    this.categoryString,
    this.approved,
    this.totalPost,
    this.totalReview,
    this.clientRate,
    this.clientReview,
    this.rateCreated,
    this.rating,
    this.followers,
    this.following,
    this.expertPhotos,
    this.geoLocation,
    this.locationName,
    this.locationDesc,
  });

  factory ExpertModel.fromDoc(dynamic doc) {
    return ExpertModel(
      id: doc['_key'],
      name: doc['name'] ?? '...',
      businessName: doc['businessName'] ?? doc['name'],
      userType: doc['userType'],
      profileImageUrl: doc['profileImageUrl'],
      email: doc['email'],
      phone: doc['phone'],
      bio: doc['bio'] ?? '',
      onCreated: doc['onCreated'],
      chats: doc['chats'],
      experience: doc['experience'] ?? '',
      category: doc['category'] ?? [],
      categories: doc['categories'] ?? [],
      categoryString: categoryToString(doc['category']) ?? '',
      approved: doc['approved'] ?? false,
      status: doc['status'] ?? false,
      totalPost: doc['totalPost'] ?? 0,
      totalReview: doc['totalReview'] ?? 0,
      clientRate: doc['clientRate'] ?? 0,
      clientReview: doc['clientReview'] ?? '',
      rateCreated: doc['rateCreated'],
      rating: doc['rating'] ?? 0,
      followers: doc['followers'] ?? 0,
      following: doc['following'] ?? false,
      expertPhotos: doc['expertPhotos'] ?? [],
      geoLocation: doc['geoLocation'],
      locationName: doc['locationName'] ?? '',
      locationDesc: doc['locationDesc'] ?? '',
    );
  }

  ExpertModel copyWith({
    final String id,
    final String name,
    final String businessName,
    final String userType,
    final String profileImageUrl,
    final String email,
    final String phone,
    final String bio,
    final bool status,
    final int chats,
    final dynamic onCreated,
    final String experience,
    final List category,
    final List categories,
    String categoryString,
    final bool approved,
    final int totalPost,
    final int totalReview,
    final int clientRate,
    final String clientReview,
    final dynamic rateCreated,
    final dynamic rating,
    final int followers,
    final bool following,
    List<dynamic> expertPhotos,
    final dynamic geoLocation,
    final String locationName,
    final String locationDesc,
  }) {
    return ExpertModel(
      id: id ?? this.id,
      name: name ?? this.name,
      businessName: businessName ?? this.businessName,
      userType: userType ?? this.userType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      onCreated: onCreated ?? this.onCreated,
      chats: chats ?? this.chats,
      experience: experience ?? this.experience,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      categoryString: categoryString ?? this.categoryString,
      approved: approved ?? this.approved,
      status: status ?? this.status,
      totalPost: totalPost ?? this.totalPost,
      totalReview: totalReview ?? this.totalReview,
      clientRate: clientRate ?? this.clientRate,
      clientReview: clientReview ?? this.clientReview,
      rateCreated: rateCreated ?? this.rateCreated,
      rating: rating ?? this.rating,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      expertPhotos: expertPhotos ?? this.expertPhotos,
      geoLocation: geoLocation ?? this.geoLocation,
      locationName: locationName ?? this.locationName,
      locationDesc: locationDesc ?? this.locationDesc,
    );
  }
}

String categoryToString(List category) {
  if (category == null) {
    return '';
  }
  String categoryString = category.map((c) {
    //print(c);
    return c;
  }).toString();

  return categoryString.substring(1, categoryString.length - 1);
}

class ExpertPagination {
  final List<ExpertModel> experts;
  final Map queryVal;
  final int page;
  final int skip;
  final String errorMessage;
  final bool isLoading;
  final bool isRefreshing;
  ExpertPagination(
      {this.experts,
      this.queryVal,
      this.page,
      this.skip,
      this.errorMessage,
      this.isLoading,
      this.isRefreshing});

  ExpertPagination.initial()
      : experts = [],
        queryVal = {
          "filterBy": "all",
        },
        page = 1,
        skip = 0,
        errorMessage = '',
        isLoading = false,
        isRefreshing = false;

  bool get refreshError => errorMessage != '' && experts.length <= 20;

  ExpertPagination copyWith(
      {List<ExpertModel> experts,
      int page,
      int skip,
      Map queryVal,
      String errorMessage,
      bool isLoading,
      bool isRefreshing}) {
    return ExpertPagination(
        experts: experts ?? this.experts,
        queryVal: queryVal ?? this.queryVal,
        page: page ?? this.page,
        skip: skip ?? this.skip,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
        isRefreshing: isRefreshing ?? this.isRefreshing);
  }

  @override
  String toString() =>
      'ExpertPagination(experts: $experts, page: $page,skip:$skip, errorMessage: $errorMessage,isLoading:$isLoading,isRefreshing:$isRefreshing)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpertPagination &&
        listEquals(o.experts, experts) &&
        o.page == page &&
        o.skip == skip &&
        o.queryVal == queryVal &&
        o.errorMessage == errorMessage &&
        o.isLoading == isLoading &&
        o.isRefreshing == isRefreshing;
  }

  @override
  int get hashCode =>
      experts.hashCode ^
      queryVal.hashCode ^
      page.hashCode ^
      skip.hashCode ^
      errorMessage.hashCode ^
      isLoading.hashCode ^
      isRefreshing.hashCode;
}
