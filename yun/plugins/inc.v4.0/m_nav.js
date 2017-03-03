/**
 * Created by pzl on 15/12/30.
 */
var plugin={
    nodes:{},
    fix:false,
    float:true,
    init:function(){
        this.nodes={
            win:$(window),
            headerBodyKeys:$(".header-body-keys"),
            headerBodyKeysList:$(".header-body-keys-list"),
            navFixed:$(".nav-fixed")
        }
        var offH=this.nodes.headerBodyKeys.offset().top;
        var st=this.nodes.win.scrollTop();
        this.fixNav(offH).fixNavShow(offH,st);
    },
    fixNav:function(offsetTop){
        var that=this;
        that.nodes.win.on('scroll',function(){
            var $this=$(this);
            var st=$this.scrollTop();
            that.fixNavShow(offsetTop,st);

        });
        return that;
    },
    fixNavShow:function(offsetTop,scrollTop){
        var that=this;
        if(scrollTop>=offsetTop){
            if(that.fix==true)return;
            that.fix=true;
            this.nodes.navFixed.addClass("active");
            //that.nodes.headerBodyKeys.addClass("nav-fixed");
            //that.nodes.headerBodyKeysList.find("a").addClass('nav-link-fix');
            //that.nodes.headerBodyKeysList.addClass('header-body-keys-list-active');
            //that.nodes.headerBodyKeysList.find('li[class="keys-line"]').addClass('none');
            //that.nodes.headerBodyKeysList.find('li').addClass('li-active');
            //that.nodes.headerBodyKeysList.find('li').each(function(index,dom){
            //    var $dom=$(dom);
            //    if($dom.find('a').hasClass("header-body-key-active")){
            //        $dom.find('a').addClass("bg-none");
            //        $dom.addClass("bg-active");
            //    }
            //});
        }
        if(scrollTop<offsetTop){
            if(that.fix==false)return;
            that.fix=false;
            this.nodes.navFixed.removeClass("active");
            //that.nodes.headerBodyKeys.removeClass("nav-fixed");
            //that.nodes.headerBodyKeysList.find("a").removeClass('nav-link-fix');
            //that.nodes.headerBodyKeysList.removeClass('header-body-keys-list-active');
            //that.nodes.headerBodyKeysList.find('li[class="keys-line"]').removeClass('none');
            //that.nodes.headerBodyKeysList.find('li').removeClass('li-active');
            //that.loat=true;
            //that.fix=false;
            //that.nodes.headerBodyKeysList.find('li').each(function(index,dom){
            //    var $dom=$(dom);
            //    if($dom.find('a').hasClass("header-body-key-active")){
            //        $dom.find('a').removeClass("bg-none");
            //        $dom.removeClass("bg-active");
            //    }
            //});
        }
    }
}
