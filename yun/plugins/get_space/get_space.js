/**
 * Created by pzl on 15/12/18.
 */
var plugin={
    nodes:{},
    init:function(){
        this.nodes={
            win:$(window),
            doc:$(document),
            cateList:$("#cate-nav-list"),
            moreCateList:$("#more-cate").parent(),
            cateNav:$("#cate-nav"),
            cateExpNav:$("#cate-exp-nav"),
            cateExpList:$(".cate-exp-list"),
            footerLi:$(".footer-li"),
            spaceCateInput:$(".space-cate-input"),
            spaceCateSelect:$(".space-cate-select"),
            dopDown:$(".dopDown"),
            dropList:$(".drop-list"),
            spaceSubmit:$("#space-submit"),
            footerLiList:$(".footer-li-list"),
            footerActList:$(".footer-act-list"),
            submitSpaceFix:$(".submit-space-fix")
        };
        //this.nodes.cateExpList.find("li:nth-of-type(4n)").css({marginRight:"0px"});
        //this.nodes.footerLiList.find("li:nth-of-type(6n)").css({ marginRight:"0px"});
        //this.nodes.footerLi.last().css({ marginRight:"0px" });
        this.nodes.dropList.find("li").last().css({border:"0px"});
        this.nodes.cateExpNav.find("a").first().addClass("cate-exp-nav-active");
        var offTop=this.nodes.spaceSubmit.offset().top;
        this.docTap().postAndLocation().showNavList().changeExp().showDrop().dropLiTap()
            .positionSpaceSubmit().isPositionSubmit(this.nodes.win,offTop).showFooterList();
    },
    showNavList:function(){
        var that=this;
        that.nodes.moreCateList.hover(function(){
            var h=that.nodes.cateList.height();
            that.nodes.cateList.stop().animate({
                height:"402px"
            },1000,"easeOutQuart");
        },function(){});
        that.nodes.cateNav.hover(function(){},function(){
            that.nodes.cateList.stop().animate({
                height:"110px"
            },1000,"easeOutQuart");
        })
        return that;
    },
    changeExp:function(){
        var that=this;
        that.nodes.cateExpNav.find("a").each(function(index,dom){
            var $dom=$(dom);
            $dom.hover(function(){
                var $this=$(this);
                that.nodes.cateExpNav.find("a").removeClass("cate-exp-nav-active");
                $this.addClass("cate-exp-nav-active")
                that.nodes.cateExpList.addClass("none");
                that.nodes.cateExpList.eq(index).removeClass("none");
            },function(){})
        });
        return that;
    },
    showDrop:function(){
        var that=this;
        that.nodes.spaceCateInput.on("click",function(e){
            var $this=$(this);
            that.nodes.spaceCateSelect.removeClass("drop-icon-active").find(".dopDown").hide();
            $this.parent().find(".dopDown").fadeIn(500);
            $this.parents(".space-cate-select").addClass("drop-icon-active");
        });
        return that;
    },
    docTap:function(){
        var that=this;
        that.nodes.doc.on("click",function(e){
            if($(e.target).closest(".space-cate-select").length===0){
                that.nodes.spaceCateInput.parent().find(".dopDown").hide();
                that.nodes.spaceCateSelect.removeClass("drop-icon-active");
            }
        });
        return that;
    },
    dropLiTap:function(){
        var that=this;
        that.nodes.dopDown.find("li").on("click",function(){
            var $this=$(this);
            var v=$(this).text();
            $this.parents(".dopDown").hide();
            $this.parents(".space-cate-select").removeClass("drop-icon-active").find(".space-cate-input-p").text(v);
        });
        return that;
    },
    positionSpaceSubmit:function(){
        var that=this;
        var offTop=that.nodes.spaceSubmit.offset().top;
        that.nodes.win.on("scroll",function(){
            var $this=$(this);
           that.isPositionSubmit($this,offTop);
        });
        return that;
    },
    isPositionSubmit:function(obj,offTop){
        var that=this;
        var st=obj.scrollTop();
        if(st>=offTop){
            if(that.fix==true)return;
            that.fix=true;
            that.nodes.spaceSubmit.addClass("fixed space-submit-active");
            that.nodes.spaceSubmit.find(".space-submit-bottom").addClass("none");
            //that.nodes.spaceSubmit.find(".submit-bg").removeClass("none");
            //that.nodes.spaceSubmit.find(".space-submit-p").addClass("space-submit-p-active");
            that.nodes.spaceSubmit.find(".space-cate-input-p").addClass("space-cate-input-p-active");
            that.nodes.spaceSubmit.find(".space-submit-btn ").addClass("space-submit-btn-active");
            that.nodes.spaceSubmit.find(".space-submit-btn p").addClass("p-active");
        }else{
            if(that.fix==false)return;
            that.fix=false;
            that.nodes.spaceSubmit.removeClass("fixed space-submit-active");
            that.nodes.spaceSubmit.find(".space-submit-bottom").removeClass("none");
            //that.nodes.spaceSubmit.find(".submit-bg").addClass("none");
            //that.nodes.spaceSubmit.find(".space-submit-p").removeClass("space-submit-p-active");
            that.nodes.spaceSubmit.find(".space-submit-btn ").removeClass("space-submit-btn-active");
            that.nodes.spaceSubmit.find(".space-submit-btn p").removeClass("p-active");
        }
        return that;
    },
    postAndLocation:function(){
        var that=this;
        $(".rent_space").click(function(){
            var people=$(".people").text();
            var activity=$(".activity").text();
            var space_id=$('body').data("sid");
            window.location.href="?action=form&people="+people+"&activity="+activity+"&space_id="+space_id;
        })
        return that;
    },
    showFooterList:function(){
        var that=this;
        that.nodes.footerLi.each(function(index,dom){
            var $dom=$(dom);
            $dom.hover(function(){
                var $this=$(this);
                that.nodes.footerLi.find(".footer-li-header").removeClass('footer-li-header-active');
                $this.find(".footer-li-header").addClass('footer-li-header-active');
                that.nodes.footerActList.addClass("none");
                that.nodes.footerActList.eq(index).removeClass('none');
            },function(){});
        });
        return that;
    }
}