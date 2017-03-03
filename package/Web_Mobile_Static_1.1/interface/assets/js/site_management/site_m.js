$(document).ready(function(){
    /*1基本信息-添加标签弹出框*/
    $('#site_add_tag_btn').click(function(){
        $('.site_mark').fadeIn();
        $('#tag_input_pop').fadeIn();
        $('.site_pop_input').val('');
        $('.site_pop_cue').hide();
        $('.site_pop_cue1').hide();
        $('.site_pop_input').removeClass('site_pop_input_err');
    });
    $('.site_pop_input').focus(function(){
        $('.site_pop_cue').hide();
        $('.site_pop_cue1').hide();
        $('.site_pop_input').removeClass('site_pop_input_err');
    });

    /*1基本信息-输入标签弹出框确认按钮*/
    $('#tag_input_confirm').click(function(){
        var popval=$('.site_pop_input').val();
        var pop=$('.site_pop_input').val().length;
        var nLi=$('#special_tag ul li').length;
        if(nLi>=2){
            //$('#site_add_tag_btn').hide();
        }else{
            $('#site_add_tag_btn').show();
        }
        if(popval=='') {
            $('.site_pop_cue').show();
            $('.site_pop_input').addClass('site_pop_input_err');
        }else if(pop>4){
            $('.site_pop_cue1').show();
            $('.site_pop_input').addClass('site_pop_input_err');
        }
        else{
            $('#special_tag ul li:last').after("<li><span>"+popval+"</span><div>&#8730;</div></li>");
            $('#site_add_tag_word').removeClass('site_add_tag_word');
            $('#site_add_tag_word').addClass('site_add_tag_word1');
            $('#site_add_tag_btn').removeClass('site_add_tag_btn');
            $('#site_add_tag_btn').addClass('site_add_tag_btn1');
            $('.site_mark').fadeOut();
            $('#tag_input_pop').fadeOut();
        }
    });

    $('#tag_input_cancel').click(function(){
        $('.site_mark').fadeOut();
        $('#tag_input_pop').fadeOut();
    });


    /*1基本信息-添加删除标签样式*/
    $("#special_tag").on('click','ul li',function(){
        $(this).children('div').toggleClass('tagremove');
        if($('#special_tag ul li div').hasClass('tagremove')){
            $('.site_tag_remove_btn').show();
        }else {
            $('.site_tag_remove_btn').hide();
        }
        var tsm=$('.tagremove').length;
        $('.site_tag_remove_btn span').html(tsm);
    });

    /*1基本信息-点击删除按钮*/
    $('.site_tag_remove_btn').click(function(){
        var tsm=$('.tagremove').length;
        $('#tag_delete_pop').show();
        $('.site_mark').show();
        $('.site_pop_title1 span').html(tsm);
    });

    /*1基本信息-点击删除按钮弹出框*/
    $('#tag_delete_confirm').click(function(){
        $('.tagremove').parents('li').remove();
        $('#tag_delete_pop').hide();
        $('.site_mark').hide();
        $('.site_tag_remove_btn').hide();
        var nLi=$('#special_tag ul li').length;
        if(nLi>=2){
            $('#site_add_tag_btn').hide();
        }else{
            $('#site_add_tag_btn').show();
        }
       if(nLi<1){
           $('#site_add_tag_word').removeClass('site_add_tag_word1');
           $('#site_add_tag_word').addClass('site_add_tag_word');
           $('#site_add_tag_btn').removeClass('site_add_tag_btn1');
           $('#site_add_tag_btn').addClass('site_add_tag_btn');
       }
    });
    $('#tag_delete_cancel').click(function(){
        $('#tag_delete_pop').hide();
        $('.site_mark').hide();
    });


    /*1基本信息-点击遮罩层*/
    $('.site_mark').click(function(){
        $(this).fadeOut();
        $('#tag_input_pop').fadeOut();
        $('#tag_delete_pop').hide();
        $('.site_pop').hide();
        $('.site_mark').hide();
    });
    $('.site_mark1').click(function(){
        $('.site_pop1').hide();
        $(this).hide();
    });

    /*1基本信息-属性标签选择*/
    $('.site_tag_list li').click(function(){
       var tative=$('.tagactive').length;
        var ta=$(this).children('div');
        if(ta.hasClass('tagactive')){
            ta.removeClass('tagactive');
        }else if(tative<=2) {
            ta.addClass('tagactive');
        }else{
           $('.site_pop').show();
            $('.site_mark').show();
        }
    });
    $('.site_pag_confirm1').click(function(){
        $('.site_pop').hide();
        $('.site_mark').hide();
    });

    /*3配套设施-属性选择*/
    $('.site_attr_content2 div').click(function(){
         if($(this).hasClass('site_attr_selected')){
              $(this).removeClass('site_attr_selected');
              $(this).addClass('site_attr_unselected');
              $(this).find('span').toggleClass('icon-ok');
             $(this).parent(".site_attr_content2").prev('.site_attr_content1').find('input').attr('value','');
         }else if($(this).hasClass('site_attr_unselected')){
             $(this).removeClass('site_attr_unselected');
             $(this).addClass('site_attr_selected');
             $(this).find('span').toggleClass('icon-ok');
             $(this).parent(".site_attr_content2").prev('.site_attr_content1').find('input').attr('value','有');
         }
    });

    /*7活动适用-属性标签选择*/
    $('.apply_tag_list li').click(function(){
        var applyactive=$('.applyactive').length;
        var aa=$(this).children('div');
        if(aa.hasClass('applyactive')){
            aa.removeClass('applyactive');
        }else if(applyactive<=9) {
            aa.addClass('applyactive');
        }else{
            return false;
        }
    });

    //基本信息---场地标签提交接口
    function tags_submit() {
        var tags = [];
        $(".site_add_tag_outside").find("li").each(function(index,dom) {
            var $dom=$(dom);
            if($dom.find('span').length>0) {
                var v=$dom.find('span').text();
                tags.push(v);
            }
        });
        var tagsStr=tags.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        //console.log(tagsStr);
        $.post("?", {
            is_submit: 1,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new,
            tags_attr: tagsStr
        }, function (data) {
            top.alert(data.msg);
            //window.location.href='/m/test_site/act_apply?space_pedia_id='+space_pedia_id;
        });
    }

    $(".tags_submit").on("click",tags_submit);



    //基本信息---场地标签删除接口
    function tags_remove() {
        var tags = [];
        $(".site_add_tag_outside").find("li").each(function(index,dom) {
            var $dom=$(dom);
            if($dom.find('span').length>0 && !$(this).find("div").hasClass('tagremove')) {
                var v=$dom.find('span').text();
                tags.push(v);
            }
        });
        //console.log(tags);
        var tagsStr=tags.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        console.log(tagsStr);
        $.post("?", {
            is_submit: 1,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new,
            tags_attr: tagsStr
        }, function (data) {
            top.alert(data.msg);
            //window.location.href='/m/test_site/act_apply?space_pedia_id='+space_pedia_id;
        });
    }

    $(".tags_remove").on("click",tags_remove);



    //基本信息---商圈提交接口
    function business_submit() {
        var business = [];
        $(".site_add_tag_outside").find("li").each(function(index,dom) {
            var $dom=$(dom);
            if($dom.find('span').length>0) {
                var v=$dom.find('span').text();
                business.push(v);
            }
        });
        var businessStr=business.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        //console.log(tagsStr);
        $.post("?", {
            is_submit: 1,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new,
            business_attr: businessStr
        }, function (data) {
            top.alert(data.msg);
            //window.location.href='/m/test_site/act_apply?space_pedia_id='+space_pedia_id;
        });
    }

    $(".business_submit").on("click",business_submit);



    //基本信息---商圈删除接口
    function business_remove() {
        var business = [];
        $(".site_add_tag_outside").find("li").each(function(index,dom) {
            var $dom=$(dom);
            if($dom.find('span').length>0 && !$(this).find("div").hasClass('tagremove')) {
                var v=$dom.find('span').text();
                business.push(v);
            }
        });
        //console.log(tags);
        var businessStr=business.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        //console.log(tagsStr);
        $.post("?", {
            is_submit: 1,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new,
            business_attr: businessStr
        }, function (data) {
            top.alert(data.msg);
            //window.location.href='/m/test_site/act_apply?space_pedia_id='+space_pedia_id;
        });
    }

    $(".business_remove").on("click",business_remove);



    //活动适用---行业类型提交接口
    function trade_submit() {
        var cates=[];
        $(".apply_tag_list").find("li").each(function(index,dom){
            var $dom=$(dom);
            if($dom.find(".applyactive").length>0){
                var v=$dom.find('span').text();
                cates.push(v);
            }
        });
        var cateStr=cates.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        $.post("?", {
            is_submit: 1,
            trade_attr: cateStr,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new
        }, function (data) {
            top.alert(data.msg);
            window.location.href='/m/test_site/act_apply?space_pedia_id='+space_pedia_id;
        });
    }
    $(".trade_submit").on("click",trade_submit);

    //活动适用---活动类型提交接口
    function act_submit() {
        var cates=[];
        $(".apply_tag_list").find("li").each(function(index,dom){
            var $dom=$(dom);
            if($dom.find(".applyactive").length>0){
                var v=$dom.find('span').text();
                cates.push(v);
            }
        });
        var cateStr=cates.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        $.post("?", {
            is_submit: 1,
            act_attr: cateStr,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new
        }, function (data) {
            top.alert(data.msg);
            window.location.href='/m/test_site/act_apply?space_pedia_id='+space_pedia_id;
        });
    }
    $(".act_submit").on("click",act_submit);


    //轨道交通提交接口
    function traffic_submit() {
        var cates=[];
        $(".site_tag_list").find("li").each(function(index,dom){
            var $dom=$(dom);
            if($dom.find(".tagactive").length>0){
                var v=$dom.find('span').text();
                cates.push(v);
            }
        });
        var cateStr=cates.join(',');
        var space_pedia_id=$("input[name='data[space_pedia_id]']").val();
        var attr_new = $("input[name='data[attr_new]']").val();
        $.post("?", {
            is_submit: 1,
            traffic: cateStr,
            space_pedia_id:space_pedia_id,
            attr_new:attr_new
        }, function (data) {
            top.alert(data.msg);
            window.location.href='/m/test_site/basic_info?space_pedia_id='+space_pedia_id;
        });
    }
    $(".traffic_submit").on("click",traffic_submit);


//*****************************

    //子空间标签---标签提交接口
    function item_tags_submit() {
        var tags = [];
        $(".site_add_tag_outside").find("li").each(function(index,dom) {
            var $dom=$(dom);
            if($dom.find('span').length>0) {
                var v=$dom.find('span').text();
                tags.push(v);
            }
        });
        var space_item_id=$("input[name='data[space_item_id]']").val();
        //console.log(tags);
        $.post("?", {
            is_submit: 1,
            space_item_id:space_item_id,
            tags: tags
        }, function (data) {
            top.alert(data.msg);
        });
    }

    $(".item_tags_submit").on("click",item_tags_submit);



    //子空间标签---标签删除接口
    function item_tags_remove() {
        var tags = [];
        $(".site_add_tag_outside").find("li").each(function(index,dom) {
            var $dom=$(dom);
            if($dom.find('span').length>0 && !$(this).find("div").hasClass('tagremove')) {
                var v=$dom.find('span').text();
                tags.push(v);
            }
        });
        var space_item_id=$("input[name='data[space_item_id]']").val();
        $.post("?", {
            is_submit: 1,
            space_item_id:space_item_id,
            tags: tags
        }, function (data) {
            top.alert(data.msg);
        });
    }

    $(".item_tags_remove").on("click",item_tags_remove);


   //**************************************************


    /*9配套设施-属性选择*/
    $('#son_space_des div').click(function(){
        if($(this).hasClass('site_attr_selected')){
            $(this).removeClass('site_attr_selected');
            $(this).addClass('site_attr_unselected');
            $(this).find('span').toggleClass('icon-ok');
            $('.son_space_input').attr('placeholder','请输15-500字内的空间描述信息');
        }else if($(this).hasClass('site_attr_unselected')){
            $(this).removeClass('site_attr_unselected');
            $(this).addClass('site_attr_selected');
            $(this).find('span').toggleClass('icon-ok');
            $('.son_space_input').attr('placeholder','');
        }
    });

    /*8图片管理-修改所属空间*/
    $('.son_modify').click(function(){
        var son_selected=$(this).siblings('.site_pic').find('.site_pic_name_c');
        var son_unselceted=$(this).siblings('.site_pic').find('.site_pic_name_c1');
        if(son_selected.hasClass('none')){
            son_selected.removeClass('none');
            son_unselceted.addClass('none');
            $(this).text('修改');
        }else{
            son_selected.addClass('none');
            son_unselceted.removeClass('none');
            $(this).text('确定');
        }
    });

    /*8图片管理-删除图片*/
    $('.son_delete').click(function(){
        $('.site_pop1').show();
        $('.site_mark1').show();
        //var son_delete=$(this).parent('.son_space_edit').parent('.site_list');
        var son_delete=$(this).parent('.son_space_edit').parent('.site_pic_s').parent('.site_pic').parent('.site_list');
        $('.site_pag_confirm').click(function(){
            son_delete.remove();
            $('.site_pop1').hide();
            $('.site_mark1').hide();
        });
    });
    $('.site_pag_cancel').click(function(){
        $('.site_pop1').hide();
        $('.site_mark1').hide();
    });

    /*8图片管理-图片上移*/
    $('.son_up').click(function(){
        var son_up=$(this).parent('.son_space_edit').parent('.site_pic_s').parent('.site_pic').parent('.site_list');
        var son_upp=$(this).parent('.son_space_edit').parent('.site_pic_s').parent('.site_pic').parent('.site_list').prev();
        son_upp.before(son_up);
    });
    $('.son_down').click(function(){
        var son_up=$(this).parent('.son_space_edit').parent('.site_pic_s').parent('.site_pic').parent('.site_list');
        var son_upp=$(this).parent('.son_space_edit').parent('.site_pic_s').parent('.site_pic').parent('.site_list').next();
        son_upp.after(son_up);
    });
    //var Dropzone =new Dropzone("#j-file-two", { url: "/file/post"});
    var url=$('#j-file-two').data('url'),token=1;
    url=url+"?token="+token;
    uploadFile(url,'j-file-two','add',false);
    uploadFile(url,'change_pic','change',true);
    setTimeout(function(){
        token=0;
    },1200000);
    function uploadFile(url,btn,type,only) {
        var uploader = new plupload.Uploader({
            browse_button : btn, //触发文件选择对话框的按钮，为那个元素id
            url :url, //服务器端的上传页面地址
            flash_swf_url : 'js/Moxie.swf', //swf文件，当需要使用swf方式进行上传时需要配置该参数
            silverlight_xap_url : 'js/Moxie.xap', //silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
            filters: {
                mime_types : [ //只允许上传图片文件
                    { title : "图片文件", extensions : "jpg,jpeg,png,bmp" }
                ],
                max_file_size: '4mb', //最大只能上传400kb的文件
                prevent_duplicates : true //不允许选取重复文件
            },
        });
        //在实例对象上调用init()方法进行初始化
        uploader.init();
        //绑定各种事件，并在事件监听函数中做你想做的事
        uploader.bind('FilesAdded',function(uploader,files){
            if(token==0){alert('上传失败，请重新刷新页面！')}
            if(only==true&&files.length>1){
                uploader.files.length=0;
                alert('只能上传一张图片！！');
                return false;
            }
            if(type=='add'){
                for(var i in files){
                    var cloneImg=$("#img-clone").clone().removeClass('none');
                    cloneImg.find(".site_list").attr("id","file-"+files[i].id);
                    var htm=cloneImg.html();
                    $(htm).appendTo('.site_list_outside');
                    !function(i){
                        previewImage(files[i],function(imgsrc){
                            $('#file-'+files[i].id).find('img').attr('src',imgsrc);
                        });
                        if(files[i].type.indexOf("image")>=0){
                            uploader.start();
                            //var data = {
                            //    file: files[i].name,
                            //    action: 'file_url',
                            //    token:token
                            //}
                            //$.post(url, data, function (data) {
                            //    console.log(data);
                            //    //uploader.onFileUploaded(file, data);
                            //});
                        }else{
                            return false;
                        }
                    }(i)
                }
            }else{
                !function(){
                    $("#main-img").html('').append("<img src=''/>");
                    previewImage(files[0],function(imgsrc){
                        $("#main-img").find('img').attr('src',imgsrc);
                        uploader.start();
                    });
                }();
            }
        });
        uploader.bind('BeforeUpload',function(uploader,file){
            var ind=file.name.lastIndexOf(".");
            var ext=file.name.substring(ind);
            file.name=file.id+ext;
        });
        uploader.bind('FileUploaded',function(up, file, info){
            var v=$(".site_add_pic").find('input').val();
            var info_obj = info.response;
            var info_str = eval('(' + info_obj + ')');
            var media_path = info_str.id;
            //console.log(type);
            //修改场地百科的logo
            if(type=='change') {
                //var logo = media_path;
                //var media = '';
                var action = 'change';
            }
            //添加更多图片---media
            else if(type=='add') {
                //var logo = '';
                //var media = media_path;
                var action = 'add';
            }
            var space_pedia_id=$('#space_pedia_id').val();
            //console.log(space_pedia_id);
            //console.log(media_path);
            //console.log(type);
            //console.log(file.name);

            YunSpace.api("demand/product/media/upload.jsonp",{
                space_pedia_id : space_pedia_id,
                logo : media_path,
                action : action,
                media_name : file.name
            },function(data){
                if(data.status==1){
                    alert(data.msg);
                    window.location.reload();
                }else{
                    alert(data.msg);
                }
            });
        });
        uploader.bind('UploadProgress',function(upload,file){
            //每个事件监听函数都会传入一些很有用的参数，
            //我们可以利用这些参数提供的信息来做比如更新UI，提示上传进度等操作
            uploader.start();
        });
        uploader.bind('error',function(uploader,errObject){
            alert(errObject.file.name+"的大小或者类型不正确！！");
        });

        //最后给"开始上传"按钮注册事件
        //$(".start_upload").on('click', function(){
        //    console.log(uploader);
        //    uploader.start(); //调用实例对象的start()方法开始上传文件，当然你也可以在其他地方调用该方法
        //});

        //plupload中为我们提供了mOxie对象
        //有关mOxie的介绍和说明请看：https://github.com/moxiecode/moxie/wiki/API
        //如果你不想了解那么多的话，那就照抄本示例的代码来得到预览的图片吧
        function previewImage(file,callback){//file为plupload事件监听函数参数中的file对象,callback为预览图片准备完成的回调函数
            if(!file || !/image\//.test(file.type)) return; //确保文件是图片
            if(file.type=='image/gif'){//gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
                var fr = new mOxie.FileReader();
                fr.onload = function(){
                    callback(fr.result);
                    fr.destroy();
                    fr = null;
                }
                fr.readAsDataURL(file.getSource());
            }else{
                var preloader = new mOxie.Image();
                preloader.onload = function() {
                    preloader.downsize( 300, 300 );//先压缩一下要预览的图片,宽300，高300
                    var imgsrc = preloader.type=='image/jpeg' ? preloader.getAsDataURL('image/jpeg',80) : preloader.getAsDataURL(); //得到图片src,实质为一个base64编码的数据
                    callback && callback(imgsrc); //callback传入的参数为预览图片的url
                    preloader.destroy();
                    preloader = null;
                };
                preloader.load( file.getSource() );
            }
        }
    }


    /*图片上下移动位置和删除图片的接口*/
    function media_upload_edit() {
        var allData = [];
        $('.site_list').each(function(){
            var path = $(this).find(".site_pic_s img:eq(0)").attr("src");
            var name = $(this).find('.site_pic_name_c_son input').val();
            var tags = $(this).find('.site_pic_name_c1 option:selected').text();
            allData.push(path);
            allData.push(name);
            allData.push(tags);
        });
        var space_pedia_id = $("#space_pedia_id").val();
        //console.log(space_pedia_id);
        //console.log(allData);
        YunSpace.api("demand/product/media/upload/edit.jsonp",{
            space_pedia_id : space_pedia_id,
            media : allData
        },function(data){
            if(data.status==1){
                alert(data.msg);
                window.location.href = '/m/test_site/image_show?space_pedia_id='+space_pedia_id;
            }else{
                alert(data.msg);
            }
        });
    }

    $(".site_confirm_btn").on("click",media_upload_edit);


});
