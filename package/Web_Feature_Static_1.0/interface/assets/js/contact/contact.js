function initOtOc(){
    var index=$(".index");
    for(var i=0;i<index.length;i++){
        showOc("#item_title"+i,"#item_content"+i,"#222",'#666',"visible","hidden");
    }
}
function showOc(o1,o2,color1,color2,show1,show2){
    $(o1).hover(function(){
        console.log(this);
        $(o1).css({
            color:color1
        });
        $(o2).css({
            visibility:show1
        })
    },function(){
        $(o1).css({
            color:color2
        });
        $(o2).css({
            visibility:show2
        })
    });
    $(o2).hover(function(){
        $(o1).css({color:color1});
        $(o2).css({visibility:show1})
    },function(){
        $(o1).css({color:color2});
        $(o2).css({visibility:show2})
    });
}
var autoplay;
$(function(){
    $('#pagescroll').fullpage({
        navigation: true,

        afterLoad: function(anchorLink, index){
            if(index == 1){
                //$('#about').html('关于我们');
                $('.container1').addClass('alive');
            }
            if(index == 2){
                //$('.section2 .right_box').delay(100).removeClass('fadeOutUp').addClass('animated fadeInUp'),
                //    $('.section2 .left_box').delay(1000).removeClass('fadeOutDown').addClass('animated fadeInDown')
                //$('#develop').html('发展历程');
                $('.container2').addClass('alive');
            }
            if(index == 3){
                //$('.section3 .right_box').delay(100).removeClass('fadeOutUp').addClass('animated fadeInRight'),
                //    $('.section3 .left_box').delay(1000).removeClass('fadeOutDown').addClass('animated fadeInLeft')
                //$('#team').html('管理团队');
                $('.teamtitle').addClass('alive');
                if(!autoplay){
                    autoplay = setInterval("move('r')",5000);
                    var imgBig=document.getElementById('imgBig');
                    imgBig.onmouseover=function(){
                        clearInterval(autoplay);
                    }
                    imgBig.onmouseout=function(){
                        autoplay = setInterval("move('r')",5000);
                    }

                    var slim=document.getElementById('brief1');
                    slim.onmouseover=function(){
                        clearInterval(autoplay);
                    }
                    slim.onmouseout=function(){
                        autoplay = setInterval("move('r')",5000);
                    }
                }


            }
            if(index == 4){
                //$('#brand').html('合作品牌');
                $('.brand').addClass('alive');
                $('.brand_content').addClass('alive');
            }
            if(index == 5){
                //$('#talent').html('人才招聘');
                $('.cloud_bg').addClass('alive');
                $('.person_title').addClass('p_t_a');

            }
            if(index == 6){
                //$('#cooperation').html('加盟合作');
                $('.cooperation').addClass('alive');
            }
            if(index == 7){
                //$('#contact').html('联系我们');
                $('.map_title_outside').addClass('alive');
            }
        },
        onLeave: function(index, direction){
            if(index == 1){
                //$('#about').html(' ');
                $('.container1').removeClass('alive')
            }
            if(index == 2){
                //$('.section2 .right_box').delay(100).addClass('fadeOutUp'),
                //    $('.section2 .left_box').delay(1000).addClass('fadeOutDown')
                //$('#develop').html(' ');
                $('.container2').removeClass('alive')
            }
            if(index == 3){
                //$('.section3 .right_box').delay(100).addClass('fadeOutUp'),
                //    $('.section3 .left_box').delay(1000).addClass('fadeOutDown')
                //$('#team').html(' ');
                $('.teamtitle').removeClass('alive');
            }
            if(index == 4){
                //$('#brand').html('');
                $('.brand').removeClass('alive');
                $('.brand_content').removeClass('alive');
            }
            if(index == 5){
                //$('#talent').html('');
                $('.cloud_bg').removeClass('alive');
                $('.person_title').removeClass('p_t_a');
            }
            if(index == 6){
                //$('#cooperation').html(' ');
                $('.cooperation').removeClass('alive');
            }
            if(index == 7){
                //$('#contact').html(' ');
                $('.map_title_outside').removeClass('alive');
            }
        }
    });
});

initOtOc();

window.onload=function(){
    $('.container1').addClass('alive');


};
<!--管理团队-->
function AdItem(name,phone,address,Photo,price,time,slim,url) {
    this.name = name;
    this.phone = phone;
    this.address = address;
    this.Photo = Photo;
    this.url = url;
    this.price = price;
    this.time = time;
    this.slim = slim;
}
var ad = new Array();
ad[0] = new AdItem('刘盛春','Gil','产品运营部 副总','/package/Web_Feature_Static_1.0/interface/assets/img/contact/5.png','● 拥有10年+的互联网产品开发、部署、运营经验。在B2C、B2B、生物医药以及社交、教育机器人等行业有丰富的行业经验；\n● 曾任生物谷、易知搜索引擎技术总监，易迅网创始团队成员。','2010-04','#');
ad[1] = new AdItem('涂晓苏','Sue','云·SPACE 合伙人','/package/Web_Feature_Static_1.0/interface/assets/img/contact/4.png','● 英国赫特福德大学市场营销硕士学位（MA）；\n● 拥有10年创意地产、文化商业地产领域工作经验，有着丰富的商业策划和品牌推广能力；\n● 曾参与上海8号桥、尚都里、无限度广场、上海大拇指广场、上海证大喜马拉雅中心等项目。','2010年5月','#');
ad[2] = new AdItem('丁武萍','Yumi','云·SPACE 联合创始人','/package/Web_Feature_Static_1.0/interface/assets/img/contact/1.png','● 哥伦比亚大学上海教学中心MBA学位；\n● 8年商业地产工作经验；\n● 参与过上海8号桥、上海城市雕塑艺术中心、上海红坊文化艺术园区等文创地产项目；\n● 致力于推动国内外文化创意产业的交流，促进国内文化创意行业的发展与衍生；\n● 入围2007年上海文化新人；2010年上海创意人才候选人。','2010年5月','#');
ad[3] = new AdItem('宦晶宇','Rain','云·SPACE 联合创始人','/package/Web_Feature_Static_1.0/interface/assets/img/contact/2.png','● 平台架构师、互联网领域的连续创业者；\n● 8年多新媒体互动研发和广告创意领域的工作经验；\n● 众筹平台“创客星球”联合创始人/CEO/首席架构师；\n● 互动实验室“DLAB”创始人/创意总监。','2010-04','#');
ad[4] = new AdItem('张梓娟','Cecile','云·SPACE 合伙人','/package/Web_Feature_Static_1.0/interface/assets/img/contact/3.png','● 英国纽卡斯尔大学公共关系学硕士（MA）;\n● 拥有7年金融、地产、互联网公关市场营销经验， 2年海外工作经验，具备国际视野；\n● 先后任职于中国平安集团、万科董事会办公室，拥有大型集团总部思维与管理经验；\n● 曾参与平安银行收购深发展银行、平安集团海外发行可转债、万科H股上市等重大项目。','2010年4月','#');
ad[5] = new AdItem('邢凯','CK','平台事业部 副总','/package/Web_Feature_Static_1.0/interface/assets/img/contact/6.png','● 13年的互联网销售及管理经验\n● 曾就职于阿里巴巴B2B部门，担任区域总监，负责市场开拓及团队管理；\n● 就职期间服务过武汉钢铁，神龙汽车等知名客户。','2010-04','#');
var img = new Array();
img[0] = document.getElementById("imgSmallLeft");
img[1] = document.getElementById("imgMiddleLeft");
img[2] = document.getElementById("imgBig");
img[3] = document.getElementById("imgMiddleRight");
img[4] = document.getElementById("imgSmallRight");
img[5] = document.getElementById("imgHidden");

var position = 0;
for(var i=0;i<img.length;i++){
    img[i].src = ad[i].Photo;
}

var adname = document.getElementById("adname");
var adtel = document.getElementById("adtel");
var adaddr = document.getElementById("adaddr");
var adprice = document.getElementById("adprice");
//var adtime = document.getElementById("adtime");
//var adslim = document.getElementById("adslim");

var cur = 2;
adname.href = ad[2].url;
if(navigator.userAgent.indexOf("Firefox")>0){
    adname.textContent = ad[2].name;
    adtel.textContent = ad[2].phone;
    adaddr.textContent = ad[2].address;
    adprice.textContent = ad[2].price;
    //adtime.textContent = ad[2].time;
    //adslim.textContent = ad[2].slim;
} else {
    adname.innerText = ad[2].name;
    adtel.innerText = ad[2].phone;
    adaddr.innerText = ad[2].address;
    adprice.innerText = ad[2].price;
    //adtime.innerText = ad[2].time;
    //adslim.innerText = ad[2].slim;
}

<!--加盟合作-->
$(document).ready(function(){
     $('#agent').click(function(){
         $(this).addClass('agent_hover');
         $('#suppier').removeClass('suppier_hover');
         $('#cai').removeClass('cai_hover');
     });
    $('#suppier').click(function(){
        $(this).addClass('suppier_hover');
        $('#agent').removeClass('agent_hover');
        $('#agent').addClass('agent');
        $('#cai').removeClass('cai_hover');
    });
    $('#cai').click(function(){
        $(this).addClass('cai_hover');
        $('#agent').removeClass('agent_hover');
        $('#agent').addClass('agent');
        $('#suppier').removeClass('suppier_hover');
    });



    <!--联系我们-->
    $('.accordion-desc').fadeOut(0);
    $('.desc_active').show();
    //$(".map_area").hide();


    var map = new BMap.Map("allmap");
    var myGeo = new BMap.Geocoder();
   var firstAddr = $("#cityWrap .accordion").eq(0).data('addr');
    makeFirstMap();

   function makeFirstMap(){
       myGeo.getPoint(firstAddr, function(point){
           if (point) {
               map.centerAndZoom(point, 16);
               var marker = new BMap.Marker(point)
               map.addOverlay(marker);

               var opts = {
                   width : 300,     // 信息窗口宽度
                   height: 80,     // 信息窗口高度
                   title : "云·SPACE" , // 信息窗口标题
                   enableMessage:true,//设置允许信息窗发送短息
                   //message:"亲耐滴，晚上一起吃个饭吧？戳下面的链接看下地址喔~"
               }
               var infoWindow = new BMap.InfoWindow("地址：淮海西路570号红坊创意园F211", opts);  // 创建信息窗口对象
               map.openInfoWindow(infoWindow,point); //开启信息窗口
               marker.addEventListener("click", function(){
                   map.openInfoWindow(infoWindow,point); //开启信息窗口
               });
           }else{
               alert("您选择地址没有解析到结果!");
           }
       }, "");
   }
    $('#cityWrap .accordion').click(function() {
        $('.accordion-desc').not($(this).next()).slideUp('400');
        $(this).next().slideToggle(400);
        $('.accordion').siblings().removeClass('accordion_active');
        $(this).addClass('accordion_active');
        //$(this).children().show();
        //$(this).siblings().children().hide();

        var addr = $(this).data('addr');

        // 将地址解析结果显示在地图上,并调整地图视野
        myGeo.getPoint(addr, function(point){
            if (point) {
                map.centerAndZoom(point, 16);
                var marker = new BMap.Marker(point)
                map.addOverlay(marker);

                var opts = {
                    width : 300,     // 信息窗口宽度
                    height: 80,     // 信息窗口高度
                    title : "云·SPACE" , // 信息窗口标题
                    enableMessage:true,//设置允许信息窗发送短息
                    //message:"亲耐滴，晚上一起吃个饭吧？戳下面的链接看下地址喔~"
                }
                var infoWindow = new BMap.InfoWindow(addr, opts);  // 创建信息窗口对象
                map.openInfoWindow(infoWindow,point); //开启信息窗口
                marker.addEventListener("click", function(){
                    map.openInfoWindow(infoWindow,point); //开启信息窗口
                });
            }else{
                alert("您选择地址没有解析到结果!");
            }
        }, "");

    });
    map.disableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    function add_control() {
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
        var top_right_navigation = new BMap.NavigationControl({
            anchor: BMAP_ANCHOR_TOP_RIGHT,
            type: BMAP_NAVIGATION_CONTROL_SMALL
        }); //右上角，仅包含平移和缩放按钮
        map.addControl(top_left_control);
        map.addControl(top_left_navigation);
        //map.addControl(top_right_navigation);
    }
    add_control();
});





//var tagEle = "querySelectorAll" in document ? document.querySelectorAll(".tag") : getClass("tag"),
//    paper = "querySelectorAll" in document ? document.querySelector(".tagBall") : getClass("tagBall")[0];
//
//if((document.documentElement.clientWidth||document.body.clientWidth)<1600){
//    RADIUS = 200
//}else{
//    RADIUS = 300
//}
//
//
//    fallLength = 500,
//    tags = [],
//    angleX = Math.PI / 500,
//    angleY = Math.PI / 500,
//    CX = paper.offsetWidth / 2,
//    CY = paper.offsetHeight / 2,
//    EX = paper.offsetLeft + document.body.scrollLeft + document.documentElement.scrollLeft,
//    EY = paper.offsetTop + document.body.scrollTop + document.documentElement.scrollTop;
//
//function getClass(className) {
//    var ele = document.getElementsByTagName("*");
//    var classEle = [];
//    for (var i = 0; i < ele.length; i++) {
//        var cn = ele[i].className;
//        if (cn === className) {
//            classEle.push(ele[i]);
//        }
//    }
//    return classEle;
//}
//
//function innit() {
//    for (var i = 0; i < tagEle.length; i++) {
//        var a, b;
//        var k = (2 * (i + 1) - 1) / tagEle.length - 1;
//        var a = Math.acos(k);
//        var b = a * Math.sqrt(tagEle.length * Math.PI);
//// var a = Math.random()*2*Math.PI;
//// var b = Math.random()*2*Math.PI;
//        var x = RADIUS * Math.sin(a) * Math.cos(b);
//        var y = RADIUS * Math.sin(a) * Math.sin(b);
//        var z = RADIUS * Math.cos(a);
//        var t = new tag(tagEle[i], x, y, z);
//        tagEle[i].style.color = "rgb(" + parseInt(Math.random() * 255) + "," + parseInt(Math.random() * 255) + "," + parseInt(Math.random() * 255) + ")";
//        tags.push(t);
//        t.move();
//    }
//}
//
//Array.prototype.forEach = function (callback) {
//    for (var i = 0; i < this.length; i++) {
//        callback.call(this[i]);
//    }
//}
//
//function animate() {
//    setInterval(function () {
//        rotateX();
//        rotateY();
//        tags.forEach(function () {
//            this.move();
//        })
//    }, 40)
//}
//
//if ("addEventListener" in window) {
//    paper.addEventListener("mousemove", function (event) {
//        var x = event.clientX - EX - CX;
//        var y = event.clientY - EY - CY;
//// angleY = -x* (Math.sqrt(Math.pow(x , 2) + Math.pow(y , 2)) > RADIUS/4 ? 0.0002 : 0.0001);
//// angleX = -y* (Math.sqrt(Math.pow(x , 2) + Math.pow(y , 2)) > RADIUS/4 ? 0.0002 : 0.0001);
//        angleY = x * 0.00003;
//        angleX = y * 0.00003;
//    });
//}
//else {
//    paper.attachEvent("onmousemove", function (event) {
//        var x = event.clientX - EX - CX;
//        var y = event.clientY - EY - CY;
//        angleY = x * 0.00003;
//        angleX = y * 0.00003;
//    });
//}
//
//function rotateX() {
//    var cos = Math.cos(angleX);
//    var sin = Math.sin(angleX);
//    tags.forEach(function () {
//        var y1 = this.y * cos - this.z * sin;
//        var z1 = this.z * cos + this.y * sin;
//        this.y = y1;
//        this.z = z1;
//    })
//
//}
//
//function rotateY() {
//    var cos = Math.cos(angleY);
//    var sin = Math.sin(angleY);
//    tags.forEach(function () {
//        var x1 = this.x * cos - this.z * sin;
//        var z1 = this.z * cos + this.x * sin;
//        this.x = x1;
//        this.z = z1;
//    })
//}
//
//var tag = function (ele, x, y, z) {
//    this.ele = ele;
//    this.x = x;
//    this.y = y;
//    this.z = z;
//}
//
//tag.prototype = {
//    move: function () {
//        var scale = fallLength / (fallLength - this.z);
//        var alpha = (this.z + RADIUS) / (2 * RADIUS);
//        this.ele.style.width = 50 * scale + "px";
//        this.ele.style.height = 30 * scale + "px";
//        this.ele.style.opacity = alpha + 0.5;
//        this.ele.style.filter = "alpha(opacity = " + (alpha + 0.5) * 100 + ")";
//        this.ele.style.zIndex = parseInt(scale * 100);
//        this.ele.style.left = this.x + CX - this.ele.offsetWidth / 2 + "px";
//        this.ele.style.top = this.y + CY - this.ele.offsetHeight / 2 + "px";
//    }
//}
//animate();
//innit();