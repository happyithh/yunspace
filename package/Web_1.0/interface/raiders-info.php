<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/17
 * Time: 11:53
 */

//301跳转到article页面  add by yl 2016/03/07
$action_arr = explode('/', Core::$urls['action']);
if (count($action_arr) == 2) {
    $id= (int)substr($action_arr[1], 0, -5);
} else {
    $id= (int)substr($action_arr[0], 0, -5);
}
Header("HTTP/1.1 301 Moved Permanently");
Header("Location: http://www.yunspace.com.cn/article/".Func_NumEncode::e($id).".html");
die;

session_start();
if(isset($_SESSION['user'])){
    Tpl_Smarty::assign('__user', $_SESSION['user']);
}
Tpl_Smarty::assign('nav_index', 4);
$detail = Web_Activity_Raiders_Detail::getInstance();

//Data_Mysql_Table_Raiders_Info::rebuildIndex();
//q($detail->getBannerList);
//q($detail->getHotList);
$count = count($detail->getCommentLinks);
//q($detail->getRelationProduct);
//q($detail->getCommentLinks);
//q($detail->getRelationProduct);


//q($detail->getRelationProduct);
//q($detail->getRelationRead);
$getlist = Web_Activity_Raiders::getInstance();
//q($getlist->getHotList);




Data_Mysql_Table_Raiders_Info::footPrint($detail->id);
Data_Config_Site::seo('raiders_info',$detail->getRaidersDetail);
foreach ($detail->allCategory as $k =>$v) {
    if($detail->getRaidersDetail['category_id'] == $v['id']){
        $detail->getRaidersDetail['category_name'] = $v['name'];
    }
}

foreach ($detail->allCategory as $k =>$v) {
    if($detail->getRaidersDetail['category_id'] == $v['id']){
        if($v['id'] == 12 ||$v['parent'] == 12){
            $detail->getRaidersDetail['accessory'] = json_decode($detail->getRaidersDetail['accessory'],1);
            preg_match_all('/\.(.*)/', $detail->getRaidersDetail['accessory']['name'], $match);
            $detail->getRaidersDetail['match'] = $match;
        }
    }
}
//if($detail->topCategory['top_id'] == 12){
//    Web_Activity_Raiders_Detail::display('Web_Static::raiders/find_library-info.tpl');
//}else{
//    Web_Activity_Raiders_Detail::display('Web_Static::raiders/raiders-info.php.tpl');
//}



$str_parent = <<<str
<div class="side-info-content" >
                {$detail->getRaidersDetail['cont']}
            </div>
str;
//q($str_parent);
$str_child = array();
if(!empty($detail->getCommentLinks)) {
//    q($detail->getCommentLinks);
    foreach($detail->getCommentLinks as $ck=>$cv) {
        if(!empty($cv[0]['product_name'])) {
            $detail->getCommentLinks[$ck][0]['attr_index'] = json_decode($cv[0]['attr_index'], 1);
        }else{
            $detail->getCommentLinks[$ck][0]['attr_index'] = json_decode($cv[0]['attr_index'], 1);
            $detail->getCommentLinks[$ck][0]['detail'] = @json_decode($cv[0]['detail'], 1);
            $detail->getCommentLinks[$ck][0]['info_attr'] = @json_decode($cv[0]['info_attr'], 1);
            $detail->getCommentLinks[$ck][0]['detail']['计价单位'] = !empty($detail->getCommentLinks[$ck][0]['detail']['计价单位']) ? $detail->getCommentLinks[$ck][0]['detail']['计价单位'] : '天';
        }
    }
//    q($detail->getCommentLinks);
    foreach ($detail->getCommentLinks as $k => $v) {
        if(!empty($v[0]['product_name'])) {
            @$str_child[] = <<<str
</div>
<div class="side-act-info" style="background: #f2f2f2;overflow: hidden">
                <div class="space-p">场地信息</div>
                <div class="space-code-img fl">
                    <img src="{$v[0]['logo']}" alt="{$v[0]['product_name']}">
                </div>
                <div class="space-code fl">
                    <div class="space-code-title">
                        {$v[0]['product_name']}
                    </div>
                    <div class="space-code-more">
                        服务标签：
                        <a>{$v[0]['attr_index'][49]}</a>&nbsp;

                    </div>
                    <ul class="space-code-info-li">
                        <li>
                            <span class="space-code-info-li-t">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index'][46]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">使用面积：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index'][10]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">行政区域：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index'][4]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">空间层高：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index'][6]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">所属商圈：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index'][2]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">容纳人数：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index'][8]}</span>
                        </li>
                        <li class="clear"></li>
                    </ul>
                    <div class="space-code-look">
                        <a href="/service_info/{$v[0]['id']}.html" target="_blank">
                            查看详情&nbsp;>
                        </a>
                    </div>
                </div>
                </div>
                <br />
                <div>
str;
        } else {
            @$str_child[] = <<<str
</div>
<div class="side-act-info" style="background: #f2f2f2;overflow: hidden">
                <div class="space-p">套餐信息</div>
                <div class="space-code-img fl">
                    <img src="{$v[0]['logo']}" alt="{$v[0]['set_name']}">
                </div>
                <div class="space-code fl">
                    <div class="space-code-title">
                        {$v[0]['set_name']}
                    </div>
                    <div class="space-code-more">

                        服务标签：
                        <a>{$v[0]['info_attr'][49]}</a>&nbsp;

                    </div>
                    <ul class="space-code-info-li">
                        <li>
                            <span class="space-code-info-li-t">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index']['城市']}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">套餐类型：</span>
                            <span class="space-code-info-li-p">{$v[0]['category_name']}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">行政区域：</span>
                            <span class="space-code-info-li-p">{$v[0]['info_attr'][4]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">容纳人数：</span>
                            <span class="space-code-info-li-p">{$v[0]['attr_index']['人数']}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">所属商圈：</span>
                            <span class="space-code-info-li-p">{$v[0]['info_attr'][2]}</span>
                        </li>
                        <li>
                            <span class="space-code-info-li-t">套餐价格：</span>
                            <span class="space-code-info-li-p">{$v[0]['set_price']}&nbsp;&nbsp;元/{$v[0]['detail']['计价单位']}</span>
                        </li>
                        <li class="clear"></li>
                    </ul>
                    <div class="space-code-look">
                        <a href="/set_info/{$v[0]['id']}.html" target="_blank">
                            查看详情&nbsp;>
                        </a>
                    </div>
                </div>
                </div>
                <br />
                <div>
str;
        }
    }
}


//preg_match_all("/<a href=\"http:\/\/yun.cc\/[a-z]*[_]?[a-z]*\/[0-9]*.html.*?<\/a>/",$str_parent,$match);
//preg_match_all("/http:\/\/".Core::$urls['host']."\/[a-z]*[_]?[a-z]*\/[0-9]*.html/",$str_parent,$match);
//preg_match_all("/<a.*?href=\"http:\/\/".Core::$urls['host']."\/[a-z]*[_]?[a-z]*\/[0-9]*.html.*?<\/a>/",$str_parent,$match);
preg_match_all("/<a href=\"http:\/\/(pre0.yunspace.com.cn|www.yunspace.com.cn|".Core::$urls['host'].")\/[a-z]*[_]?[a-z]*\/[0-9]*.html.*?<\/a>/",$str_parent,$match);
//q($match);
$str_parent = str_replace($match[0],$str_child,$str_parent,$count);
//q($str_parent);

Tpl_Smarty::assign('str_parent', $str_parent);
//Tpl_Smarty::assign('getBannerList', $getlist->getBannerList);
//Tpl_Smarty::assign('getHotList', $getlist->getHotList);
//Tpl_Smarty::assign('getWeekTopView', $getlist->getWeekTopView);
//Tpl_Smarty::assign('getWeekTopPraise', $getlist->getWeekTopPraise);
//Web_Activity_Raiders_Detail::display('Web_Static::/find.v3.0/find_info.php.tpl');
//Tpl_Smarty::display("Web_Static::/find.v3.0/find_info.tpl");

if($detail->topCategory['top_id'] == 12){
//    q(432);
    Web_Activity_Raiders_Detail::display('Web_Static::/find.v3.0/find_library-info.tpl');
}else{
    Web_Activity_Raiders_Detail::display('Web_Static::/find.v3.0/find_info.php.tpl');
}

