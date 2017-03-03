var plugin={
  node:{},
  init:function(){
    var that=this;
    that.node={
      comBigOther:$(".com-big-other")
    }
    that.showText();
  },
  showText:function(){
    var that=this;
    that.node.comBigOther.hover(function(){
        var o=$(this);
        o.find(".com-big-title,.com-big-line,.com-big-des").stop();
        o.find(".com-big-line").fadeIn(500);
        o.find(".com-big-title").animate({ top: 90}, 600, 'easeOutBack');
        o.find(".com-big-des").animate({ bottom:90, opacity: 1 ,filter:'alpha(opacity=1)'}, 600, 'easeOutBack');
    },function(){
        var o=$(this);
        o.find(".com-big-title,.com-big-line,.com-big-des").stop();
        o.find(".com-big-line").fadeOut(500);
        o.find(".com-big-title").animate({ top: 114}, 600, 'easeOutBack');
        o.find(".com-big-des").animate({ bottom: 50, opacity: 0 ,filter:'alpha(opacity=1)'}, 600, 'easeOutBack');
    });
  }
}
