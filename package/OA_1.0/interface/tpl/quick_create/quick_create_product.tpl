<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>快速创建产品
        </div>
    </div>
    <div class="portlet-body form-horizontal">
        <div class="form-body" style="min-height: 350px;">
            {if $_REQUEST['category_id']}
                <form class="form-horizontal" role="form" action="?" method="post">
                    <input type="hidden" name="action" value="is_submit">

                    <div class="clear"><h3 class="form-section">联系人信息</h3>
                    </div>
                    {include file="quick_create/inc/quick_contacts.tpl"}
                    <div class="clear"><h3 class="form-section">供应商信息</h3>
                    </div>
                    {include file="quick_create/inc/quick_vendor.tpl"}
                    <div class="clear"><h3 class="form-section">产品信息</h3>
                    </div>
                    {include file="quick_create/inc/quick_product.tpl"}

                    <div class="form-actions text-center">
                        <button type="reset" class="btn btn-default">
                            重置
                        </button>
                        <button type="submit" class="btn btn-success">
                            提交
                        </button>
                    </div>

                </form>
            {else}
                <div class="row">
                    <div class="form-group">
                        <label class="col-md-3 control-label">请先选择服务分类</label>

                        <div class="col-md-7">
                            <select class="form-control select2me" name="category_id" data-placeholder="Select...">
                                {function show_category level=0}
                                    {foreach $_categories[$id] as $k=>$v}
                                        {if $v}
                                        <option value="{$k}" {if $k==$_data['category_id']}selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                            {$k}. {$v}
                                        </option>
                                        {/if}
                                        {if $_categories[$k]}
                                            {show_category data=$_categories id=$k lv=$lv+1}
                                        {/if}
                                    {/foreach}
                                {/function}
                                {show_category data=$_categories id=0 lv=1}
                            </select>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <label class="col-md-3 control-label"></label>
                        <div class="col-md-8">
                            (<font color="red">*</font>如需创建新的供应商，则不填写下边两项)
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">请选择供应商</label>

                        <div class="col-md-7 vendor_div">
                            <div class="col-md-12 input-group select">
                                <input id="select2_sample6" type="hidden" class="form-control select2">
                                <span class="vendor_msg"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group product_div">
                        <label class="col-md-3 control-label">请输入产品名称</label>

                        <div class="col-md-7">
                                <input type="text" class="form-control product_name" name="product_name">
                                <span class="product_msg"></span>
                        </div>
                    </div>
                </div>
                <div class="form-actions text-center">
                    <a class="btn btn-success getCategory" href="javascript:;">快速创建产品</a>
                </div>
            {/if}
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function () {
        $('.wysihtml5').wysihtml5();
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('.tags').tagsInput({
            width: 'auto'
        });
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
        $('.getCategory').click(function () {
            var category_id = $('.select2me').val();
            var vendor_id=$('#select2_sample6').val();
            var product_name=$('.product_name').val();
            if (!category_id) {
                return false;
            }
            if(!vendor_id && !product_name){
                window.location.href = '?category_id=' + category_id;
            }else if(vendor_id && !product_name){
                $('.product_div').addClass('has-error');
                $(".product_msg").html('<i class="glyphicon glyphicon-remove">产品名称不能为空</i>').addClass('help-block');
                $('.vendor_div').removeClass('has-error');
                $(".vendor_msg").html('').removeClass('help-block');
                return false;

            }else if(product_name && !vendor_id){
                $('.vendor_div').addClass('has-error');
                $(".vendor_msg").html('<i class="glyphicon glyphicon-remove">请选择所属供应商</i>').addClass('help-block');
                $('.product_div').removeClass('has-error');
                $(".product_msg").html('').removeClass('help-block');
                return false;
            }else{
                $.post('?',{ action:'quickCreate',product_name:product_name,vendor_id:vendor_id,category_id:category_id },function(data){
                    if(data.status!=1){
                        top.alert(data.msg);
                    }else{
                        window.location.href = '{$_route}my_vendor_list?action=detail&tab=product&id=' + data.data['account_id']+'&product_id='+data.data['product_id'];
                    }
                    console.log(data);
                },'json')
            }

        });
        $("#select2_sample6").select2({
            placeholder: "选择供应商",
            minimumInputLength: 1,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
                url: "?vendor_auto_complete=1",
                dataType: 'json',
                data: function (term, page) {
                    return {
                        q: term, // search term
                        page_limit: 10
                    };
                },
                results: function (data, page) { // parse the results into the format expected by Select2.
                    // since we are using custom formatting functions we do not need to alter remote JSON data
                    return {
                        results: data.items
                    };
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id !== "") {
                    $.ajax("?vendor_auto_complete=1", {
                        data: {
                            id: id
                        },
                        dataType: "json"
                    }).done(function (data) {
                                console.log(data);
                                callback(data.items[0]);
                            });
                }
            },
            formatResult: formatRepo, // omitted for brevity, see the source of this page
            formatSelection: formatRepoSelection, // omitted for brevity, see the source of this page
            escapeMarkup: function (m) {
                return m;
            } // we do not want to escape markup since we are displaying html in results
        });
        function formatRepo(repo) {
            if (repo.loading) return repo.text;
            return repo.full_name;
        }

        function formatRepoSelection(repo) {
            return repo.full_name || repo.text;
        }
    });
</script>
</body>
<!-- END BODY -->
</html>