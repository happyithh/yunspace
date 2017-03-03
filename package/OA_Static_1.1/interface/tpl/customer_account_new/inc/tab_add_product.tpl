<div class="portlet-body form">
    <form class="form-horizontal" action="?" method="post" role="form">
        <input type="hidden" name="vendor_id" value="{$vendorInfo['id']}">
        <input type="hidden" name="action" value="{$_REQUEST['action']}">
        <input type="hidden" name="is_submit_add_product" value="1">
        <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
        <input type="hidden" name="city" value="{$accountInfo['vendors'][0]['attr']['城市']|default:'上海'}">
        <div class="alert alert-success" style="margin:20px 0">
            <strong>创建服务</strong>
        </div>
        <div class="form-body">
            <div class="form-group">
                <label class="col-md-3 control-label">服务名称<span class="required" aria-required="true">*</span></label>
                <div class="col-md-7">
                    <div class="input-icon">
                        <i class="fa fa-user"></i>
                        <input type="text" class="form-control" placeholder="Product Name"  name="product_name">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">服务分类</label>
                <div class="col-md-7">
                        <select class="form-control select2me" name="category_id" data-placeholder="Select..." onchange="Form_Attr.update(this)">
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
        </div>
        <div class="form-actions">
            <div class="form-group">
                <div class="col-md-offset-3 col-md-10">
                    <button type="submit" class="btn btn-success">
                        确认提交
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
