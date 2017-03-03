<div class="row">
    <div class="col-md-6">
        <div class="form-group check_div">
            <label class=" col-md-2 control-label">供应商名称</label>

            <div class="col-md-10">
                <input class="form-control checkVendor" placeholder="请输入供应商名称" type="text" name="data_v[vendor_name]" value="{$_data['0']['product_name']}">
                <span class="vendor_msg"></span>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">地址</label>

            <div class="col-md-10">
                <input class="form-control" type="text" name="data_v[addr]" value="{$_data['0']['product_addr']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">服务类型</label>

            <div class="col-md-10">
                <input disabled class="form-control" type="text" value="{$categoryInfo[$_REQUEST['category_id']][0]}">
                <input class="form-control" type="hidden" name="data_v[categories_id]" value="{$_REQUEST['category_id']}">
            </div>
        </div>
    </div>
    {foreach $_vendor_attr['attr'] as $k=>$v}
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-2 control-label">{$k}</label>

                <div class="col-md-10">
                    {if $v}
                        <input type="text" class="form-control tags_select2" name="data_v[attr][{$k}]" value="{$_data['0']['attr'][$k]}" data-values="{implode(',',$v)}">
                    {else}
                        <input type="text" class="form-control" name="data_v[attr][{$k}]" value="{$_data['0']['attr'][$k]}">
                    {/if}
                </div>
            </div>
        </div>
    {/foreach}
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">公司网址</label>

            <div class="col-md-10">
                <input class="form-control" type="text" name="data[base_info][公司网站]" value="{$_data['0']['vendor_base_info']['公司网站']}">
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label class=" col-md-1 control-label">公司介绍</label>

            <div class="col-md-11">
                <textarea class="form-control
                " name="data_v[des]" rows="10">{$_data['0']['product_des']}</textarea>
            </div>
        </div>
    </div>

</div>
<script>
    $('.checkVendor').blur(function(){
        var vendor_name=$(this).val();
        if(!vendor_name){
            return false;
        }
        $.post('?',{ action:'exists',vendor_name:vendor_name},function(data){
            if(data.status!=1){
                $('.check_div').addClass('has-error');
                $(".vendor_msg").html('<i class="glyphicon glyphicon-remove">'+data.msg+'</i>').addClass('help-block');
            }else{
                $('.check_div').removeClass('has-error');
                $(".vendor_msg").html('').removeClass('help-block');
            }
        },'json')
    })
</script>