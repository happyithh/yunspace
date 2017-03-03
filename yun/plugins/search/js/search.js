/**
 * Created by bll on 15/7/23.
 */
yun("global/jquery-1.9.1.min.js");
var plugin={
    config:"",//配置
    item:"",
    node:"",
    getResult:function(element,args,callback){
        var self=this;
        self.plugin=args;
        var htm=this.addResult();
        //htm='<li class="result-li">'+htm+'333</li>';
        //$(".result-list").append(htm);
        //ajax请求
        YunSpace.api(self.plugin.url, {
            item:self.item
        }, function (data) {
            //htm='<li class="result-li">'+htm+'</li>';
            self.makeResult(data);
            $(".result-list").append(self.node);
        });
    },
    addResult:function(){
        var self=this;
        $(".result").show();
        self.item=$(".search").val();
        self.node=$(".result-li").first().clone().removeClass("hidden");
        var height=$(".search").height();
        var width=$(".search").width();
        var htm=self.node.html();
        $(".result").find("p > .question").text(self.item);
        $(".result-li").css({
            top:height+"px",
            width:width+"px"
        });
        if(self.item==''){
            $(".result").hide();
            htm="";
            $(".result-li").first().siblings().remove();
        }
        htm='<li class="result-li">'+htm+'</li>';
        return htm;
    },
    makeResult:function(data){
        this.node.find(".result-link").html("data");
    }
}