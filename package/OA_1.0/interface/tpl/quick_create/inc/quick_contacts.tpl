<div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">联系人名称<span class="required" aria-required="true">*</span></label>

            <div class="col-md-10">
                <input class="form-control" placeholder="请输入联系人名称" type="text" name="data_c[username]" value="{$_data['username']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">手机号<span class="required" aria-required="true">*</span></label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="手机或电话-例：13888888888/0218888888" name="data_c[phone]" value="{$data['phone']}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">业务类型</label>
            <div class="col-md-10">
                {if $categoryInfo[$_REQUEST['category_id']][3]==0}
                    <input type="text" disabled class="form-control" value="{$_REQUEST['category_id']}{$categoryInfo[$_REQUEST['category_id']][0]}" />
                    <input type="hidden"  name="data_c[business]" value="{$_REQUEST['category_id']}{$categoryInfo[$_REQUEST['category_id']][0]}" />
                {else}
                    <input type="text" disabled class="form-control" value="{$categoryInfo[$_REQUEST['category_id']][3]}{$_categories[0][$categoryInfo[$_REQUEST['category_id']][3]]}" />
                    <input type="hidden"  name="data_c[business]" value="{$categoryInfo[$_REQUEST['category_id']][3]}{$_categories[0][$categoryInfo[$_REQUEST['category_id']][3]]}" />
                {/if}
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">业务子类</label>

            <div class="col-md-10">
                <input type="text" disabled  class="form-control" value="{$_REQUEST['category_id']}{$categoryInfo[$_REQUEST['category_id']][0]}">
                <input type="hidden"  name="data_c[sub_business]" value="{$_REQUEST['category_id']}{$categoryInfo[$_REQUEST['category_id']][0]}">
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">城市<span class="required" aria-required="true">*</span></label>

            <div class="col-md-10">
                {*<select class="form-control" name="data_c[city]">*}
                    {*{foreach $_REQUEST['cities'] as $v}*}
                        {*<option value="{$v}">*}
                            {*{$v}*}
                        {*</option>*}
                    {*{/foreach}*}
                    {*<option>其他</option>*}
                {*</select>*}
                <input type="text" class="form-control input-sm select2 tags_select2" value="{$_data[0]['city']}" name="data_c[city]"   data-values="{implode(',',$_contacts_city)}">
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class=" col-md-2 control-label">公司名称</label>

            <div class="col-md-10">
                <input type="text" class="form-control" placeholder="公司名称" name="data_c[company]" value="{$data['company']}">
            </div>
        </div>
    </div>
</div>
