var plugin={
  nodes:{},
  init:function(){
    var that=this;
    that.nodes={
      heart:$(".heart-img"),
      cover:$("#cover"),
      personCode:$("#person-code"),
      personCodeClose:$("#person-code-close"),
      callBack:$(".call-back")
    }
    that.clickPerson().closeCode();
  },
  clickPerson:function(){
    var that=this;
    that.showCode(that.nodes.heart);
    that.showCode(that.nodes.callBack);
    return that;
  },
  closeCode:function(){
      var that=this;
      that.closePersonCode(that.nodes.cover);
      that.closePersonCode(that.nodes.personCodeClose);
  },
  showCode:function(o){
    var that=this;
    o.each(function(index,dom){
      var o=$(dom);
      o.on("click",function(){
        var $this=$(this);
        // TODO: 获取当前的id，然后进行二维码请求
        that.nodes.cover.fadeIn();
        that.nodes.personCode.slideDown();
      });
    });
  },
  closePersonCode:function(o){
    var that=this;
    o.on("click",function(){
      that.nodes.cover.fadeOut();
      that.nodes.personCode.fadeOut();
    });
  }
}
