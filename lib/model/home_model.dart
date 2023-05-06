class ResponseData {
  int? code;
  int? pages;
  int? num;
  List<HomeMo>? list;

  ResponseData({this.code, this.pages, this.num, this.list});

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    pages = json['pages'];
    num = json['num'];
    if (json['list'] != null) {
      list = <HomeMo>[];
      json['list'].forEach((v) {
        list!.add(new HomeMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['pages'] = this.pages;
    data['num'] = this.num;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeMo {
  int? aid;
  List<LastRecommend>? lastRecommend;
  String? bvid;
  int? typeid;
  String? typename;
  String? title;
  String? subtitle;
  int? play;
  int? review;
  int? videoReview;
  int? favorites;
  int? mid;
  String? author;
  String? description;
  String? create;
  String? pic;
  int? credit;
  int? coins;
  int? like;
  String? duration;
  Rights? rights;

  HomeMo(
      {this.aid,
      this.lastRecommend,
      this.bvid,
      this.typeid,
      this.typename,
      this.title,
      this.subtitle,
      this.play,
      this.review,
      this.videoReview,
      this.favorites,
      this.mid,
      this.author,
      this.description,
      this.create,
      this.pic,
      this.credit,
      this.coins,
      this.like,
      this.duration,
      this.rights});

  HomeMo.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    if (json['last_recommend'] != null) {
      lastRecommend = <LastRecommend>[];
      json['last_recommend'].forEach((v) {
        lastRecommend!.add(new LastRecommend.fromJson(v));
      });
    }
    bvid = json['bvid'];
    typeid = json['typeid'];
    typename = json['typename'];
    title = json['title'];
    subtitle = json['subtitle'];
    play = json['play'];
    review = json['review'];
    videoReview = json['video_review'];
    favorites = json['favorites'];
    mid = json['mid'];
    author = json['author'];
    description = json['description'];
    create = json['create'];
    pic = json['pic'];
    credit = json['credit'];
    coins = json['coins'];
    like = json['like'];
    duration = json['duration'];
    rights =
        json['rights'] != null ? new Rights.fromJson(json['rights']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    if (this.lastRecommend != null) {
      data['last_recommend'] =
          this.lastRecommend!.map((v) => v.toJson()).toList();
    }
    data['bvid'] = this.bvid;
    data['typeid'] = this.typeid;
    data['typename'] = this.typename;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['play'] = this.play;
    data['review'] = this.review;
    data['video_review'] = this.videoReview;
    data['favorites'] = this.favorites;
    data['mid'] = this.mid;
    data['author'] = this.author;
    data['description'] = this.description;
    data['create'] = this.create;
    data['pic'] = this.pic;
    data['credit'] = this.credit;
    data['coins'] = this.coins;
    data['like'] = this.like;
    data['duration'] = this.duration;
    if (this.rights != null) {
      data['rights'] = this.rights!.toJson();
    }
    return data;
  }
}

class LastRecommend {
  int? mid;
  int? time;
  String? msg;
  String? uname;
  String? face;

  LastRecommend({this.mid, this.time, this.msg, this.uname, this.face});

  LastRecommend.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    time = json['time'];
    msg = json['msg'];
    uname = json['uname'];
    face = json['face'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['time'] = this.time;
    data['msg'] = this.msg;
    data['uname'] = this.uname;
    data['face'] = this.face;
    return data;
  }
}

class Rights {
  int? bp;
  int? elec;
  int? download;
  int? movie;
  int? pay;
  int? hd5;
  int? noReprint;
  int? autoplay;
  int? ugcPay;
  int? isCooperation;
  int? ugcPayPreview;
  int? noBackground;
  int? arcPay;
  int? payFreeWatch;

  Rights(
      {this.bp,
      this.elec,
      this.download,
      this.movie,
      this.pay,
      this.hd5,
      this.noReprint,
      this.autoplay,
      this.ugcPay,
      this.isCooperation,
      this.ugcPayPreview,
      this.noBackground,
      this.arcPay,
      this.payFreeWatch});

  Rights.fromJson(Map<String, dynamic> json) {
    bp = json['bp'];
    elec = json['elec'];
    download = json['download'];
    movie = json['movie'];
    pay = json['pay'];
    hd5 = json['hd5'];
    noReprint = json['no_reprint'];
    autoplay = json['autoplay'];
    ugcPay = json['ugc_pay'];
    isCooperation = json['is_cooperation'];
    ugcPayPreview = json['ugc_pay_preview'];
    noBackground = json['no_background'];
    arcPay = json['arc_pay'];
    payFreeWatch = json['pay_free_watch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bp'] = this.bp;
    data['elec'] = this.elec;
    data['download'] = this.download;
    data['movie'] = this.movie;
    data['pay'] = this.pay;
    data['hd5'] = this.hd5;
    data['no_reprint'] = this.noReprint;
    data['autoplay'] = this.autoplay;
    data['ugc_pay'] = this.ugcPay;
    data['is_cooperation'] = this.isCooperation;
    data['ugc_pay_preview'] = this.ugcPayPreview;
    data['no_background'] = this.noBackground;
    data['arc_pay'] = this.arcPay;
    data['pay_free_watch'] = this.payFreeWatch;
    return data;
  }
}
