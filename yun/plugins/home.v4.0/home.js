yun('global/underscore.1.8.3.js');
var plugin={
  node:{},
  aW:{},
  init:function(ele,args,fn){
    var that=this;
    that.node={
      triangleUp:$("#triangle-up"),
      searchTab:$("#searchTab"),
      homeRec:$(".home-recommend-list"),
      comBig:$(".com-big"),
      comSmall:$(".com-small"),
      twoImg:$(".two-img"),
      threeImgTop:$(".j-three-img-top"),
      threeImgBottom:$(".j-three-img-bottom"),
      fourImg:$(".four-img"),
      painters:$("#painter"),
      comBigOther:$(".com-big-other"),
      homeTabLi:$(".home-tab-li"),
      headerBodyInput:$(".header-body-input"),
      headerBodyButton:$(".header-body-button"),
      homeRecommendList:$(".home-recommend-list"),
      rankList:$(".rank-list"),
      bodyLeft:$(".body-left"),
      bodyBlock:$(".body-block"),
      searchSpace:$("#search-space-two"),
      homeTabList:$(".home-tab-list")
    };
      var h=that.node.bodyLeft.find('.body-link').outerHeight()+25;
      that.node.bodyLeft.each(function(index,dom){
          var $dom=$(dom);
          var allH=that.node.bodyBlock.height();
          var h=$dom.find(".body-link-first").outerHeight()+25;
          var getH=allH-h;
          //$dom.find(".body-link:last").css({ height:getH+"px"})
      })
      $(".four-img:nth-child(3n)").css({ marginRight: "0px"});
      that.node.homeRecommendList.find('li').last().css({marginRight:"0px"});
      that.node.rankList.find(".rank-num:gt(2)").addClass("bg-another");
      //that.node.painters.find("li:nth-of-type(7n)").css({marginRight:"0px"});
      $(".keyword1").addClass('none');
      $(".keyword2").removeClass('none');
      $(window).on("scroll",function(){
          $(".tangram-suggestion-main").css({
              display:'none'
          })
      });
    that.searchTab()
        //.imgCover()
        .changeRecommend().searchBaidu();
        //.searchSpace();
      that.submit_search();

  },
    submit_search:function(){
        var that=this;
        that.node.headerBodyButton.click(function(){
            var key_word;
            var search_type =   that.node.headerBodyInput.find("input.search_type").val();
            if(search_type!=''){
                switch(search_type){
                    case 'site_library':
                        key_word= that.node.headerBodyInput.find("input.keyword2").val();
                        break;
                    default:
                        key_word= that.node.headerBodyInput.find("input.keyword1").val();
                }
                //if(key_word=="")return;
                //console.log("http://"+ window.location.host+'/search?action=is_submit&search_type='+search_type+"&keyword="+encodeURI(key_word));
                window.location.href="http://"+ window.location.host+'/database?action=is_submit&search_type='+search_type+"&keyword="+key_word;
            }else{
                alert("请输入你想要搜索的关键词！");
            }
        });
    },
  /*
  *获取搜索a标签的宽度
  */
  getAWidth:function(){
    var that=this;
    that.node.searchTab.find("a").each(function(index,dom){
      var o=$(dom);
      var w=o.outerWidth();
      that.aW[index]=w;
    })
  },
  searchTab:function(){
      var that=this;
      that.getAWidth();
      that.node.searchTab.find("a").each(function(index,dom){
        var o=$(dom);
        var w=o.outerWidth();
        var tw=that.node.triangleUp.outerWidth();
        o.on("click",function(){
          var $this=$(this);
          var beforeW=[];
          var hold=$this.data("hold");

            var search_type = $this.data("type");
          for(var i=0;i<index;i++){
            beforeW.push(that.aW[i]);
          }
          var allW=_.reduce(beforeW,function(m1,m2){return m1+m2},0);
          allW=allW+w/2-tw/2;
          that.node.triangleUp.css({ left: allW+"px" });
          that.node.searchTab.find("a").removeClass("search-active");
          o.addClass("search-active");
          that.node.headerBodyInput.find("input.keyword1").attr("placeholder",hold);
            that.node.headerBodyInput.find("input.search_type").val(search_type);
            $(".tangram-suggestion-main").css({
                display:'none'
            })
            if(search_type=='site_library'){
                $(".keyword1").addClass('none');
                $(".keyword2").removeClass('none');
            }else{
                $(".keyword1").removeClass('none');
                $(".keyword2").addClass('none');
            }

          // TODO: 设置搜索的cate_id
        });
      });
          $(".keyword2,.keyword1").on('keyup',function (event) {
              var keycode = event.which;
              if(keycode==13){
                  if( $(".log-cont").hasClass('active')){
                      $('.logreg-btn').trigger('click');
                      return false;
                  }
                  //that.node.headerBodyInput.blur();
                  that.node.headerBodyButton.trigger("click");
              }
          });

      return that;
  },
  /*图片效果*/
  imgCover:function(){
    var that=this;
    // 图1，2，大
    //var big1=[140,175],
    //    big2=[140,175],
    var nodes1=[".cov",".com-big-title",".com-big-line",".com-big-des"];
    that.imgAnimate(that.node.comBig,nodes1);
    // 图1，2，小
    //var small1=[55,90],
    //    small2=[55,90],
    var nodes2=[".cov",".com-small-title",".com-small-line",".com-small-des"];
    that.imgAnimate(that.node.comSmall,nodes2);
    // 图3，左
    //var twoLeft1=[220,262],
    //    twoLeft2=[220,262],
    var nodes3=[".cov",".two-left-title",".two-left-line",".two-left-des"];
    that.imgAnimate(that.node.twoImg,nodes3);
    // 图4，上
    //var threeTop1=[110,110],
    //    threeTop2=[120,50],
    var nodes4=[".three-img-cov",".j-three-title",".j-three-line",".j-three-des"];
    that.imgAnimate(that.node.threeImgTop,nodes4);
    // 图4，下
    //var threeBottom1=[75,75],
    //    threeBottom2=[90,20],
    var nodes4=[".three-img-cov",".j-three-title",".j-three-line",".j-three-des"];
    that.imgAnimate(that.node.threeImgBottom,nodes4);
    // 图5
    //var four1=[100,130.5],
    //    four2=[100,130.5],
    var nodes5=[".four-img-cov",".four-img-title",".four-top-line",".four-img-des"];
    that.imgAnimate(that.node.fourImg,nodes5);
    // 分类集合
    var five1=[90,90],
        five2=[30,30],
        nodes6=[".cov",".com-big-title",".com-big-line",".com-big-des"];
    that.imgAnimate(that.node.comBigOther,nodes6,five1,five2);
    return that;
  },
  /*
    nodes以cov,title,line,des顺序
  */
  imgAnimate:function(o,nodes,enter,leave){
    var nStr=nodes.join(",");
      //if(enter==undefined||leave==undefined){
      //    if(typeof enter!='object'||typeof leave!='object'){
      //        console.log('enter,leave必须为对象！！');
      //        return false;
      //    }
      //}
    o.hover(function(){
        var o=$(this);
        o.find(nStr).stop();
        o.find(nodes[2]).fadeIn(500);
        o.find(nodes[0]).animate({ opacity: 0.7 ,filter:'alpha(opacity=70)'}, 600, 'easeInOutSine');
        //o.find(nodes[1]).animate({  opacity: 1 ,filter:'alpha(opacity=1)'}, 400, 'easeInOutSine');
        o.find(nodes[3]).animate({ opacity: 1 ,filter:'alpha(opacity=1)'}, 600, 'easeInOutSine');
    },function(){
        var o=$(this);
        o.find(nStr).stop();
        o.find(nodes[2]).fadeOut(500);
        o.find(nodes[0]).animate({ opacity: 0.3 ,filter:'alpha(opacity=30)'}, 600, 'easeInOutSine');
        //o.find(nodes[1]).animate({ top: leave[0]}, 400, 'easeInOutSine');
        o.find(nodes[3]).animate({ opacity: 0 ,filter:'alpha(opacity=0)'}, 600, 'easeInOutSine');
    });
      return that;
  },
    changeRecommend:function(){
        var that=this;
        that.node.homeTabLi.each(function(index,dom){
            var $dom=$(dom);
            $dom.hover(function(){
                that.node.homeTabLi.removeClass("home-tab-li-active");
                that.node.homeTabLi.eq(index).addClass("home-tab-li-active");
                that.node.homeRec.addClass("none");
                that.node.homeRec.eq(index).removeClass("none");
            },function(){})
        });
        return that;
    },
    //2016.5.26改
    changeRecommend:function(){
        var that=this;
        that.node.homeTabList.each(function(index,dom){
            var $dom=$(dom);
            $dom.hover(function(){
                that.node.homeTabList.removeClass("home-tab-list-active");
                that.node.homeTabList.eq(index).addClass("home-tab-list-active");
                that.node.homeRec.addClass("none");
                that.node.homeRec.eq(index).removeClass("none");
            },function(){})
        });
        return that;
    },
    searchBaidu:function(){
        var that=this;
        var map = new BMap.Map("l-map");
        map.centerAndZoom("上海",12);
        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {
                "input" : "suggestId2"
                ,"location" : map
            });
        ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
            var addr=$("#suggestId2").val();
            var root=that.node.searchSpace.data("root");
            addr = encodeURI(encodeURI(addr));
            var url= root+"map2?addr="+addr;

            window.open(url);
        });
        return that;
    },
    searchSpace:function(){
        var that=this;
        that.node.searchSpace.on("click",function(){
            var $this=$(this),city=$("#suggestId2").val();
            if(city=="")return false;
            var root=$this.data('root');
            var url=root+"database/site?action=is_submit&search_type=site_library&keyword="+city;
            window.open(url);
        });
        return that;
    }
}
console.log('我叹息的是：看到年龄相仿的青年，\n他们正处于最好的年华，却为了安逸去当一颗螺丝钉，\n肆无忌惮地挥霍着自己的天赋和才华。\n梦想不会老，但是我们会变老；\n梦想不会变质，但是追梦的精力却是有保鲜期的。\n最好的年华，应该去全力以赴地做一件事情，\n不淋漓尽致不痛快！\n\n\n我们需要你！\n请将简历发送至  hr@yunspace.com.cn %c（邮件标题请以“姓名-应聘技术职位-来自console”命名）','color:red');





