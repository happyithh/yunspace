/**
 * Created by Administrator on 2015/9/22.
 */
$(document).ready(function(){
    $('.button button').click(function(){
        var id = $('#id').val();
        var city=$('#city').val();
        var name=$('#name').val();
        var person=$('#person').val();
        var tel=$('#tel').val();
        var address=$('#address').val();
        var form_type = 1;
        var data= new Array();
        data[0]= name
        data[1] = person
        data[2] = tel
        data[3] = address
        data[4] = city
        var key = new Array();
        key[0] = '公司名称'
        key[1]='联系人'
        key[2]='联系电话'
        key[3]='公司地址'
        key[4]='城市'
        //$.getJSON(
        //    'http://d15.yunspace.com.cn/form',
        //    {
        //        id:id,
        //        data:data,
        //        key:key,
        //        form_type:form_type
        //    },
        //    function(json){
        //        console.log(json);
        //    //alert("JSON Data: " + json.users[3].name);
        //    }
        //);


            $.ajax({
                type: "post",
                url:'http://www.yunspace.com.cn/form',
                //url:'http://yun.cc/form',
                data: {
                    id:id,
                    data:data,
                    key:key,
                    form_type:form_type
                },
                async: false,
                dataType: "json",
                success: function(data) {
                            console.log(data);
                            if(data.status == 1){
                                $('.alert').fadeIn().delay(2500).fadeOut();
                                $('.mark').fadeIn().delay(2500).fadeOut();
                                setTimeout(function(){
//                                    window.location.href="http://d15.yunspace.com.cn/feature/2015.9/join/form.html";
                                    window.location.reload();
                                    //window.location.href="http://yun.cc/feature/2015.9/join/form.html";
                                }, 2500);
                            }else{
                                top.alert(data.msg);
                            }

                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    console.log(XMLHttpRequest);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        //function service(data){
        //
        //}
        //$.ajax({
        //    url:'http://d15.yunspace.com.cn/form',
        //    //url:'http://yun.cc/form',
        //    type:'get',
        //    data:{
        //        id:id,
        //        data:data,
        //        key:key,
        //        form_type:form_type
        //    },
        //    dataType:'jsonp',
        //    jsonp: "callback",//传递给请求处理程序或页面的，用以获得jsonp回调函数名的参数名(一般默认为:callback)
        //    jsonpCallback:"flightHandler",//自定义的jsonp回调函数名称，默认为jQuery自动生成的随机函数名，也可以写"?"，jQuery会自动为你处理数据
        //    success: function (data) {
        //        console.log(data);
        //        if(data.status == 1){
        //            $('.alert').fadeIn().delay(2500).fadeOut();
        //            $('.mark').fadeIn().delay(2500).fadeOut();
        //            setTimeout(function(){
        //                window.location.href="http://d15.yunspace.com.cn/feature/2015.9/jicai/form.html";
        //            }, 2500);
        //        }else{
        //            top.alert(data.msg);
        //        }
        //    }
        //
        //});
        //$('.alert').fadeIn().delay(2500).fadeOut();
        //$('.mark').fadeIn().delay(2500).fadeOut();
        //setTimeout(function(){
        //    window.location.href="http://yun.cc/feature/2015.9/jicai/form.html";
        //}, 2500);

    });
    $('.mark').click(function(){
        $('.mark').hide();
        $('.alert').hide();
    });
    $('.p3').click(function(){
        $('.mark').hide();
        $('.alert').hide();
    });

    //$('#name').focus(function(){
    //    if($("#name").length = 0 ){
    //
    //    }else{
    //
    //    }
    //});
});


