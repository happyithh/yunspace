/**
 * Created by pzl on 15/8/16.
 */
//yun("global/jquery-1.9.1.min.js");
/*
*  <p id="upload-file" yun="upload/upload.js::init" yun-input="person" yun-type="img"
 yun-btn="browse1" yun-list="input-img" yun-parent="j-file1" yun-only="true"
 yun-url="{$_root}order_info/upload" >上传</p>
 @yun-input为上传文件之后文件名称所需填入的输入框
 @yun-type为上传的类型为图片,没有定义即随意
 @yun-btn为plupload所需的上传按钮
 @yun-list为图片上传之后的ul容器
 @yun-parent为ul的的容器
 @yun-only设置是否只能上传一张图片，为true时只能上传一张
 @yun-url服务器上传路径
*
* */
yun('upload/plupload.full.min.js');
var plugin={
    uploader:'',
    config:"",
    i:0,
    token:"",
    normalLenth:"",
    init:function(ele,args,callback){
        var self=this;
        self.config=args;

            //设置token，临时上传文件
            self.token=1;
            setTimeout(function(){
                self.token=0;
            },1200000);
            var ur=self.config.url+"?token="+self.token;
            self.uploaderInit(ele,self.config.list,self.config.parent,ur,self.config.input,self.config.type,self.config.only);
            $(".err-up").css({
                position:"absolute",left:"0px",top:"0px",zIndex:"99",background: "rgba(0,0,0,0.8)",
                width:"100%",height:"100%", textAlign: "center",lineHeight: "100px",color:"#fff",display: "none"
            });

    },
    uploaderInit:function(btn,list,parent,url,inp,type,only){
        if(list==undefined&&list==null){
            console.log("图片容器不存在！！");
            return false;
        }
        if(url==undefined&&url==null){
            console.log("后台图片上传路径不存在！！");
            return false;
        }
        if(inp==undefined&&inp==null){
            console.log("上传的input的name属性为空！！");
            return false;
        }
        var self=this,allPath="",pa;
        var uploader = new plupload.Uploader({ //实例化一个plupload上传对象
            browse_button : btn,
            url : url,
            //flash_swf_url : 'js/Moxie.swf',
            //silverlight_xap_url : 'js/Moxie.xap',
            //container: document.getElementById(parent),
            filters: {
                max_file_size: '10mb', //最大只能上传400kb的文件
                prevent_duplicates : true //不允许选取重复文件
            },
            chunk_size:"200kb",
            init:{
                FileUploaded: function (up, file, info) {
                    var data = {
                        file: file.name,
                        action: 'file_url'
                    }
                    $.post(url, data, function (data) {
                        uploader.onFileUploaded(file, data);
                    });
                },
                FilesAdded: function (up, files) {
                    $.each(up.files, function (i, file) {
                        if (up.files.length <= 1) {
                            return;
                        }
                        up.removeFile(file);
                    });

                }
            }
        });
        uploader.BeforeUpload=function(uploader,file){
            file.name=file.id;
        };
        uploader. onFileUploaded= function (file, path) {
            //console.log(file.name + ' ' + path);
            if(only=="true"){
               $(btn).addClass("none");
            }
            if(type!=undefined && type=="img") {
                if (file.type.indexOf("image") >= 0) {
                    allPath += path + ",";
                    pa = allPath.split(",");
                    var p=pa.slice(-(self.normalLenth+1));
                    var strP= p.join(",")
                    $("input[name='" + inp + "']").val(strP);
                }else{
                    //allPath="";
                    return false;
                }
            }else{
                allPath += path + ",";
                $("input[name='" + inp + "']").val(allPath);
                //console.log($("input[name='" + inp + "']").val());
            }

        };
        uploader.bind('FilesAdded',function(uploader,files){
            //console.log(files.length);
            if(self.token==0){
                alert("上传失败，请重新刷新页面");
                return false;
            }
            if(only=="true"&&files.length>1){
                alert("只能上传一张文件！！");
                return false;
            }
            for(var i = 0, len = files.length; i<len; i++){
                var file_name= files[i].name; //文件名
                //构造html来更新UI
                if(type!=undefined && type=="img") {
                    if(files[i].type.indexOf("image")>=0){
                        //TODO插入的dom操作
                        //可定义插入元素
                        //var domLi=$("#"+list).find("li").first().clone().css({display:"block"});
                        //$(domLi).attr("id","file"-files[i].id);
                        var html = '<li id="file-' + files[i].id +'">' +
                            '<span class="ion-close remove-img"  data-id="'+ files[i].id +'"></span>' +
                            '<p class="file-name" style="display: none">' + file_name + '</p>' +
                            '</li>';
                        $(html).appendTo('#' + list);
                    }else{
                        files.length=0;
                        alert("只能上传格式jpg,png,jpeg的图片，大小不能超过10M");
                        return false;
                    }
                }else{
                    if(files[i].type.indexOf("image")>=0){
                        //TODO插入的dom操作
                        //可定义插入元素
                        //var domLi=$("#"+list).find("li").first().clone().css({display:"block"});
                        //$(domLi).attr("id","file"-files[i].id);
                        var html = '<li id="file-' + files[i].id +'">' +
                            '<span class="ion-close remove-img"  data-id="'+ files[i].id +'"></span>' +
                            '<p class="file-name" style="display: none">' + file_name + '</p>' +
                            '</li>';
                        $(html).appendTo('#' + list);
                    }else{
                        //TODO插入的dom操作
                        //可定义插入元素
                        //var domLi=$("#"+list).find("li").first().clone().css({display:"block"});
                        //$(domLi).attr("id","file"-files[i].id);
                        var html = '<li id="file-' + files[i].id +'">' +
                            '<span class="ion-close remove-img"  data-id="'+ files[i].id +'"></span>' +
                            '<p class="file-name file-style" ' +
                            'style="background: #ddd;display: block;text-align: center;line-height: 40px;height:auto!important;">' + file_name + '</p>' +
                            '</li>';
                        $(html).appendTo('#' + list);
                    }
                }
                self.normalLenth=files.length;
                //修改文件名
                var k=files[i].name.indexOf(".");
                var str=files[i].name.substr(k);
                files[i].name=files[i].id+""+str;
                !function(i){
                    self.previewImage(files[i],function(imgsrc){
                        $('#file-'+files[i].id).append('<img src="'+ imgsrc +'" />');
                    });
                    setTimeout(function() {
                        if(type!=undefined&&type=="img"){
                            //console.log(files[i].type.indexOf("image"));
                            if(files[i].type.indexOf("image")>=0){
                                uploader.start();
                            }else{
                                return false;
                            }
                        }else{
                            //console.log(files[i].type.indexOf("image"));
                            uploader.start();
                        }
                    },100);
                }(i);
                ////删除图片
                $('#'+list).find("li").hover(function(){
                    //console.log(files);
                    $(this).find(".remove-img").css({
                        display:"block"
                    })
                },function(){
                    $(this).find(".remove-img").css({
                        display:"none"
                    })
                });
            }
            self.removeFile(uploader,inp,only,btn);
        });
        uploader.init.Error=function(up, err){
            var re=$("file-"+up.id);
            var errInfo= err.code + ": " + err.message;
            alert(errInfo);
        },
        uploader.init();
        //绑定文件上传进度事件
        //uploader.bind('UploadProgress',function(uploader,file){
        //    $('.'+file.id+'-progress').css('width',file.percent + '%');//控制进度条
        //});
        //$('.upload-btn').click(function(){
        //    uploader.start(); //开始上传
        //});
    },
    previewImage:function(file,callback){
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
    },
    removeFile:function(uploader,inp,only,btn){
        var self=this;
        $(".remove-img").on("click",function(){
            var toremove;
            var id=$(this).data("id");
            for(var i in uploader.files){
                if(uploader.files[i].id === id){
                    toremove = i;
                }
            }
            $(this).parent().remove();
            uploader.files.splice(toremove, 1);
            var inputPath= $("input[name='"+inp+"']").val();
            var pathGp=inputPath.split(",");
            for(var k in pathGp){
                if(pathGp[k].indexOf(id)>=0){
                   pathGp.splice(k, 1);
                }
            }
            var strPath=pathGp.join(",");
            $("input[name='"+inp+"']").val(strPath);
            if($("input[name='"+inp+"']").val()==""&&only=="true"){
                $(btn).removeClass("none");
            }
        });
    }
}
