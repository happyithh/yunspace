yun('global/underscore.1.8.3.js');
var plugin={
  node:{},
  aW:{},
    siteLibrary:"",
    map:"",
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
      searchSpace:$("#search-space-two-1"),
      homeTabList:$(".home-tab-list"),
      headerBodyContentList:$(".header-body-content-list"),
            headerBodyForm:$(".header-body-form"),
            publicDrop:$(".public-drop"),
            publicInput:$("#public-input"),
            publicInputTwo:$("#public-input2"),
            publicContainer:$("#public-container"),
            publicSelect:$(".public-select")
    };
      that.geoc = new BMap.Geocoder();
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
      this.initSearchTypeStyle();
  },
    initSearchTypeStyle:function(){
        var search_type=$(".search_type").val();
        if(search_type==""){
            search_type='site_library';
            $(".search_type").val(search_type);
        }
        switch(search_type){
            case "site_library":
                this.node.headerBodyContentList.find("li a").eq(0).trigger('click');
                break;
            case "project_library":
                this.node.headerBodyContentList.find("li a").eq(1).trigger('click');
                break;
            case "company_library":
                this.node.headerBodyContentList.find("li a").eq(2).trigger('click');
                break;
            case "paper_library":
                this.node.headerBodyContentList.find("li a").eq(3).trigger('click');
                break;

        }
    },
    submit_search:function(){
        var that=this;
        that.node.searchSpace.click(function(){
            $(".tangram-suggestion-main").hide();
            var search_type =  that.node.headerBodyInput.find("input.search_type").val();
            if(search_type!=''){
                var key_word= that.node.headerBodyInput.find("input.keyword2").val();
                switch(search_type){
                    case 'site_library':
                        var active_type=$(".public-form").find(".active_type").val()==""?"":"&active_type="+$(".public-form").find(".active_type").val();
                        var city_new=$(".public-form").find(".city").val();
                        //var suggestion=$(".tangram-suggestion-main tr>td:first").text();
                        //if(suggestion&&suggestion.indexOf(' ')){
                        //    suggestion = $(".tangram-suggestion-main tr>td").eq(1).text();
                        //}
                        if(key_word){
                            if(city_new=='不限'){
                                var href=$("#suggestId2").data('href');
                                //var city_select=that.node.headerBodyForm.find('.public-select-h:first input').val();
                                var active_type=that.node.headerBodyForm.find('.public-select-h:last input').val();
                                var addr=$("#suggestId2").val();
                                that.siteLibrary=that.getLocationStorage();
                                that.siteLibrary.addr=addr;
                                that.setLocationStorage(that.siteLibrary);
                                console.log(that.getLocationStorage());
                                var url=href+"space?"+"city="+city_new+'&active_type='+active_type+"&keyword2="+addr;
                                window.location.href=url;
                            }else{
                                that.geoc.getPoint(key_word, function(point){
                                    that.siteLibrary=that.getLocationStorage();
                                    if(point!=null){
                                        that.siteLibrary.geo=point;
                                        that.handleUrlAndLocalStorage(point, key_word);
                                    }else{
                                        that.handleUrlAndLocalStorage(null, key_word);
                                        setTimeout(function(){$(".tangram-suggestion-main").hide();},10);
                                    }
                                },city_new);
                            }
                        }else{
                            that.handleUrlAndLocalStorage(null, key_word);
                        }
                        break;
                    default:
                        key_word= that.node.headerBodyInput.find("input.keyword1").val()==""?"":"&keyword2="+that.node.headerBodyInput.find("input.keyword1").val();;
                        window.location.href="http://"+ window.location.host+'/database?action=is_submit&search_type='+search_type+"&keyword="+key_word;
                }
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
                $(".select-wrapper").removeClass('none');
                that.node.publicDrop.find("input[name='search_type']").val('site_library');
                that.node.publicInput.addClass("none");
                that.node.publicInputTwo.removeClass("none");
                that.node.publicContainer.find('form').attr('action','/space');
                that.node.publicSelect.find("span").html('<code>找场地</code><i class="down-icon down-icon-white"></i>');
            }else{
                $(".keyword1").removeClass('none');
                $(".keyword2").addClass('none');
                $(".select-wrapper").addClass('none');
                var $search_type=that.node.publicDrop.find("input[name='search_type']");
                switch (search_type){
                    case 'project_library':
                        $search_type.val('project_library');
                        that.node.publicSelect.find("span").html('<code>找资讯</code><i class="down-icon down-icon-white"></i>');
                        break;
                    case 'company_library':
                        $search_type.val('company_library');
                        that.node.publicSelect.find("span").html('<code>找公司</code><i class="down-icon down-icon-white"></i>');
                        break;
                    case 'paper_library':
                        $search_type.val('paper_library');
                        that.node.publicSelect.find("span").html('<code>找文库</code><i class="down-icon down-icon-white"></i>');
                        break;
                }
                that.node.publicInput.removeClass("none");
                that.node.publicInputTwo.addClass("none");
                //$(".select-wrapper").addClass('none');
                that.node.publicContainer.find('form').attr('action','/database');
            }
          // TODO: 设置搜索的cate_id
        });
      });
      //$(".keyword2,.keyword1").on('keyup',function (event) {
      //    var keycode = event.which;
      //    if(keycode==13){
      //        if( $(".log-cont").hasClass('active')){
      //            $('.logreg-btn').trigger('click');
      //            return false;
      //        }
      //        //that.node.headerBodyInput.blur();
      //        that.node.headerBodyButton.trigger("click");
      //    }
      //});
      $(".keyword2,.keyword1").on('keyup',function(e){
          if (e.keyCode == 13){
              that.node.searchSpace.trigger("click");
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
      var that=this;
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
        that.map = new BMap.Map("l-map");
        that.map.centerAndZoom("上海",12);
        var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
            {
                "input" : "suggestId2"
                //,"location" : that.map
            });
        //全局对象ac
        window.ac=ac;
        that.siteLibrary=that.getLocationStorage();
        //console.log(that.siteLibrary,222);
        ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
            //var addr=$("#search-input2").val();
            //var root=that.nodes.searchSpace.data("root");
            //addr = encodeURI(encodeURI(addr));
            //var url= root+"map2?addr="+addr;
            var item= e.item.value;
            var addr=item.province+item.city+item.district+item.street+item.streetNumber+item.business;
            that.geoc.getPoint(addr, function(point){
                if(point==null){
                    alert('定位失败,请重新搜索!!');
                    return;
                }
                that.handleUrlAndLocalStorage(point,addr);
            });
        });
        return that;
    },
    ///*搜索字段存储,优先关键字搜索*/
    handleUrlAndLocalStorage:function(point,addr){
        var that=this;
        var href=$("#suggestId2").data('href');
        that.siteLibrary=that.getLocationStorage();
        that.siteLibrary.geo=point;
        that.siteLibrary.addr=addr;
        if(point!=null){
            /*如果关键字坐标存在则改变localstorage的city_select*/
            that.geoc.getLocation(point, function(rs){
                var addComp = rs.addressComponents;
                that.siteLibrary.city_select=addComp.city;
                if(addComp.city.indexOf('市')>-1){
                    that.siteLibrary.city_select=addComp.city.substr(0,addComp.city.indexOf('市'));
                }
                var city_select=(!that.siteLibrary.hasOwnProperty('city_select')||that.siteLibrary.city_select=="")?"":"&city="+that.siteLibrary.city_select;
                var active_type=(!that.siteLibrary.hasOwnProperty('active_type')||that.siteLibrary.active_type=="")?"":"&active_type="+that.siteLibrary.active_type;
                that.setLocationStorage(that.siteLibrary);
                var url=href+"space?"+city_select+active_type+"&lng="+point.lng+"&lat="+point.lat+"&keyword2="+addr;
                window.location.href=url;
            })
        }else{
            var city_select=(!that.siteLibrary.hasOwnProperty('city_select')||that.siteLibrary.city_select=="")?"":"&city="+that.siteLibrary.city_select;
            var active_type=(!that.siteLibrary.hasOwnProperty('active_type')||that.siteLibrary.active_type=="")?"":"&active_type="+that.siteLibrary.active_type;
            that.setLocationStorage(that.siteLibrary);
            var url=href+"space?"+city_select+active_type+"&keyword2="+addr;
            window.location.href=url;
        }
    },
    searchSpace:function(){
        //var that=this;
        //that.node.searchSpace.on("click",function(){
        //    var $this=$(this),city=$("#suggestId2").val();
        //    if(city=="")return false;
        //    var root=$this.data('root');
        //    var url=root+"database/site?action=is_submit&search_type=site_library&keyword="+city;
        //    window.open(url);
        //});
        //return that;
    },
    //初始化本地存储
    initLocationStorage:function(){
        var that=this;
        that.siteLibrary=localStorage.getItem('site_library');
        if(that.siteLibrary==null){
            var a={};
            a=JSON.stringify(a);
            localStorage.setItem('site_library',a);
            that.siteLibrary=that.getLocationStorage();
            var t=setInterval(function(){
                that.siteLibrary.city=$(".public-form").find('.city').val();
                if(that.siteLibrary.city!=""){
                    that.setLocationStorage(that.siteLibrary);
                    clearInterval(t);
                }
            },10)
        }
        that.siteLibrary=that.getLocationStorage();
        return that;
    },
    setLocationStorage:function(obj){
        localStorage.setItem('site_library',JSON.stringify(obj));
    },
    getLocationStorage:function(){
        return JSON.parse(localStorage.getItem('site_library'));
    }
}
console.log('我叹息的是：看到年龄相仿的青年，\n他们正处于最好的年华，却为了安逸去当一颗螺丝钉，\n肆无忌惮地挥霍着自己的天赋和才华。\n梦想不会老，但是我们会变老；\n梦想不会变质，但是追梦的精力却是有保鲜期的。\n最好的年华，应该去全力以赴地做一件事情，\n不淋漓尽致不痛快！\n\n\n我们需要你！\n请将简历发送至  hr@yunspace.com.cn %c（邮件标题请以“姓名-应聘技术职位-来自console”命名）','color:red');





