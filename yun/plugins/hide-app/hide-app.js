/**
 * Created by pzl on 15/10/29.
 */
var plugin={
    //需要隐藏的dom
    needHideDom:[
        ".banner-img-search",".provide-activity",".nav-fix",".js-find",".banner5",".provide-activity",
        ".nav-fix","meta[name='full-screen']","meta[name='x5-fullscreen']",".act_strategy_header"
    ],
    needShowDom:[
        ".yun_find_info_header"
    ],
    init:function(fn){
        //判断本地存数是否存在
        if(this.isSetAppInLocalstorage()){
            this.finalHandledom(fn);
            return;
        }
        this.finalHandledom(fn);
    },
    finalHandledom:function(fn){
        if(this.isApp()||localStorage.getItem("app")=="app=true"){
            this.changeDomStyle();
            this.isSetAppInLocalstorage(this.handleDocument(false));
            this.isSetAppInLocalstorage(this.handleDocument(true));
            if(fn instanceof Function)fn();
        }else return false;
    },
    //存入localstorage
    saveLocal:function(){
            if (localStorage.getItem("app") == undefined || localStorage.getItem("app") == "") {
                var appi = window.location.search.indexOf("app=true");
                if (appi >= 0) {
                    var u = window.location.search.substr(appi);
                    localStorage.setItem("app", u);
                }
                return true;
            }
    },
    //判断localstorage是否存在app
    isSetAppInLocalstorage:function(fn){
        var app = localStorage.getItem("app");
        if(app==undefined||app==""){
            this.saveLocal();
            if(fn instanceof Function)fn();
            return false;
        }else{
            if(fn instanceof Function)fn();
            return true;
        }
    },
    //安卓上加上?app=true
    isApp:function(fn){
        var __self=this;
        var appi=window.location.search.indexOf("app=true");
        if(appi>=0)return true;else return false;
    },
    hideDom:function(o){
        if($(o).length>0){
            $(o).remove();
        }
        return false;
    },
    showDom:function(o){
        if($(o).length>0){
            $(o).show();
        }
        return false;
    },
    handleDocument:function(bool){
        var __self=this;
        if(localStorage.getItem("app")=="app=true"){
            __self.getDocument(bool);
            return;
        }
        if(this.isApp()){
            __self.getDocument(bool);
        }
    },
    getDocument:function(bool){
        var __self=this;
        //隐藏处理
        if(__self.needHideDom instanceof Array&&!bool){
            for(var k in __self.needHideDom){
                this.hideDom(__self.needHideDom[k]);
            }
        }
        //显示处理
        if(__self.needShowDom instanceof Array&&bool){
            for(var k in __self.needShowDom){
                 this.showDom(__self.needShowDom[k]);
            }
        }
    },
    changeDomStyle:function(){
        if($(".content1").length>0){
            $(".content1").css({marginTop:"44px"});
        }
        if($(".yun_find_info_id").length>0){
            $(".yun_find_info_id").css({marginTop:"44px"});
        }
    }
}

//plugin.init(css);
//function css(){
//
//}


