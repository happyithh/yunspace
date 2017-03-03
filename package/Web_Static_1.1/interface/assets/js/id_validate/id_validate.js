$(document).ready(function () {
    //点击尾部的向上图标页面滚动至上方
    $(".js-upload-file").bind("change",function(){
        uploadImg(this);
    });
    $(".js-remove-file").bind("click",function(){
        removeFile(this);
    });
    $('.js-up').click(function(){
        $("html, body").animate({
            "scroll-top":0
        },400);
    });
    function uploadImg(obj) {
        var filename = $(obj).attr("name");
        var forms = "<form class='myUpload' action='" + $(".compy-val-table").attr("data-action")+
            filename +
            "&maxsize=1048576' method='post' enctype='multipart/form-data'></form>";
        $(obj).parent().wrap(forms);
        $(".myUpload").ajaxSubmit({
            dataType: 'json',
            success: function (data) {
                if (data.state == "SUCCESS") {
                    $(obj).parent().parent().parent().find("img").attr("src", data.url);
                    $(obj).parent().parent().parent().find("." + filename + "").val(data.url);
                    $(obj).parent().parent().parent().find(".moveimgs").show();
                    $(obj).parent().unwrap(forms);
                    $(obj).val("");
                } else {
                    $(obj).parent().unwrap(forms);
                }
            },
            clearForm: true
        });
    }

    function removeFile(obj) {
        $(obj).parent().find("img").attr("src", '/package/Web_Static_1.1/interface/assets/img/id_validate/val_idimg.png');
        $(obj).siblings("input").removeAttr("value");
        $(obj).hide();
    }
});