/**
 * Created by bll on 15/7/23.
 */
yun("global/jquery-1.9.1.min.js");
var plugin={
    config:"", //配置
    /*
     * @insert 插入节点
     * @last_id 最后节点的id
     * */
    insertNode:function(element,args,callback){
        var self = this;
        self.config = args;
        self.config.cloneNode=$(self.config.insert).first().clone();
        self.config.cloneParent=$(self.config.insert).first().parent();
        //$(self.config.cloneParent).append(self.config.cloneNode);
        self.getData();
    },
    getData:function(){
        var self=this;
        var item=self.config.item.split(",");
        var items={};
        for(var o in item){
            item[o]=item[o].split(":");
            items[item[o][0]]=item[o][1];
        }
        //所有的request数据都在items,last_id为最后加载的id
        YunSpace.api(self.config.url, {
            items:items,
            last_id:self.config.last_id
        }, function (data) {
            self.makeDate(self.config.cloneNode,data);    //数据插入节点操作
            $(self.config.cloneParent).append(self.config.cloneNode);
        });
    },
    /*获取数据在插入节点进行处理方法(自定义)，如下*/
    makeDate:function(o,data){
        o.text("2222222");
    }
}