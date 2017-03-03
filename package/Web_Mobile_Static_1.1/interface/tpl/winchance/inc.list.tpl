{foreach $winchance_list as $key => $value}
    <div class="w-act-cont" data-createTime="{$value['create_time']}">
        <div class="img">
            <img src="{Page_Site_Global::displayMedia($value['media'][0]['path'],345,177)}">
        </div>
        <div class="col-ct-tit">
            <h3>{$value['title']}</h3>

            <p>{$value['marketing_title']}</p>
        </div>
        <div class="col-ct-mk">
            {foreach $value['tags_info'][0] as $k_tags=>$v_tags}
                <span>{$v_tags}</span>
            {/foreach}
        </div>
        <p>来&nbsp;&nbsp;源：<span>{$value['attr']['来源']}</span></p>

        <p>场地面积：<span>{$value['attr']['面积']}</span></p>

        <p>适用人群：<span>{$value['attr']['适用人群']}</span></p>

        <div class="col-ct-btn clearfix">
            <a class="btn btn-hz" href="tel::400-056-0599"><span class="icon-hz"></span>合作咨询</a>
            <a class="btn btn-dn" href="{$root}{$value['accessory']['name']}"><span class="icon-dn"></span>查看详情</a>
        </div>
    </div>
{/foreach}