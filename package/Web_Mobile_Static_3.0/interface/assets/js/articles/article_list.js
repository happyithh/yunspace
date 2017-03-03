/**
 * Created by pzl on 16/2/19.
 */
(function(doc,win){
    var dp=2,
        nodes={
            body:$('body'),
            loadMoreArticle:$("#load-more-article"),
            articleList:$("#article-list"),
            cloneImg:$("#clone-img"),
            cloneOne:$("#clone-one"),
            cloneTwo:$("#clone-two"),
        };
    var listH=nodes.body.height(),
        winH= window.screen.height,
        loaded=true;
    $(window).on('scroll',function(){
        var $this=$(this);
        var st=$this.scrollTop(),
            loadH=listH-(winH+st);
        if(loadH<=44){
            setTimeout(function(){
                if(loaded){
                    loaded=false;
                    YunSpace.api('article/list/new.json',
                        {
                            dp:dp
                        },function(data){
                            var html="";
                            var data=data.data;
                            if(data.length==0){
                                nodes.loadMoreArticle.text('已加载全部');
                                return;
                            }
                            for(var k in data){
                                var htm="";
                                if(data[k]['logo']!=""){
                                    var $cloneNode=nodes.cloneOne.clone().removeClass("none");
                                    $cloneNode.find(".article-li-header").text(data[k].title);
                                    $cloneNode.find(".article-li-body-only img").attr('src',data[k]['logo']);
                                    $cloneNode.find(".article-li-footer p:first").text(data[k]['author']||'云SPACE');
                                    $cloneNode.find(".article-li-footer p").eq(1).find("span:nth-of-type(2)").text(data[k]['counter_praise']||0);
                                    $cloneNode.find(".article-li-footer p").last().find("span").eq(1).text(data[k]['counter_view']||0);
                                    var href=$cloneNode.find("a").attr("href");
                                    $cloneNode.find("a").attr("href",href+data[k]['id']+".html");
                                    htm=$cloneNode.html();
                                }else{
                                    var $cloneNode=nodes.cloneTwo.clone().removeClass("none");
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
                            nodes.articleList.append(html);
                            listH=nodes.body.height();
                            dp++;
                            if(data.length<10){
                                nodes.loadMoreArticle.text('已加载全部');
                                return;
                            }
                            loaded=true;
                        }
                    );
                }else{
                    return false;
                }
            },1000);
        }
    });
})(document,window);