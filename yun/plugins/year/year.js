/**
 * Created by pzl on 15/10/27.
 */
var plugin={
    init:function(){
        if(this.isIe()){
            $(".year-submit-input-con > input").css({ lineHeight:"100%",padding:"5px 0px"});
        }
        $(".year-cate-img > li:nth-of-type(3n)").css({ marginRight:"0px" })
        $(".year-form-input:last-of-type").css({ border:"0px",padding:"0px",width:"100%" });
        $(".year-form-input-con > select").on("click",function(){
            $(".year-form-input").css({ background:"#fff"});
            $(".year-form-input select").css({ background:"#fff"});
            $(this).parents(".year-form-input").css({ background:"#f8f8f8"})
        });
        $(".year-cate-img").find("li").each(function(index,dom){
            $(dom).hover(function(){
                $(dom).find(".year-cate-img-li-des").stop();
                $(dom).find(".year-cate-cov").stop();
                $(dom).find(".year-cate-img-li-title").stop();
                //$(dom).find(".year-cate-img-li-des").fadeIn(500);
                $(dom).find(".year-cate-cov").fadeIn(500);
                $(dom).find(".year-cate-img-li-title").animate({
                    top:"40%"
                },500);
            },function(){
                $(dom).find(".year-cate-img-li-des").stop();
                $(dom).find(".year-cate-cov").stop();
                $(dom).find(".year-cate-img-li-title").stop();
                //$(dom).find(".year-cate-img-li-des").fadeOut();
                $(dom).find(".year-cate-cov").fadeOut();
                $(dom).find(".year-cate-img-li-title").animate({
                    top:"50%"
                },500);
            })
        });
        $(".year-cate-btn,.year-form-submit").on("click",function(){
            $(".year-cover").fadeIn(200);
            $(".year-submit").slideDown(200);
        });
        $(".year-submit-close,.year-cover").on("click",function(){
            $(".year-cover").fadeOut(200);
            $(".year-submit").slideUp(200);
            $(".year-code").slideUp(200);
        });
        $(".year-cate-des-p2 > span").on("click",function(){
            $(".year-cover").fadeIn(200);
            $(".year-code").slideDown(200);
        });
        $(".year-raiders-list").find("li").each(function(index,dom){
            var txt=$(dom).find("a").text();
            if(txt.length>16){
                var ft=txt.substr(0,16)+"...";
                $(dom).find("a").text(ft);
            }
        })

        var btn = $(".year-submit-btn").find("button");
        $(".year-cate-btn").click(function () {
            var ym_id = $(this).find("input[name=yearmeeting_id]").val();
            var t_number = $(this).parent().find(".ticket-number").text();
            var ym_title = $(this).parent().find(".year-cate-title").children("span").text();

            btn.attr("data-year_id", ym_id);
            btn.attr("data-ticket_number", t_number);
            btn.attr("data-year_title", ym_title);
        });
    },
    isIe:function(){
        var browser = navigator.appName,
            b_version = navigator.appVersion,
            version = b_version.split(";");
        if (version.length > 1) {
            var trim_Version = version[1].replace(/[ ]/g, "");
            if (browser == "Microsoft Internet Explorer" || browser == "Netscape" ) {
                return true;
            }else{
                return false;
            }

        }
    }
}