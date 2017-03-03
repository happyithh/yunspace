/**
* Created by bll on 15/8/4.
*/
yun("global/jquery-1.9.1.min.js");
yun("alert/sweetalert.min.js");
var plugin={
    config:"",
    showAlert:function(ele,args,callback){
        var self=this;
        self.config=args;
        console.log(ele);
        switch (self.config.custom) {
            case "simple":
                console.log(12)
                self.alertSimple(self);
                break;
            case "success":
                self.alertSuccess(self);
                break;
            case "error":
                self.alertError(self);
                break;
            case "delete":
                self.alertDelete(self,callback);
                break;
            case "timer":
                self.alertTimer(self);
                break;
            case "input":
                self.alertInput(self,callback);
                break;
        }
    },
    alertSimple:function(o){
        console.log(1);
        swal(o.config.title);
    },
    alertSuccess:function(o){
        swal(o.config.title, o.config.text, "success");
    },
    alertError:function(o){
        swal(o.config.title, o.config.text, "error");
    },
    alertDelete:function(o,callback){
        swal({
            title: o.config.title,
            text: o.config.text,
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            html: true,
            confirmButtonText: o.config.confirm_text,
            animation: "slide-from-top",
            confirmButtonColor: "#ec6c62"
        }, function() {
            $.ajax({
                url: o.config.ajax_url,
                type: "DELETE"
            }).done(function(data) {
                swal("提示", "操作成功！", "success");
            }).error(function(data) {
                swal("提示", "操作失败!", "error");
            });
        });
    },
    alertTimer:function(o){
        swal({
            title: o.config.title,
            text: o.config.text,
            imageUrl: o.config.imageUrl,
            html: true,
            timer: o.config.time,
            showConfirmButton: true
        });
    },
    alertInput:function(o,callback){
        swal({
            title: o.config.title,
            text: o.config.text,
            type: "input",
            showCancelButton: true,
            closeOnConfirm: false,
            animation: "slide-from-top",
            inputPlaceholder: o.config.placeholder
        }, function(inputValue){
            if (inputValue === false) return false;
            if (inputValue === "") {
                swal.showInputError("请输入!");
                return false
            }
            if(callback instanceof Function){
                callback();
            }
            swal("提示", "您填写的是: " + inputValue, "success");
        });
    }
}