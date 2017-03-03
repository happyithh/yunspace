/**
 * Created by Administrator on 2016/5/30.
 */
$(document).ready(function () {
    // 获取本地收藏的文章
    var articles = localStorage.getItem("article");
    var articles_data = JSON.parse(articles);
    if (Object.size(articles_data) != 0) {
        //console.log(articles_data);
        $.each(articles_data, function (k, v) {
            //var htmls = '';
            if (v['title'] != null) {
                if (v['logo'] != '') {
                    var htmls = '<div class="article-li padding-right">' +
                        '<a href="article/' + k + '.html">' +
                        '<header class="article-li-header">' + v['title'] + '</header>' +
                        '<div class="article-li-body-two">' +
                        '<div class="article-li-body-only">' +
                        '<img src="' + v['logo'] + '" alt="">' +
                        '</div>' +
                        '</div>' +
                        '</a>' +
                        '<footer class="article-li-footer"><p>' + v['author'] + '</p>' +
                        '<p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span>' + v['counter_praise'] + '</span></p>' +
                        '<p><span class="fa fa-eye"></span>&nbsp;<span>' + v['counter_view'] + '</span></p>' +
                        '</footer>' +
                        '</div>';
                } else {
                    var htmls = '<div class="article-li">' +
                        '<a href="article/' + k + '.html">' +
                        '<header class="article-li-header">' + v['title'] + '</header>' +
                        '</a>' +
                        '<footer class="article-li-footer"><p>' + v['author'] + '</p>' +
                        '<p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span>' + v['counter_praise'] + '</span></p>' +
                        '<p><span class="fa fa-eye"></span>&nbsp;<span>' + v['counter_view'] + '</span></p>' +
                        '</footer></div>';
                }
                $('#article-list').append(htmls);
            }
        });
    }

    // 本地收藏的场地/子空间
    var space = localStorage.getItem("space");
    var space_i = localStorage.getItem("space_item");
    var img=$('.img-logo').clone().removeClass('hidden');
    var imgHtml=img.prop("outerHTML");
    var space_data = JSON.parse(space);
    var space_item = JSON.parse(space_i);
    if(Object.size(space_data) !=0){
        $.each(space_data, function (k, v) {
            if(v['title']!=null){
                if(v['logo']!=''){
                    var html = '<li><a href="service_info/'+k + '.html">' +
                        '<div class="list-item-left">' +
                        '<img src="'+v['logo']+'">' +
                        '</div>' +
                        '<div class="list-item-right">' +
                        '<p class="name">'+v['title']+'</p><p class="address">地址: '+v['addr']+'</p>' +
                        '<p class="price">参考价格:&nbsp;<span><span1>'+v['price']+'</span1></span></p>' +
                        '</div>' +
                        '<div class="clear">' +
                        '</div>' +
                        '</a>' +
                        '</li>';
                }else{
                    var html = '<li><a href="service_info/'+k+'.html">' +
                        '<div class="list-item-left">' +
                        imgHtml +
                        '</div>' +
                        '<div class="list-item-right">' +
                        '<p class="name">'+v['title']+'</p><p class="address">地址: '+v['addr']+'</p>' +
                        '<p class="price">参考价格:&nbsp;<span><span1>'+v['price']+'</span1></span></p>' +
                        '</div>' +
                        '<div class="clear">' +
                        '</div>' +
                        '</a>' +
                        '</li>';
                }

            }
            $('#list_item ul').append(html);
        });
    }

    if(Object.size(space_item) !=0){
        $.each(space_item, function (k, v) {
            if(v['url']!=null){
                if(v['logo']!=''){
                    var html = '<li><a href="'+v['url']+'">' +
                        '<div class="list-item-left">' +
                        '<img src="'+v['logo']+'">' +
                        '</div>' +
                        '<div class="list-item-right">' +
                        '<p class="name">'+v['title']+'</p><p class="address">地址: '+v['addr']+'</p>' +
                        '<p class="price">参考价格:&nbsp;<span><span1>'+v['price']+'</span1></span></p>' +
                        '</div>' +
                        '<div class="clear">' +
                        '</div>' +
                        '</a>' +
                        '</li>';
                }else{
                    var html = '<li><a href="'+v['url']+'">' +
                        '<div class="list-item-left">' +
                        imgHtml +
                        '</div>' +
                        '<div class="list-item-right">' +
                        '<p class="name">'+v['title']+'</p><p class="address">地址: '+v['addr']+'</p>' +
                        '<p class="price">参考价格:&nbsp;<span><span1>'+v['price']+'</span1></span></p>' +
                        '</div>' +
                        '<div class="clear">' +
                        '</div>' +
                        '</a>' +
                        '</li>';
                }

            }
            console.log(html);
            $('#space-item ul').append(html);
        });
    }

    // 收藏的子空间


    // 没有收藏信息的时候
    if(Object.size(space_data)+Object.size(articles_data)+Object.size(space_item)==0){
        $('.nocollect').removeClass('hidden');
    }
});
//我的收藏 数量读取
Object.size = function (obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};