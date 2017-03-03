/**
 * Created by bll on 16/1/25.
 */
$(function(){
    var nodes={
        navbarToggle:$(".navbar-toggle"),
        fixNav:$(".fix-nav"),
        closeNav:$(".close-nav"),
        pageHeader:$(".navbar-fixed-top"),
        container:$("#container"),
        cover:$(".cover")
    };
    nodes.navbarToggle.on("touchend",function(){
        nodes.fixNav.addClass("fix-nav-active");
        nodes.closeNav.addClass('close-nav-active');
        nodes.pageHeader.addClass('navbar-fixed-top-leave');
        nodes.container.addClass('container-leave');
        nodes.cover.removeClass("none");

    });
    nodes.closeNav.on("touchend",function(){
        nodes.fixNav.removeClass("fix-nav-active");
        nodes.closeNav.removeClass('close-nav-active');
        nodes.pageHeader.removeClass('navbar-fixed-top-leave');
        nodes.container.removeClass('container-leave');
        nodes.cover.addClass("none");
    });
    nodes.cover.on("touchend",function(){
        nodes.closeNav.trigger("touchend");
    });
    //$("#index").on("click",function(e){
    //    var $this=$(this);
    //    e.preventDefault();
    //    if( nodes.pageHeader.hasClass('navbar-fixed-top-leave')){
    //        nodes.closeNav.trigger("touchend");
    //    }else{
    //        var href=$this.attr('href');
    //        console.log(href);
    //        window.location.href==href;
    //
    //    }
    //})
});
