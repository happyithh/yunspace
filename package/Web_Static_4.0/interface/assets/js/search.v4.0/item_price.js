/**
 * Created by Administrator on 2016/6/22.
 */
$(function () {
    YunSpace.api('search/get/conform/item.jsonp', {
        city: city,
        category: category,
        activeType: activeType,
        size_range: size_range,
        people_range: people_range,
        is_outside: is_outside,
        baike_id: baike_id,
        keyword2:keyword
    }, function (data) {
        for (var i in data.data) {
            var item_data = '';
            $.each(data.data[i], function (n, value) {
                if(n!='fitItemCount') {
                    item_data += '<tr class="item-detail">';
                    item_data += '<td  class="item-name"><a class="item-name" href="' + data.data[i][n].item_url + '" target="_blank">' + data.data[i][n].item_name + '</a></td>';
                    if (data.data[i][n].size != 0) {
                        item_data += '<td class="item-size">' + data.data[i][n].size + '</td>';
                    } else {
                        item_data += '<td class="item-size"></td>';
                    }
                    if (data.data[i][n].min_people != 0 && data.data[i][n].max_people != 0 && data.data[i][n].min_people != data.data[i][n].max_people) {
                        item_data += '<td class="item-people">' + data.data[i][n].min_people + '人~' + data.data[i][n].max_people + '人</td>';
                    } else if (data.data[i][n].min_people != 0 && data.data[i][n].max_people == 0) {
                        item_data += '<td class="item-people">' + data.data[i][n].min_people + '人以上</td>';
                    } else if (data.data[i][n].min_people == 0 && data.data[i][n].max_people != 0) {
                        item_data += '<td class="item-people">' + data.data[i][n].max_people + '人以下</td>';
                    } else if (data.data[i][n].min_people == data.data[i][n].max_people && data.data[i][n].min_people != 0 && data.data[i][n].max_people != 0) {
                        item_data += '<td class="item-people">' + data.data[i][n].max_people + '人</td>';
                    } else {
                        item_data += '<td class="item-people"></td>';
                    }
                    item_data += '<td>';
                    if (data.data[i][n].standard_new) {
                        for (m in data.data[i][n].standard_new) {
                            if(data.data[i][n].standard_new[m].price_status==1){
                                item_data += '<p class="item-price">';
                                item_data += '<span class="item-text">' + m + '</span>&nbsp;&nbsp;';
                                item_data += '</p>';
                            }
                        }
                        item_data += '</td>';
                        item_data += '<td>';
                        for (m in data.data[i][n].standard_new) {
                            if(data.data[i][n].standard_new[m].price_status==1) {
                                //if(data.data[i][n].standard_new[m].market_price!=null){
                                item_data += '<p class="item-price">';
                                if (data.data[i][n].standard_new[m].market_price != data.data[i][n].standard_new[m].discount_price) {
                                    item_data += '<span class="numb undline"><del>' + data.data[i][n].standard_new[m].market_price + '</del></span>';
                                }
                                item_data += '</p>';
                            }
                        }
                        item_data += '</td>';
                        item_data += '<td>';
                        if (data.data[i][n].standard_new != null) {
                            for (j in data.data[i][n].standard_new) {
                                if(data.data[i][n].standard_new[j].price_status==1) {
                                    item_data += '<p class="best-price">';
                                    if (data.data[i][n].standard_new[j].discount_price != data.data[i][n].standard_new[j].market_price) {
                                        item_data += '<span>' + data.data[i][n].standard_new[j].discount_price + '</span>';
                                    } else if (data.data[i][n].standard_new[j].market_price != 0) {
                                        item_data += '<span style="color: #121212;">' + data.data[i][n].standard_new[j].market_price + '</span>';
                                    }
                                    item_data += '</p>';
                                }
                            }
                        } else {
                            item_data += '<span style="color: #121212;">面议</span>';
                        }
                    } else {
                        item_data += '<p class="item-price">';
                        item_data += '<span class="item-text"></span>&nbsp;&nbsp;';
                        item_data += '</p>';
                        item_data += '</td>';
                        item_data += '<td>';
                        item_data += '<p class="item-price">';
                        item_data += '<span></span>';
                        item_data += '</p>';
                        item_data += '</td>';
                        item_data += '<td>';
                        item_data += '<p class="best-price">';
                        if(data.data[i][n].item_max_price!=0){
                            item_data += '<span style="color: #121212;">'+data.data[i][n].item_max_price+data.data[i][n].item_price_unit+'</span>';
                        }else if (data.data[i][n].item_min_price!=0){
                            item_data += '<span style="color: #121212;">'+data.data[i][n].item_min_price+data.data[i][n].item_price_unit+'</span>';
                        }else{
                            item_data += '<span style="color: #121212;">面议</span>';
                        }

                        item_data += '</p>';
                    }

                    item_data += '</td>';
                    item_data += '<td class="wp">';
                    item_data += '<a class="lookprice" href="javascript:;" ' +
                    'data-space_id="' + data.data[i][n].baike_id + '" ' +
                    'data-item_id="' + data.data[i][n].item_id + '"' +
                    'data-item_name="' + data.data[i][n].item_name + '"' +
                    ' data-space_name="' + data.data[i][n].baike_name + '"  onclick="getPrice(this)">咨询</a>';
                    item_data += '</td>';
                    item_data += '</tr>';
                } else {
                    $('#fit-item-' + i).text(value + '个适合空间/');
                }
            })
            var item_id = 'item_' + i;
            $("#" + item_id+" .trfirst").after(item_data);
            var fit_item = getNum($('#fit-item-'+i).text());
            var count_item = getNum($('#count-item-'+i).text());
            if(count_item>4 || fit_item<count_item){
                $('#more-item-'+i).removeClass('hide');
            }
        }
    });
    function getNum(content){
        var num =  content.replace(/[^0-9]/ig,"");
        return num;
    }
});