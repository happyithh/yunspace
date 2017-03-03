<?php
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
    Func_Header::notFound();
}
//读取产品信息
$productId = substr(Core::$urls['action'], 0, -5);
$rs = Data_Mysql_Table_Product_Info::select('*', array('id' => $productId, 'status' => 1));
if (empty($rs[0]['id'])) {
    Func_Header::notFound();
}
$productInfo = $rs[0];
$productInfo['attr'] = json_decode($productInfo['attr'], 1);
$productInfo['media'] = json_decode($productInfo['media'], 1);
$productInfo['price'] = $productInfo['price'] / 100;
//读取分类信息
$allCategory = Data_Mysql_Table_Product_Category::getInfoCache();
$categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
if (empty($allCategory[$productInfo['category_id']])) {
    Func_Header::notFound();
}
$productInfo['category'] = $allCategory[$productInfo['category_id']];
$productInfo['category_name'] = $productInfo['category'] [0];
$productInfo['parents'] = array();
$productInfo['top_category_id'] = $productInfo['category_id'];
$productInfo['parents'][] = $productInfo['top_category_id'];
while (!empty($allCategory[$productInfo['top_category_id']][3])) {
    $productInfo['top_category_id'] = $allCategory[$productInfo['top_category_id']][3];
    $productInfo['parents'][] = $productInfo['top_category_id'];
}
$productInfo['parents'] = array_reverse($productInfo['parents']);
$productInfo['is_space'] = Data_Config_Site::isSpace($productInfo['top_category_id']);
//判断产品分类是否属于视频
$productInfo['is_video'] = Data_Config_Site::isVideo($productInfo['top_category_id']);
//读取供应商信息
$rs = Data_Mysql_Table_Vendor_Info::select('id, vendor_name, base_info, attr, media, des', array('id' => $productInfo['vendor_id']));
if (!empty($rs[0]['id'])) {
    $productInfo['vendor'] = $rs[0];
    $productInfo['vendor']['base_info'] = json_decode($productInfo['vendor']['base_info'], 1);
    $productInfo['vendor']['attr'] = json_decode($productInfo['vendor']['attr'], 1);
    $productInfo['vendor']['media'] = json_decode($productInfo['vendor']['media'], 1);
}
//处理图片数组
if (!empty($productInfo['media'])) {
    $media = array();
    foreach ($productInfo['media'] as $k => $v) {
        $tags = explode(',', $v['tags']);
        foreach ($tags as $tv) {
            if ($tv&&$tv{0} == '@') {
                continue;
            }
            if (!$tv) {
                $tv = '其他';
            }
            empty($v['video']) and $v['video'] = '';
            $media[$tv][1][$k] = array($v['name'], $v['path'], $v['video']);
        }
    }
    $i = 2;
    foreach ($media as $k => $v) {
        $media[$k][0] = $i;
        $i += count($v[1]);
    }
    $productInfo['media'] = $media;
}
//读取案例
$event = array();
$event = Data_Mysql_Table_Event_Case::select('{table}.event_id,{table}.case_name,t2.logo,{table}.product_name,{table}.des', array(
    'product_id' => $productId,
), '', 10, '{table} LEFT JOIN {prefix}event_info as t2 ON {table}.event_id = t2.id ');


//读取产品档期


//访问记录跟踪
Web_Account::footPrint($productInfo);

//输出模板
Data_Config_Site::seo('service_info', $productInfo);
Tpl_Smarty::assign('nav_index', $productInfo['is_space'] ? 1 : 2);
Tpl_Smarty::assign('_category_info', $allCategory);
Tpl_Smarty::assign('info', $productInfo);
Tpl_Smarty::assign('event', $event);
Tpl_Smarty::display('Web', $productInfo['is_space'] ? 'space-info.tpl' : 'service-info.tpl');