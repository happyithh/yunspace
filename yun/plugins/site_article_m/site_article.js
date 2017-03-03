/**
 * Created by pzl on 15/12/28.
 */
var plugin={
    nodes:{},
    clicked:true,
    init:function(ele,args,fn){
        this.nodes={
            loadMoreArticle:$("#load-more-article"),
            conTitle:$("#con-title"),
            cloneOne:$("#clone-one"),
            cloneTwo:$("#clone-two"),
            articleList:$("#article-list")
        }
        this.loadMoreArticle(args.type);
        return this;
    },
    loadMoreArticle:function(type){
        var that=this;
        var dp=2;
        that.nodes.loadMoreArticle.find(".more_data").on("click",function(){
            var $this=$(this);
            var id=that.nodes.conTitle.data('id');
            if(that.clicked==false)return;
            //$this.find(".loading").removeClass('none');
            //$this.find('.more_data').addClass('none');
            $this.parent().find(".loading").removeClass('none');
            $this.addClass('none');
            that.clicked=false;
            setTimeout(function(){
                YunSpace.api("raiders/get/list.jsonp",{
                    dp:dp,
                    space_id:id,
                    type:type
                },function(data){
                    var html="";
                    if(data==""){
                        $this.parent().find(".loading").addClass('none');
                        $this.removeClass('none').text("已加载全部");
                        return false;
                    }
                    for(var k in data){
                        var htm="";
                        if(data[k]['logo']!=""){
                            var $cloneNode=that.nodes.cloneOne.clone().removeClass("none");
                            $cloneNode.find(".article-li-header").text(data[k].title);
                            $cloneNode.find(".article-li-body-only img").attr('src',data[k]['logo']);
                            $cloneNode.find(".article-li-footer p:first").text(data[k]['author']||'云SPACE');
                            $cloneNode.find(".article-li-footer p").eq(1).find("span:nth-of-type(2)").text(data[k]['counter_praise']||0);
                            $cloneNode.find(".article-li-footer p").last().find("span").eq(1).text(data[k]['counter_view']||0);
                            var href=$cloneNode.find("a").attr("href");
                            $cloneNode.find("a").attr("href",href+data[k]['id']+".html");
                            htm=$cloneNode.html();
                        }else{
                            var $cloneNode=that.nodes.cloneTwo.clone().removeClass("none");
                            $cloneNode.find(".article-li-header").text(data[k].title);
                            //$cloneNode.find(".article-li-body-only img").attr('src',data[k]['logo']);
                            $cloneNode.find(".article-li-footer p:first").text(data[k]['author']||'云SPACE');
                            $cloneNode.find(".article-li-footer p").eq(1).find("span:nth-of-type(2)").text(data[k]['counter_praise']||0);
                            $cloneNode.find(".article-li-footer p").last().find("span").eq(1).text(data[k]['counter_view']||0);
                            var href=$cloneNode.find("a").attr("href");
                            $cloneNode.find("a").attr("href",href+data[k]['id']+".html");
                            htm=$cloneNode.html();
                        }
                        html+=htm;
                    }
                    that.nodes.articleList.append(html);
                    $this.parent().find(".loading").addClass('none');
                    $this.removeClass('none');
                    dp++;
                    that.clicked=true;
                },'json');
            },2000);

        });
        return that;
    },
    formatDate: function(now){
        var   now=new Date(parseInt(now)*1000);
        var   year=now.getYear();
        var   month=now.getMonth()+1;
        var   date=now.getDate();
        var   hour=now.getHours();
        var   minute=now.getMinutes();
        var   second=now.getSeconds();
    return   year+"-"+month+"-"+date;
}

}
