<style>
    #select2-chosen-2{
        color: #333;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title drop-step">
                <div class="caption">
                    <i class="fa fa-cogs"></i>储备信息
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $step==1}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display: {if $step==1}block{else}none{/if}">
                <form action="?action=dataSubmit" class="submit-add-one" method="post">
                    <input type="hidden" name="step" value="1">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" name="admin_id" value="{$data['admin_id']}">
                    <input type="hidden" name="check_id" value="{$data['check_id']}">
                    <input type="hidden" name="submit_type" value="">
                    <input type="hidden" name="company" placeholder="请选择IP品牌" value="{$data['company']}"
                           class="hidden-company">
                    <input type="hidden" name="figure" placeholder="请选择IP人物形象" value="{$data['figure']}"
                           class="hidden-figure">
                    {******审核列表搜索时使用到的字段***开始****}
                    <input type="hidden" name="ip_name" value="{$data['ip_name']}">
                    <input type="hidden" name="conform_crowd" value="{$data['conform_crowd']}">
                    <input type="hidden" name="category" value="{$data['category']}">
                    <input type="hidden" name="city" value="{$data['city']}">
                    <input type="hidden" name="min_area" value="{$data['min_area']}">
                    <input type="hidden" name="max_area" value="{$data['max_area']}">
                    <input type="hidden" name="manifestation" value="{$data['manifestation']}">
                    <input type="hidden" name="cooperating_mode" value="{$data['cooperating_mode']}">
                    {******审核列表搜索时使用到的字段***结束****}
                    <div class="form-body">
                        <div class="form-group clearfix company-name">
                            <label class="col-md-2 control-label col-xs-2">IP品牌</label>

                            <div class="col-md-4 col-xs-6">

                                <div class="form-control" id="brand"
                                     data-url="http://{Core::$urls['host']}/static/api/winchance/new/company/auto/complete.jsonp">
                                    <input type="text" name="company" placeholder="请选择IP品牌" value="{$data['company']}">
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix figure-name">
                            <label class="col-md-2 control-label col-xs-2">IP形象</label>

                            <div class="col-md-4 col-xs-6">
                                <div class="form-control" id="figure"
                                     data-url="http://{Core::$urls['host']}/static/api/winchance/new/figure/auto/complete.jsonp">
                                    <input type="text" name="figure" placeholder="请选择IP人物形象" value="{$data['figure']}">
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">IP名称</label>

                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="ip_name" class="form-control " placeholder="请输入IP名称" required
                                       value="{$data['ip_name']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">来源国家</label>

                            <div class="col-md-10  col-xs-10">
                                <div class="radio-list">
                                    {foreach $country as $k=>$v}
                                        <label class="radio-inline">
                                            <input type="radio" name="country" value="{$v}"
                                                   {if !isset($data) && $v=='中国'}checked{elseif $data['country']==$v}checked{/if}>
                                            {$v}
                                        </label>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">备注</label>

                            <div class="col-md-4 col-xs-6">
                                <textarea id="draft_add_one" class="form-control" name="note" rows="10"
                                          placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        {*{if $_REQUEST['action']!='add' && empty($data['check_id'])}*}
                            <button type="button" data-re-url="{$_home}winchance_new/winchance_list?action=list"
                                    class="btn btn-info draft_submit_one">保存
                            </button>
                        {*{/if}*}
                        <button type="button" class="btn btn-success add-one">提交审核</button>
                    </div>
                </form>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>
<script>
    $(".add-one").click(function () {
        if (confirm('确定【储备信息】已填写完整并提交到审核阶段吗?   注：此阶段审核通过后才可以进行下一步操作哦！')) {
            $(".submit-add-one").submit();
        } else {
            return false;
        }
    });
    $(".draft_submit_one").click(function () {
        $("input[name='submit_type']").val('draft');
        $(".submit-add-one").submit();
    });
    $('#brand').on('change',function(){
        $(".company-name").find('.select2-chosen').css("color","#222");
    });
    $('#figure').on('change',function(){
        $(".figure-name").find('.select2-chosen').css("color","#222");
    });

</script>