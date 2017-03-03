<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 15/9/21
 * Time: 上午9:17
 */

$detail = Web_Activity_Raiders_Detail::getInstance();
Data_Mysql_Table_Raiders_Info::footPrint($detail->id);
foreach ($detail->allCategory as $k =>$v) {
    if($detail->getRaidersDetail['category_id'] == $v['id']){
        $detail->getRaidersDetail['category_name'] = $v['name'];
    }
}
$detail_des = '';
if(!empty($detail->getRaidersDetail['detail_des'])) {
    $detail_des = array_filter($detail->getRaidersDetail['detail_des']);
}

$count = count($detail->getCommentLinks);
$str_parent = <<<str
<div class="info_article">
{$detail->getRaidersDetail['cont']}
</div>
str;
//q($detail->getCommentLinks);
$str_child = array();
if(!empty($detail->getCommentLinks)) {
    foreach($detail->getCommentLinks as $ck=>$cv) {
        if(!empty($cv[0]['product_name'])) {
            $detail->getCommentLinks[$ck][0]['attr_index'] = json_decode($cv[0]['attr_index'], 1);
            $detail->getCommentLinks[$ck][0]['product_name'] = mb_strimwidth($cv[0]['product_name'],0,18,'','UTF-8');
            $detail->getCommentLinks[$ck][0]['attr_index'][2] = mb_substr($detail->getCommentLinks[$ck][0]['attr_index'][2],0,7,'UTF-8');
            $detail->getCommentLinks[$ck][0]['attr_index'][10] = mb_substr($detail->getCommentLinks[$ck][0]['attr_index'][10],0,7,'UTF-8');
            $detail->getCommentLinks[$ck][0]['attr_index'][8] = mb_substr($detail->getCommentLinks[$ck][0]['attr_index'][8],0,7,'UTF-8');
        }else{
            $detail->getCommentLinks[$ck][0]['attr_index'] = json_decode($cv[0]['attr_index'], 1);
            $detail->getCommentLinks[$ck][0]['detail'] = @json_decode($cv[0]['detail'], 1);
            $detail->getCommentLinks[$ck][0]['info_attr'] = @json_decode($cv[0]['info_attr'], 1);
            $detail->getCommentLinks[$ck][0]['set_name'] = mb_strimwidth($cv[0]['set_name'],0,18,'','UTF-8');
            $detail->getCommentLinks[$ck][0]['attr_index']['人数'] = mb_substr($detail->getCommentLinks[$ck][0]['attr_index']['人数'],0,8,'UTF-8');
            $detail->getCommentLinks[$ck][0]['info_attr'][2] = mb_substr($detail->getCommentLinks[$ck][0]['info_attr'][2],0,7,'UTF-8');
            $detail->getCommentLinks[$ck][0]['detail']['计价单位'] = !empty($detail->getCommentLinks[$ck][0]['detail']['计价单位']) ? $detail->getCommentLinks[$ck][0]['detail']['计价单位'] : '天';
        }
    }
    foreach ($detail->getCommentLinks as $k => $v) {
        if(!empty($v[0]['product_name'])) {
            @$str_child[] = <<<str
</div>
<div class="product-code">
            <div class="product-code-title">场地信息</div>
            <div class="product-code-body">
                <div class="product-code-img">
                    <img src="{$v[0]['logo']}" alt="{$v[0]['attr_index'][4]}">
                </div>
                <div class="product-code-con">
                    <p>{$v[0]['product_name']}</p>
                    <p>城市区域：<span>{$v[0]['attr_index'][46]}-{$v[0]['attr_index'][4]}</span></p>
                    <p>所属商圈：<span>{$v[0]['attr_index'][2]}</span></p>
                    <p>使用面积：<span>{$v[0]['attr_index'][10]}</span></p>
                    <p>容纳人数：<span>{$v[0]['attr_index'][8]}</span></p>
                </div>
            </div>
            <div class="product-code-look-info">
                <a href="/m/service_info/{$v[0]['id']}.html">查看详情 &nbsp;></a>
            </div>
        </div>
        <div class="info_article">
str;
        } else {
            @$str_child[] = <<<str
</div>
<div class="product-code">
            <div class="product-code-title">套餐信息</div>
            <div class="product-code-body">
                <div class="product-code-img">
                    <img src="{$v[0]['logo']}" alt="{$v[0]['set_name']}">
                </div>
                <div class="product-code-con">
                    <p>{$v[0]['set_name']}</p>
                    <p>城市区域：<span>{$v[0]['attr_index']['城市']}-{$v[0]['info_attr'][4]}</span></p>
                    <p>所属商圈：<span>{$v[0]['info_attr'][2]}</span></p>
                    <p>容纳人数：<span>{$v[0]['attr_index']['人数']}</span></p>
                    <p>套餐价格：<span>{$v[0]['set_price']}&nbsp;&nbsp;元/{$v[0]['detail']['计价单位']}</span></p>
                </div>
            </div>
            <div class="product-code-look-info">
                <a href="/m/set_info/{$v[0]['id']}.html">查看详情 &nbsp;></a>
            </div>
        </div>
        <div class="info_article">
str;
        }
    }
}

preg_match_all("/<a.*?href=\"http:\/\/(pre0.yunspace.com.cn|www.yunspace.com.cn|".Core::$urls['host'].")\/[a-z]*[_]?[a-z]*\/[0-9]*.html.*?<\/a>/",$str_parent,$match);
$str_parent = str_replace($match[0],$str_child,$str_parent,$count);
Tpl_Smarty::assign('str_parent', $str_parent);
Data_Config_Site::seo('activity_strategy_info',$detail->getRaidersDetail);
Tpl_Smarty::assign('detail_des',$detail_des);
Web_Activity_Raiders_Detail::display("Web_Mobile_Static::activity_strategy.v2.0/activity_strategy_info.tpl");