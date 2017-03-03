$(document).ready(function () {
    //左侧导航高度100%
    var hmain=$('.user-center-main').height();
    $('.sidenav').height(hmain);


    //table隔行换色
    $('.my-table tr:nth-child(2n) td').css('background','#f2f2f2');


    //快捷入口去多余边框
    $('.user-tools-ul li:nth-child(3n+1)').css('border-left','none');


    //供应商和经纪人名词解释显示/隐藏
    $('.js-icon-doubt').hover(function(){
        $(this).find('.quest-details').stop().toggle();
    });


    //弹出黑色背景/白色内容背景/关闭按钮---和初始化
    $('.js-pop').click(function(){
        $('.user-pop-up').show().after('<div class="pop_bg"></div>');  //创建黑色背景
        $('.user-ppclose').click(function(){
            $('.user-pop-up').hide();      //初始化
            $('.apply-suppliers').hide();  //初始化
            $('.apply-agents').hide();     //初始化
            $('.yun-introrule').hide();    //初始化
            $('.entrance-pop-up').hide();  //初始化
            $('.pop_bg').remove();         //移除黑色背景
        });
    });
    //弹出申请成为供应商
    $('.js-apply-suppliers').click(function(){
        $('.apply-suppliers').show();
    });
    //弹出申请成为经纪人
    $('.js-apply-agents').click(function(){
        $('.apply-agents').show();
    });
    //弹出供应商介绍及规则
    $('.js-introrule').click(function(){
        $('.apply-suppliers').hide();
        $('.yun-introrule').show();
        $('.js-page-back').click(function(){
            $('.apply-suppliers').show();
            $('.yun-introrule').hide();
        });
    });
    //弹出我的快捷入口
    $('.js-more-entrance').click(function(){
        $('.entrance-pop-up').show().after('<div class="pop_bg"></div>');  //创建黑色背景
        $('.user-ppclose').click(function(){
            $('.entrance-pop-up').hide();
            $('.pop_bg').remove();         //移除黑色背景
        });
    });
    //添加/删除快捷入口
    $('.my-entrance li').bind("mouseenter",function(){
        hoverToChange($(this),"delete");
    }).bind("mouseleave",function(){
        $(this).find(".entra-delete-btn").remove();
    });

    $('.add-more-entrance li').bind("mouseenter",function(){
        hoverToChange($(this),"add");
    }).bind("mouseleave",function(){
        $(this).find(".entra-add-btn").remove();
    });
    function hoverToChange(o,target){
        if(target === "add"){
            o.append('<span class="entra-add-btn"></span>');
            o.find(".entra-add-btn").click(function(){

                $('.my-entrance').append($(this).parent());

                ($(this).parent()).unbind("mouseenter").bind("mouseenter",function(){
                    hoverToChange(o,"delete");
                }).unbind("mouseleave").bind("mouseleave",function(){
                    $(this).find(".entra-delete-btn").remove();
                });
                $(this).remove();
            });
        }else{
            o.append('<span class="entra-delete-btn"></span>');
            o.find(".entra-delete-btn").click(function(){
                $('.add-more-entrance').append($(this).parent());
                ($(this).parent()).unbind("mouseenter").bind("mouseenter",function(){
                    hoverToChange(o,"add");
                }).unbind("mouseleave").bind("mouseleave",function(){
                    $(this).find(".entra-add-btn").remove();
                });
                $(this).remove();
            });
        }

    }


});