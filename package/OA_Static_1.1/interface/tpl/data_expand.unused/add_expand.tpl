<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js" xmlns="http://www.w3.org/1999/html">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>
            添加拓展信息
        </div>
    </div>
    <div class="portlet-body">
        <div class="tab-content clearfix">
            <form action="?" method="post" class="form1">
                <input type="hidden" name="action" value="add_expand_submit">
                <input type="hidden" name="handle_type" value="{$_REQUEST['handle_type']}">
                <input type="hidden" name="url_back" value="{Core::$urls['referer']}">
                <div class="tab-pane fade active in">
                    <div class="table-responsive clearfix">
                        <div class="col-md-9 form-group">
                            <label class="control-label col-md-2" style="font-size: 15px;">供应商
                                <a style="font-size: 5px;text-decoration: underline;" href="http://www.baidu.com/s?wd={$vendorInfo['vendor_name']}" target="_blank">搜索</a>
                            </label>

                            <div class="col-md-10">
                                <input type="text" disabled class="form-control" value="{$vendorInfo['vendor_name']}">
                                <input type="hidden" class="form-control" value="{$vendorInfo['id']}" name="vendor_id">
                            </div>
                        </div>
                        <div class="col-md-9 form-group check_div">
                            <label class="control-label col-md-2" style="font-size: 15px;">手机号</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" value="{$vendorInfo['phone']}" placeholder="请输入有效手机号" name="phone">
                                <span class="phone_msg"></span>
                            </div>
                        </div>
                        <div class="col-md-9 form-group">
                            <label class="control-label col-md-2" style="font-size: 15px;">邮箱</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" value="{$vendorInfo['email']}" placeholder="请输入邮箱" name="email">
                            </div>
                        </div>
                        <div class="col-md-9 form-group">
                            <label class="control-label col-md-2" style="font-size: 15px;">联系人</label>

                            <div class="col-md-10">
                                <input type="text" class="form-control" value="{$vendorInfo['username']}" placeholder="请输入联系人名称" name="username">
                                <span class="help-block">(不填写默认为手机号)</span>
                            </div>
                        </div>
                    </div>
                </div>

                {if $product}
                    <div class="table-responsive clearfix">
                        <div class="col-md-9 form-group">
                            <table class="table table-striped table-bordered table-advance table-hover">
                                <thead>
                                <tr>
                                    <th width="10%">产品ID</th>
                                    <th width="30%">产品名称</th>
                                    <th width="30%">产品价格</th>
                                    <th width="30%">面积</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $product as $k=>$v}
                                    <tr>
                                        <td>
                                            {$v['id']}
                                            <input type="hidden" class="form-control" value="{$v['id']}" name="data_product[{$v["id"]}][product_id]">
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" value="{$v['product_name']}" name="data_product[{$v["id"]}][product_name]">
                                        </td>
                                        <td>
                                            <div class="input-group">
                                                <input type="text" class="form-control" value="{$v['price']/100}" name="data_product[{$v["id"]}][price]">
                                                <span class="input-group-addon">元</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="input-group">
                                                <input type="text" class="form-control" value="{$v['product_size']}" name="data_product[{$v["id"]}][product_size]">
                                                <span class="input-group-addon">平方米</span>
                                            </div>
                                        </td>
                                        {*<td>*}
                                            {*<a href="javascript:;" data-pid="{$v['id']}" class="btn btn-xs btn-primary update_product">保存</a>*}
                                        {*</td>*}
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                {/if}


                <div class="form-actions text-center">
                    <button type="reset" class="btn btn-default not_do">
                        重置
                    </button>
                    <button type="button" class="btn btn-success expand_submit">
                        提交
                    </button>
                    <button type="button" class="btn btn-warning abandon_vendor">
                        丢弃
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>

<script>
    $('.expand_submit').click(function(){
        var phone=$('input[name=phone]').val();
        var vendor_id=$('input[name=vendor_id]').val();
        var username=$('input[name=username]').val();
        var handle_type="{$_REQUEST['handle_type']}";
        if(!phone){
            return false;
        }
        $.post('?',{ action:'exists',phone:phone,vendor_id:vendor_id,handle_type:handle_type},function(data){
            if(data.status==1){
                //账户已存在
                $(".phone_msg").html('<i class="glyphicon glyphicon-remove">'+data.msg+'</i>').addClass('help-block');
                $('input[name=username]').val(data.data['username']);
                $('.not_do').text('否');
                $('.not_do').attr('type','button');

                $('.expand_submit').text('是');
                $('.expand_submit').click(function(){
                    $('.form1').submit();
                });
                $('.not_do').click(function(){
                    window.location.href="?";
                });
            }else{
                //账户不存在,表单提交
                $('.form1').submit();
            }
        },'json')
    });

//    $('.update_product').click(function(){
//        var product_id=$(this).attr('data-pid');
//        var product_name=$(this).parents('tr').find('td').eq(0).find('input[name=product_name]').val();
//        var price=$(this).parents('tr').find('td').eq(1).find('input[name=price]').val();
//        var product_size=$(this).parents('tr').find('td').eq(2).find('input[name=product_size]').val();
//        $.post('?',{
//                    action:'update_product',
//                    product_id:product_id,
//                    product_name:product_name,
//                    price:price,
//                    product_size:product_size
//                },function(data){
//                    if(data.status==1){
//                        top.alert(' '+data.msg);
//                    }else{
//                        top.alert(data.msg);
//                    }
//        },'json')
//    });
    $('.abandon_vendor').click(function(){
        if(!confirm("确定要丢弃该供应商吗？")){
            return false;
        }
        $.post('?',{
            action:'abandon_vendor',
            vendor_id:$('input[name=vendor_id]').val()
        },function(data){
            if(data.status==1){
                top.alert(' '+data.msg);
                window.location.href="?handle_type={$_REQUEST['handle_type']}";
            }else{
                top.alert(data.msg);
            }
        },'json')
    })

</script>

</body>

<!-- END BODY -->
</html>