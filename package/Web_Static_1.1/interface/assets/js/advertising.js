$(document).ready(function () {
    ////首页banner广告位
    //if ($('.carousel-inner').hasClass('adver') == true) {
    //    var site = $('.adver').data('site');
    //    //alert(site);
    //    var count = $('.adver').data('count');
    //    YunSpace.api('advertising/show.jsonp', {
    //            site: site,
    //            count: count
    //        }, function (data) {
    //            if (data.status == 1) {
    //                //console.log();
    //                var html = '';
    //                var indicators = '';
    //                var medias = data.data['media'];
    //                for (var k in medias) {
    //                    var path = medias[k]['path'];
    //                    var title = medias[k]['title']
    //                    if (k == 13) {
    //
    //                        html += '<div class="item active"><img src="' + path + '" alt="' + title + '"></div>';
    //                        indicators += '<li data-target="#carousel-example-generic" data-slide-to="' + 0 + '" class="carousel-gui active"></li>';
    //                    } else {
    //                        html += '<div class="item"><img src="' + path + '" alt="' + title + '"></div>';
    //                        indicators += '<li data-target="#carousel-example-generic" data-slide-to="' + (k * 0 + 1) + '" class="carousel-gui"></li>';
    //                    }
    //                    $('.adver-indicators').html(indicators);
    //                    $('.adver').html(html);
    //                }
    //            }
    //        },
    //        'json'
    //    );
    //}


    <!-----------------------------------开始-------------------------------------------->
    var strAd = new Array();
    $('.home-ga').each(function(index,dom){
        strAd[index] = $(this).data("yun-ad");
        alert($(this).attr('a').size());
    });

    YunSpace.api('advertising/show.jsonp',{

    });

    <!-----------------------------------结束-------------------------------------------->
    // 首页楼层广告位
    var adver = new Array();
    $('.home-ga').each(function (index, dom) {
        var strC = $(this).attr('class').toString();
        adver = strC.split(' ');
        if (adver[1] != '') {
            var site = $('.' + adver[1]).data('site');
            var city = $('.' + adver[1]).data('city');
            var count = $('.' + adver[1]).data('count');
            if (site == 'undefined') {
                site = '';
            }
            if (site == 'undefined') {
                city = '';
            }
            if (site == 'undefined') {
                count = '';
            }
            var homeC = adver[1];
            YunSpace.api('advertising/show.jsonp', {
                    site: site,
                    city: city,
                    count: count
                }, function (data) {
                    if (data.status == 1 && data.data != null) {
                        console.log(data.data);
                        var hrefs = data.data['advertising_link'];
                        var html = '';
                        var medias = data.data['media'];
                        for (var k in medias) {
                            var srcs = medias[k]['path'];
                            html += " <a href='" + hrefs + "' target='_blank'><img src='" + srcs + "' alt=''></a>";
                            $('.' + homeC).html(html);
                        }
                    }
                },
                'json'
            );
        }
    });
    ////内页广告位
    //if($(".list_right_body").length>0){
    //    var site = $('.list_right_body').data('site');
    //    var city = $('.list_right_body').data('city');
    //    var count = $('.list_right_body').data('count');
    //    YunSpace.api('advertising/show.jsonp', {
    //            site: site,
    //            city: city,
    //            count: count
    //        }, function (data) {
    //            //console.log(data);
    //            if (data.status == 1 && data.data != null) {
    //                //console.log(data.data['advertising_link']);
    //                //var hrefs = data.data['advertising_link'];
    //                var html = '';
    //                for (var k in data.data) {
    //                    var hrefs = k['advertising_link'];
    //                    var title = k['advertising_title'];
    //                    if(k['media']!=null){
    //                       for(var n in k['media']){
    //                           if(n!='$$'){
    //                              alert(k['media']);
    //                               var srcs = data.data[k]['media'][n]['path'];
    //                           }
    //
    //                       }
    //                    }
    //                    html ='<div class="t_content1">' +
    //                    '<a href="'+hrefs+'">' +
    //                    '<img src="'+srcs+'"></a>' +
    //                    '<a href="'+hrefs+'">' +
    //                    '<span>title</span>' +
    //                    '</a>';
    //                }
    //                //$('.t_content1').html(html+'</div>');
    //            }
    //        },
    //        'json'
    //    )
    //}
});
