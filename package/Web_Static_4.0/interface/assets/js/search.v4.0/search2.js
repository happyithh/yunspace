$(document).ready(function(){
    /*搜索入口页*/
    $('#site_library').click(function(){
       $(this).removeClass('search_page_site');
        $(this).addClass('search_page_site_active');
        $('#project_library').removeClass('search_page_project_active');
        $('#project_library').addClass('search_page_project');
        $('#company_library').removeClass('search_page_company_active');
        $('#company_library').addClass('search_page_company');
        $('#paper_library').removeClass('search_page_paper_active');
        $('#paper_library').addClass('search_page_paper');
        $('.search_page_label').html('场地库');
        $('.search_page_input_value').html('搜索场地资料 / 文创');
        $('.search_type').val('site_library');
        $('.search_page_input_value').css('display','block');
        $('.search_page_input').val('');
    });
    $('#project_library').click(function(){
        $(this).removeClass('search_page_project');
        $(this).addClass('search_page_project_active');
        $('#site_library').removeClass('search_page_site_active');
        $('#site_library').addClass('search_page_site');
        $('#company_library').removeClass('search_page_company_active');
        $('#company_library').addClass('search_page_company');
        $('#paper_library').removeClass('search_page_paper_active');
        $('#paper_library').addClass('search_page_paper');
        $('.search_page_label').html('资讯库');
        $('.search_page_input_value').html('搜索资讯资料');
        $('.search_type').val('project_library');
        $('.search_page_input_value').css('display','block');
        $('.search_page_input').val('');
    });
    $('#company_library').click(function(){
        $(this).removeClass('search_page_company');
        $(this).addClass('search_page_company_active');
        $('#site_library').removeClass('search_page_site_active');
        $('#site_library').addClass('search_page_site');
        $('#project_library').removeClass('search_page_project_active');
        $('#project_library').addClass('search_page_project');
        $('#paper_library').removeClass('search_page_paper_active');
        $('#paper_library').addClass('search_page_paper');
        $('.search_page_label').html('公司库');
        $('.search_page_input_value').html('搜索公司资料');
        $('.search_type').val('company_library');
        $('.search_page_input_value').css('display','block');
        $('.search_page_input').val('');
    });
    $('#paper_library').click(function(){
        $(this).removeClass('search_page_paper');
        $(this).addClass('search_page_paper_active');
        $('#site_library').removeClass('search_page_site_active');
        $('#site_library').addClass('search_page_site');
        $('#project_library').removeClass('search_page_project_active');
        $('#project_library').addClass('search_page_project');
        $('#company_library').removeClass('search_page_company_active');
        $('#company_library').addClass('search_page_company');
        $('.search_page_label').html('文库');
        $('.search_page_input_value').html('搜索文库');
        $('.search_type').val('paper_library');
        $('.search_page_input_value').css('display','block');
        $('.search_page_input').val('');
    });
    $('.search_page_input_value').click(function(){
        $(this).css('display','none');
        $('.search_page_input').focus();
    });
    $('.search_page_input').focus(function(){
        $('.search_page_input_value').css('display','none');
    });
    /*搜索列表页*/
    $('.others_search_more').click(function() {
       $('.others_search_content').toggleClass('others_search_content_height');
        $('.others_search_icon').toggleClass('others_search_icon_toggle');
        if($('.others_search_icon').hasClass('others_search_icon_toggle')){
            $('.others_search_word').html('收起');
            $('.section_more_less').show();
        }else{
            $('.others_search_word').html('展开');
            $('.section_more_less').hide();
        }
    });
    $('#search_content_btn').click(function(){
        $('#search_content').hide();
        $('#search_selected').show();
    });
    $('#search_selected_btn').click(function(){
        $('#search_selected').hide();
        $('#search_content').show();
    });

    $(".search_list").hover(function(){
        $(this).find(".search_site").css({
            "width": "100px",
            "backgroundPosition":"-17px",
            "paddingLeft":"30px",
            "position":"absolute",
            "right":"-105px"
        });
        $(this).find(".search_date").css({
            "width": "100px",
            "backgroundPosition":"-17px",
            "paddingLeft":"30px",
            "position":"absolute",
            "right":"-105px",
            "top":"30px"
        });
        $(this).find(".search_wt").css({
            "width": "100px",
            "backgroundPosition":"-17px",
            "paddingLeft":"30px",
            "position":"absolute",
            "right":"-105px"
        });
        $(this).find(".search_article").css({
            "width": "100px",
            "backgroundPosition":"-17px",
            "paddingLeft":"30px",
            "position":"absolute",
            "right":"-105px",
            "top":"0"
        });

    },function(){
        $(this).find(".search_site").css({
            "width": "2px",
            "backgroundPosition":"0px",
            "paddingLeft":"15px",
            "position":"static"
        });
        $(this).find(".search_date").css({
            "width": "2px",
            "backgroundPosition":"0px",
            "paddingLeft":"15px",
            "position":"static"
        });
        $(this).find(".search_wt").css({
            "width": "2px",
            "backgroundPosition":"0px",
            "paddingLeft":"15px",
            "position":"static"
        });
        $(this).find(".search_article").css({
            "width": "2px",
            "backgroundPosition":"0px",
            "paddingLeft":"15px",
            "position":"static"
        });
    });


    $('.search_input_value').click(function(){
        $(this).css('display','none');
        $('.search_input').focus();
    });
    $('.search-box-placeholder').click(function(){
        $(this).css('display','none');
        $(this).siblings(".search-box-input").focus();
        $('.search-date-outside').hide();
    });
    $(".j_search_date").on("click",function(){
        var space_id =$(this).attr('data-id');
        var space_name =$(this).attr('data-name');
        var demand_city=$(this).attr('data-city');
        $(".search-box").find(".space_id").val(space_id);
        $(".search-box").find(".space_name").val(space_name);
        $(".search-box").find(".demand_city").val(demand_city);
        $(".cover,.search-box").fadeIn();
    });

    $('#search-box-close').on('click',function(){
        $(".search-box").find("input[name='username']").val('');
        $(".search-box").find("input[name='phone']").val('');
        $(".search-box").find("input[name='date_start']").val('');
        $(".search-box").find("input[name='date_end']").val('');
        $(".search-box").find("input[name='other_demand']").val('');
        $(".cover,.search-box").fadeOut();
    });
    $('.search-box-btn').on('click',function(){
        var contact_name = $(".search-box").find("input[name='username']").val();
        var contact_phone = $(".search-box").find("input[name='phone']").val();
        var start_time = $(".search-box").find("input[name='date_start']").val();
        var end_time = $(".search-box").find("input[name='date_end']").val();
        var other_demand = $(".search-box").find("input[name='other_demand']").val();
        var space_id = $(".search-box").find(".space_id").val();
        var space_name = $(".search-box").find(".space_name").val();
        var from_type = $(".search-box").find(".from_type").val();
        var demand_city = $(".search-box").find(".demand_city").val();
        var from_demand = '';
        var object_type='';
        var data_a='';
        var item_name=$(".search-box").find("input[name='item_name']").val();
        var item_id=$(".search-box").find("input[name='item_id']").val();
        switch (from_type){
            case '1':
                from_demand = "来源百科id:"+space_id+"百科名："+space_name;
                object_type="site";
                break;
            case '2':
                from_demand = "来源资讯id:"+space_id+"资讯标题："+space_name;
                break;
            case '3':
                from_demand = "来源供应商id:"+space_id+"供应商名称："+space_name;
                object_type="vendor";
                break;
            case '4':
                from_demand = "来源文库id:"+space_id+"文库名："+space_name;
                break;
            default :
                from_demand ="默认";
                break;
        }
        if(from_type!=''){
            if(contact_name==''){
                $(".search-box").find(".error_msg").removeClass('none');
                $(".search-box").find(".error_msg").html('请填写您的称呼，方便我们联系你！');
                setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                return false;
            }
            if(contact_phone==''){
                $(".search-box").find(".error_msg").removeClass('none');
                $(".search-box").find(".error_msg").html('请填写您的手机号，方便我们联系你！');
                setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                return false;
            }
        }
        if(from_type==1){
            if(start_time==''){
                $(".search-box").find(".error_msg").removeClass('none');
                $(".search-box").find(".error_msg").html('请选择开始日期，以便为您确定档期！');
                setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                return false;
            }
            if(end_time==''){
                $(".search-box").find(".error_msg").removeClass('none');
                $(".search-box").find(".error_msg").html('请选择结束日期，以便为您确定档期！');
                setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                return false;
            }
            data_a = {
                username: contact_name,
                phone: contact_phone,
                content: other_demand+from_demand,
                start_time: start_time,
                end_time: end_time,
                from_type: from_type,
                object_id: space_id,
                object_name: space_name,
                object_type: object_type,
                demand_city:demand_city,
                action: 'new_events',
                item_name:item_name,
                item_id:item_id
            };
        }else{
            if(other_demand==''){
                $(".search-box").find(".error_msg").removeClass('none');
                $(".search-box").find(".error_msg").html('请填写你要咨询的问题！');
                setTimeout("$('.search-box').find('.error_msg').addClass('none')",3000);
                return false;
            }
            data_a = {
                username: contact_name,
                phone: contact_phone,
                content: other_demand+from_demand,
                from_type: from_type,
                object_id: space_id,
                object_name: space_name,
                object_type: object_type,
                demand_city:demand_city,
                action: 'new_events',
                item_name:item_name,
                item_id:item_id
            };
        }
        //console.log(data_a);
        //return false;
        YunSpace.api("demand/create.jsonp", data_a, function (data) {
            if (data.status == 1) {
                alert('提交成功，我们会尽快与您联系！');
                $(".cover,.search-box").fadeOut();
            }else{
                alert(data.msg);
            }
        });
        //$(".cover,.search-box").fadeOut();
    });

    $('.search-date-start').focus(function(){
        $('.search-date-outside').show();

    });
    $('.search-date-end').focus(function(){
        $('.search-date-outside').show();
    });
    //console.log($('.dp-date').length);

    $(".search_label > span").on("click",function(){
        var $this=$(this);
        $(".search_label").addClass("search_label_active");
        $this.parent().find(".search_label_list").fadeIn();
    });
    $(".search_label_list").find("li").each(function(index,dom){
        var $dom=$(dom);
        $dom.on("click",function(){
            var $this=$(this);
            var v=$this.text();
            var searchType=$("#search_type");
            $(".search_label>span").text(v);
            $("input[name='search_type']").val(v);
            $(".search_label_list").hide();
            $(".search_label").removeClass("search_label_active");
            switch (v){
                case '找场地':
                    searchType.val('site_library');
                    break;
                case '找资讯':
                    searchType.val('project_library');
                    break;
                case '找公司':
                    searchType.val('company_library');
                    break;
                case '找文库':
                    searchType.val('paper_library');
                    break;
            }
        });
    });

    $(".js-a-downup").on("click",function(){
        if($(this).hasClass("a-up")){
            $(this).siblings(".search_select_section_right").css("height","26px");
            $(this).removeClass("a-up");
            $(this).parents(".search_select_section").css({'padding-bottom':'10px'});
        }else{
            $(".js-a-downup").removeClass("a-up");
            $(this).addClass("a-up");
            $(this).siblings(".search_select_section_right").css("height","auto");
        }
    });


    $(".search_input").on("focus keyup",function(){
        var $this=$(this);
        var keyword=$this.val();
        if(keyword==""){
            return false;
        }
        $(".search_input_pre").html("");
        var clone=$(".clone_search");
        var searchType=$("#search_type").val();
        $(".search_input_pre").show();
        YunSpace.api("search/get/library/list.jsonp",{
            keyword:keyword,
            action:"list_search"
        },function(data){
            if(data.status=="1"){
                var html="";
                for(var k in data.data){
                    var cloneSearch=clone.clone().removeClass('none');
                    cloneSearch.find("a").text(data.data[k]['s_key']);
                    var hre="/database?action=is_submit&search_type="+searchType+"&keyword="+data.data[k]['s_key'];
                    cloneSearch.find("a").attr('href',hre);
                    var htm=cloneSearch.prop('outerHTML');
                    html+=htm;
                }
                $(".search_input_pre").append(html);
            }
        });
    });
    $(document).on("click",function(e){
        if($(e.target).closest(".search_label").length==0){
            $(".search_label_list").hide();
            $(".search_label").removeClass("search_label_active");
        }
        if($(e.target).closest(".search_input_body").length==0){
            $(".search_input_pre").hide();
        }
    });


    //城市筛选一行显示去掉图标
    $('.search_select_section_right').each(function(){
        var numbLi=$(this).find('li').length;
        if(numbLi<8){
            $(this).siblings('.a-downup-wrapper').hide();
        }
    });




});