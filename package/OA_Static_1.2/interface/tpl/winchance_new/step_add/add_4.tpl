<div class="row">
    <div class="col-md-12">
    <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title drop-step">
                <div class="caption">
                    <i class="fa fa-cogs"></i>完善IP信息
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $step==4}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step4" style="display: {if $step==4}block{else}none{/if}">
                <form action="?action=dataSubmit" class="submit-add-four" method="post">
                <input type="hidden" name="step" value="4">
                <input type="hidden" name="id" value="{$data['id']}">
                <input type="hidden" name="admin_id" value="{$data['admin_id']}">
                <input type="hidden" name="submit_type" value="">
                {******审核列表搜索时使用到的字段***开始****}
                <input type="hidden" name="ip_name" value="{$data['ip_name']}">
                <input type="hidden" name="conform_crowd" value="{$data['conform_crowd']}">
                <input type="hidden" name="category" value="{$data['category']}">
                <input type="hidden" name="city" value="{$data['city']}">
                <input type="hidden" name="min_area" value="{$data['min_area']}">
                <input type="hidden" name="max_area" value="{$data['max_area']}">
                <input type="hidden" name="manifestation" value="{$data['manifestation']}">
                {******审核列表搜索时使用到的字段***结束****}
                <div class="form-body">
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">合作模式</label>
                        <div class="col-md-10  col-xs-10">
                            <div class="checkbox-list">
                                {foreach $cooperating_mode as $k=>$v}
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="cooperating_mode[]" value="{$v}" {if strstr($data['cooperating_mode'],$v)}checked{/if}> {$v} </label>
                                {/foreach}
                           </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">运营团队所属国家</label>
                        <div class="col-md-10  col-xs-10">
                            <div class="radio-list">
                                <label class="radio-inline">
                                    <input type="radio" name="grant_country" id="optionsRadios4" value="大陆" {if $data['grant_country']=='大陆' || empty($data['grant_country'])}checked{/if}>
                                    大陆 </label>
                                <label class="radio-inline">
                                    <input type="radio" name="grant_country" id="optionsRadios5" value="香港" {if $data['grant_country']=='香港'}checked{/if}> 香港
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="grant_country" id="optionsRadios5" value="日本" {if $data['grant_country']=='日本'}checked{/if}> 日本
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="grant_country" id="optionsRadios5" value="韩国" {if $data['grant_country']=='韩国'}checked{/if}> 韩国
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="grant_country" id="optionsRadios5" value="欧美" {if $data['grant_country']=='欧美'}checked{/if}> 欧美
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label style="margin-top: 5px;" class="col-md-2 control-label col-xs-2">策展人</label>
                        <div class="col-md-2  col-xs-3">
                            <div class="checkbox-list">
                                <label  style="margin-top: 5px;" class="checkbox-inline">
                                    <input type="radio" name="czr" value="0" {if empty($data['curator'])}checked {/if} > 无</label>
                                <label style="margin-top: 5px;" class="checkbox-inline">
                                    <input type="radio" name="czr" value="1" {if !empty($data['curator'])}checked {/if} > 有 </label>

                            </div>
                        </div>
                        <div class="col-md-2 col-xs-4 czr" style="display: {if !empty($data['curator'])}block{else}none{/if}">
                            <input type="text" name="curator" class="form-control " placeholder="请填写策展人"value="{$data['curator']}">
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">授权费（元）</label>
                        <div class="col-md-2 col-xs-4">
                            <div class="input-group">
                                <input type="text" name="grant_fee[授权费]" placeholder="请填写授权费" value="{$data['grant_fee']['授权费'][0]}" class="form-control" required min="0">
                                <input type="hidden" name="unit[授权费]" value="场次" class="date-mo"/>
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-warning dropdown-toggle current-mo" data-toggle="dropdown">
                                        {if !empty($data['grant_fee']['授权费'][1])}{$data['grant_fee']['授权费'][1]}{else}/场次{/if}</button>
                                    {*<ul class="dropdown-menu pull-right dropdown-menu-one">*}
                                        {*<li>*}
                                            {*<a href="javascript:;">年</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">月</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">周</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">日</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">小时</a>*}
                                        {*</li>*}
                                    {*</ul>*}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">搭建费（元）</label>
                        <div class="col-md-2 col-xs-4">
                            <div class="input-group">
                                <input type="text" name="grant_fee[搭建费]" placeholder="请填写搭建费" value="{$data['grant_fee']['搭建费'][0]}" class="form-control" required min="0">
                                <input type="hidden" name="unit[搭建费]" value="场次" class="date-mo"/>
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-warning dropdown-toggle current-mo" data-toggle="dropdown">
                                        {if !empty($data['grant_fee']['搭建费'][1])}{$data['grant_fee']['搭建费'][1]}{else}/场次{/if}</button>
                                    {*<ul class="dropdown-menu pull-right dropdown-menu-one">*}
                                        {*<li>*}
                                            {*<a href="javascript:;">年</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">月</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">周</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">日</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">小时</a>*}
                                        {*</li>*}
                                    {*</ul>*}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">道具费（元）</label>

                        <div class="col-md-2 col-xs-4">

                            <div class="input-group">
                                <input type="text" name="grant_fee[道具费]" placeholder="请填写道具费" value="{$data['grant_fee']['道具费'][0]}"  class="form-control" required min="0">
                                <input type="hidden" name="unit[道具费]" value="场次" class="date-mo"/>
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-warning dropdown-toggle current-mo" data-toggle="dropdown">
                                        {if !empty($data['grant_fee']['道具费'][1])}{$data['grant_fee']['道具费'][1]}{else}/场次{/if}</button>
                                    {*<ul class="dropdown-menu pull-right dropdown-menu-one">*}
                                        {*<li>*}
                                            {*<a href="javascript:;">年</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">月</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">周</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">日</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">小时</a>*}
                                        {*</li>*}
                                    {*</ul>*}
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">运营费（元）</label>

                        <div class="col-md-2 col-xs-4">

                            <div class="input-group">
                                <input type="text" name="grant_fee[运营费]" placeholder="请填写运营费" value="{$data['grant_fee']['运营费'][0]}"  class="form-control" required min="0">
                                <input type="hidden" name="unit[运营费]" value="场次"   class="date-mo"/>
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-warning dropdown-toggle current-mo" data-toggle="dropdown">
                                        {if !empty($data['grant_fee']['运营费'][1])}{$data['grant_fee']['运营费'][1]}{else}/场次{/if}</button>
                                    {*<ul class="dropdown-menu pull-right dropdown-menu-one">*}
                                        {*<li>*}
                                            {*<a href="javascript:;">年</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">月</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">周</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">日</a>*}
                                        {*</li>*}
                                        {*<li>*}
                                            {*<a href="javascript:;">小时</a>*}
                                        {*</li>*}
                                    {*</ul>*}
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">档期</label>
                        <div class="col-md-4 col-xs-6">
                            {*<div class="input-group input-large date-picker input-daterange" data-date="10/11/2012" data-date-format="mm/dd/yyyy">*}
                                {*<input type="text" class="form-control date" name="schedule_start" readonly placeholder="开始时间" value="{$data['schedule'][0]}">*}
                                                                    {*<span class="input-group-addon">*}
                                                                    {*to</span>*}
                                {*<input type="text" class="form-control date"  name="schedule_end"  readonly  placeholder="结束时间" value="{$data['schedule'][1]}">*}
                            {*</div>*}

                            <input type="text" name="schedule" class="form-control " placeholder="请填写档期信息"value="{$data['schedule']}">
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">物料来源</label>
                        <div class="col-md-10  col-xs-10">
                            <div class="radio-list">
                                <label class="radio-inline">
                                    <input type="radio" name="materiel_source" id="optionsRadios4" value="展销" {if $data['materiel_source']=='展销' || empty($data['materiel_source'])} checked{/if}>
                                    展销 </label>
                                <label class="radio-inline">
                                    <input type="radio" name="materiel_source" id="optionsRadios5" value="直销" {if $data['materiel_source']=='直销'} checked{/if}>直销
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="materiel_source" id="optionsRadios5" value="现成" {if $data['materiel_source']=='现成'} checked{/if}> 现成
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="materiel_source" id="optionsRadios5" value="定制" {if $data['materiel_source']=='定制'} checked{/if}> 定制
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">备注</label>
                        <div class="col-md-4 col-xs-6">
                            <textarea id="draft_add_four" class="form-control" name="note" rows="10" placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                        </div>
                    </div>
                </div>
                {if $step>=4}
                <div class="form-actions">
                    <button type="button" data-re-url="{$_home}winchance_new/winchance_list?action=list" class="btn btn-info draft_submit_four">保存</button>
                    <button type="button" class="btn btn-success add-four">提交审核</button>
                </div>
                {/if}
                </form>
            </div>
        </div>
    </div>
    <!-- END ALERTS PORTLET-->
</div>

<script>
    $(".add-four").click(function(){
        if(confirm('确定【完善IP信息】已填写完整并提交到审核阶段吗？   注：此阶段审核通过后才可以进行下一步操作哦！')){
            $(".submit-add-four").submit();
        }else{
            return false;
        }
    });
    $(".draft_submit_four").click(function () {
        $("input[name='submit_type']").val('draft');
        $(".submit-add-four").submit();
    });
</script>
