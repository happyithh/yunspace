/**
 * Created by pzl on 16/2/19.
 */
(function(doc,win){
    var loaded=true,dp=2,nodes={
        body:$('body'),
        bannerList:$('.banner4-list'),
        cloneImg:$("#clone-img"),
        loadMoreArticle:$(".load-more-article")
    };
    //console.log($("#clone-img").html());
    var listH=nodes.body.height(),
        winH=$(win).height();
    $(win).on('scroll',function(){
        var $this=$(this);
        var st=$this.scrollTop();
        var loadH=listH-(winH+st);
        var category_id = $("#load-more-article").data('category-id');
        if(loadH<=40){
            setTimeout(function(){
                if(loaded){
                    loaded=false;
                    YunSpace.api('baike/sites/list.json',
                        {
                            dp:dp,
                            category_id:category_id
                        },function(data){
                            var dt=data.data.rows;
                            if(dt.length==0){
                                nodes.loadMoreArticle.text('已加载全部');
                                return;
                            }
                            var html="";
                            for(var k  in dt){
                                var cn=nodes.cloneImg.clone().removeClass('none');
                                var preHref=cn.data('href');
                                var href=preHref+dt[k]['space_name'];
                                cn.find("a").attr("href",href);
                                var img=dt[k]['mobile_logo']==""?dt[k]['logo']:dt[k]['mobile_logo'];
                                cn.find('img').attr("src",img);
                                cn.find(".banner4-title").text(dt[k]['space_name']);
                                var des;
                                if(dt[k]['attr']['营销标题']!=""){
                                    des=dt[k]['attr']['营销标题'];
                                }else if(dt[k]['addr']!=""){
                                    des=dt[k]['addr'];
                                }else{
                                    des=".....";
                                }
                                cn.find(".banner4-des").text(des);
                                cn.find(".bn-data>p:first>span").text(dt[k]['click']);
                                cn.find(".bn-data>p:last>span").text(dt[k][['is_go']]);
                                html+=cn.html();
                            }
                            nodes.bannerList.append(html);
                            listH=nodes.body.height();
                            dp++;
                            if(dt.length<9){
                                nodes.loadMoreArticle.text('已加载全部');
                                return;
                            }
                            loaded=true;
                        }
                    );
                }
            },1000);
        }else{
            return false;
        }
     });
})(document,window);