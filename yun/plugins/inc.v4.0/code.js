/*
* <a href="#" id="m-web" data-code="www.tmall.com,www.baidu.com,www.yunspace.com.cn"  data-code_id="2"
* data-text="android版,ios版,逗比号" data-title="扫描二维码,下载移动端App"></a>
* @data-code为二维码链接，以逗号分隔
* @data-code_id用于判断当前二维码是否已生成，是则返回，否则生成
* @data-text每个二维码上标题
* @data-title二维码标题
* */
var plugin={
  nodes:{},
  codeId:"",
  init:function(){
    var that=this;
    that.nodes={
      heart:$(".heart-img"),
      cover:$(".cover"),
      personCode:$("#person-code"),
      personCodeClose:$(".person-code-close"),
      callBack:$(".call-back"),
      mApp:$("#m-app"),
      mPublic:$("#m-public"),
      mWeb:$("#m-web"),
      codeImg:$(".code-img"),
      temp:$("#code-temp"),
      codes:$("#person-code-img"),
      codeBody:$("#person-code"),
      psersonCodeTitle:$(".pserson-code-title"),
      commentOther:$(".comment-other")
    };
    that.getCode().closeCode();
  },
  getCode:function(){
    var that=this;
    that.showCode(that.nodes.heart);
    that.showCode(that.nodes.commentOther.find('.call-back'));
    //that.showCode(that.nodes.callBack);
    //that.showCode(that.nodes.mApp);
    //that.showCode(that.nodes.mPublic);
    //that.showCode(that.nodes.mWeb);
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
      if(".")
      o.on("click",function(){
        var $this=$(this);
        // TODO: 获取当前的id，然后进行二维码请求
        that.handleUrlToCode($this);
        that.nodes.cover.fadeIn();
        that.nodes.personCode.slideDown();
      });
    });
  },
  //获取二维码
  handleUrlToCode:function(obj){
    var that=this;
    var codes=obj.data("code"),
        codeId=obj.data("code_id"),
        codeTxt=obj.data("text"),
        codeTitle=obj.data("title");
    if(codes===undefined||codeTxt===undefined){return;}
    var codes=codes.split(",");
    var codeTxt=codeTxt.split(",");
    var l=codes.length;
    var allH="";

    if(that.codeId===codeId){return false;}
    that.nodes.codes.find(".code-img").remove();
    for(var ii=0;ii<l;ii++){
      allH+='<div class="code-img code-img-qrcode"><p class="code-title">'+codeTxt[ii]+'</p></div>'
    }
    that.nodes.codes.append(allH);
      for(var k in codes){
          var tempC=that.nodes.temp.clone().removeClass("none");
          $(".code-img-qrcode").eq(k).removeClass("none").qrcode({
              size: 100, //宽度
              text: "http://"+codes[k] //任意内容
          });
      }
    var codeW=that.nodes.codeBody.outerWidth();
    that.nodes.codeBody.css({ marginLeft:"-"+codeW/2+"px"});
    that.nodes.psersonCodeTitle.find("span").text(codeTitle);
    that.codeId=codeId;
    if(l==1){
      that.nodes.codeBody.find(".code-img").addClass("code-one");
    }
    that.nodes.codeBody.find(".code-img:last").css({
      marginRight:"0px"
    });
  },
  closePersonCode:function(o){
    var that=this;
    o.on("click",function(e){
      that.nodes.cover.fadeOut();
      that.nodes.personCode.fadeOut();
    });
  }
}
