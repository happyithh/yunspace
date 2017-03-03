<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/site_m.css"}
</head>
<body>
{*头部*}
<header class="site_header">
    <div class="clear_float">
        <div class="header_left">
            <a href="javascript:history.go(-1);"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>
<div class="clear"></div>

{*tab切换*}
<div class="site_tab_outside mt50">
    <ul class="site_tab">
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li>基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套设施</li></a>
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}">{if $data['status']==0}<li class="site_tab_active" style="padding-left: 15px;">图片管理<img style="width: 16px;height: 16px;float: right;" src="img/site_management/check.png" /></li>{elseif $data['status']==2}<li class="site_tab_active" style="padding-left: 15px;">图片管理<img style="width: 16px;height: 16px;float: right;" src="img/site_management/refuse.png" /></li>{else}<li class="site_tab_active">图片管理</li>{/if}</a>
    </ul>
</div>


{*8图片管理*}
<div class="content_m mt10">
    {if $data['status']==0}<div class="site_tab_notice" style="border-bottom: 1px solid #e1e1e1;border-top:none;padding-top: 0px;"><span style="color: #0dac7d;font-size: 14px;">待审核：</span>您的修改已经提交，预计会在2个工作日完成审核，请耐心等待，谢谢配合。</div>{elseif $data['status']==2}<div class="site_tab_notice" style="border-bottom: 1px solid #e1e1e1;border-top:none;padding-top: 0px;"><span style="color: #e72418;font-size: 14px;">审核未通过：</span>{$data['refuse_reason']}</div>{/if}
    <div class="site_pic_b_t">场地首页banner图</div>
    <div class="site_pic_b">
        <img src="{$data['data_backup']['logo']}">
    </div>
    {*<button class="change_pic">更改图片</button>*}
    <div class="change_pic_des">请上传尺寸为1920*520的图片，<br/>
        由于图片较大，建议在电脑端操作
    </div>

    <div class="site_pic_t">
        <a name="bianji"></a>
        <div class="site_pic_word">场地图片</div>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}" class="site_pic_btn">取消</a>
        <div class="clear"></div>
    </div>
<div class="site_list_outside">
    {foreach $data['data_backup']['media'] as $k=>$v}
    <div class="site_list">
      <div class="site_pic">
        <div class="site_pic_s">
            <img src="{$v['path']}">
            <div class="son_space_edit">
                <div class="son_delete">
                    <p>删除</p>
                </div>
                <div class="son_up">
                    <img src="img/site_management/son_icon2.png">
                </div>
                <div class="son_down">
                    <img src="img/site_management/son_icon3.png">
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="site_pic_c">
            <div class="site_pic_name">名称{$k+1}</div>
            {*contenteditable=""*}
            <div class="site_pic_name_c"><div class="site_pic_name_c_son"><input style="width: 100%;" value="{$v['name']}" /></div></div>
            {*<div class="site_pic_name_c"><div class="site_pic_name_c_son"><textarea width="1px;">{$v['name']}</textarea></div></div>*}
            {*<div class="site_pic_name_c"><div class="site_pic_name_c_son">{$v['name']}<br /></div></div>*}
            {*<div class="site_pic_name_c">{$v['name']}</div>*}
            {*<div class="site_pic_name_d" style="display: none;">{$v['tags']}</div>*}
            <div class="clear"></div>
        </div>
          <div class="site_pic_c" style="margin-top: 10px;">
              <div class="site_pic_name">标签</div>
              {*<div class="site_pic_name_c">{$v['tags']}</div>*}
              <select class="site_pic_name_c1">
                  <option {if $v['tags']=='外景图片'}selected{/if}>外景图片</option>
                  <option {if $v['tags']=='内景图片'}selected{/if}>内景图片</option>
                  <option {if $v['tags']=='平面图'}selected{/if}>平面图</option>
              </select>
              <div class="clear"></div>
          </div>
        {*<div class="site_pic_c">*}
            {*<div class="site_pic_name">所属空间</div>*}
            {*<div class="site_pic_name_c">露天广场</div>*}
            {*<div class="clear"></div>*}
        {*</div>*}
        <div class="clear"></div>
      </div>
      {*<div class="son_space_edit">*}
          {*<div class="son_delete">*}
            {*<p>删除</p>*}
          {*</div>*}
          {*<div class="son_up">*}
              {*<img src="img/site_management/son_icon2.png">*}
          {*</div>*}
          {*<div class="son_down">*}
              {*<img src="img/site_management/son_icon3.png">*}
          {*</div>*}
          {*<div class="clear"></div>*}
      {*</div>*}
    </div>
    {/foreach}
</div>
</div>
<input type="hidden" id="space_pedia_id" value="{$_REQUEST['space_pedia_id']}">
<div class="site_pop1">
    <div class="site_pop_title1">您确定要删除这张图片嘛</div>
    <a class="site_pag_cancel">取消</a>
    <a class="site_pag_confirm">确定</a>
</div>
<div class="site_mark1"></div>

<button class="site_confirm_btn">保存</button>
{static "v1.0/jquery-1.11.1.min.js"}
{static "site_management/plupload.full.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>