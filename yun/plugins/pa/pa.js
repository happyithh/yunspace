/**
 * Created by liusc on 15/10/29.
 */
/**
 * Created by pzl on 15/10/27.
 */
var plugin = {
    isInit: 0,
    paList: [],
    init: function () {
        if (this.isInit) {
            return;
        }
        this.isInit = true;
        var self = this;
        setTimeout(function(){
            self.doLoad();
        },500)
    },
    add: function (ele, args) {
        this.init();
        this.paList.unshift(
            {
                ele:ele,
                name:args.name
            });
    },

    doLoad:function(){
        var self = this;
        var rqList = {};
        for(var i in this.paList){
            rqList[i] = this.paList[i].name;
        }
        delete rqList['length'];
        YunSpace.api('pa/show.jsonp', {
                pa_list: rqList
            }, function (data) {
                if (data.status == 1 && data.data != null) {
                    for (var k in data.data) {
                        if(data.data[k]['link']==null||!data.data[k]['link']){
                            html = " <img src='http://s2.yunspace.com.cn" + data.data[k]['path'] + "'  width='" + data.data[k]['size']['width'] + "px;' height='" + data.data[k]['size']['height'] + "px;'  alt='"+data.data[k]['title']+"'>";
                        }else{
                            html = " <a  href='" + data.data[k]['link'] + "' target='_blank'><img src='http://s2.yunspace.com.cn" + data.data[k]['path'] + "'  width='" + data.data[k]['size']['width'] + "px;' height='" + data.data[k]['size']['height'] + "px;'  alt='"+data.data[k]['title']+"'></a>";
                        }
                        $(self.paList[k].ele).html(html);
                    }
                }
            },
            'json'
        );
    }
}