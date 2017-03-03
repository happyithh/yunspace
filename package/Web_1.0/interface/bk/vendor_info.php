<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/20 12:00
 * 供应商介绍页
 */
session_start();
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
    Func_Header::notFound();
}
//读取供应商信息
$vendorId = substr(Core::$urls['action'], 0, -5);
$rs = Data_Mysql_Table_Vendor_Info::select('*', array('id' => $vendorId));//, 'status' => 1
if (empty($rs[0]['id'])) {
    Func_Header::notFound();
}
$vendorInfo = $rs[0];
$vendorInfo['base_info'] = json_decode($vendorInfo['base_info'], 1);
$vendorInfo['attr'] = json_decode($vendorInfo['attr'], 1);
$vendorInfo['media'] = json_decode($vendorInfo['media'], 1);

//读取分类信息
$allCategory = Data_Mysql_Table_Product_Category::getInfoCache();
$categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
$vendorInfo['categories_id'] = intval($vendorInfo['categories_id']);
if (empty($allCategory[$vendorInfo['categories_id']])) {
    Func_Header::notFound();
}
$vendorInfo['category'] = $allCategory[$vendorInfo['categories_id']];
$vendorInfo['category_name'] = $vendorInfo['category'] [0];
$vendorInfo['parents'] = array();
$vendorInfo['top_category_id'] = $vendorInfo['categories_id'];
$vendorInfo['parents'][] = $vendorInfo['top_category_id'];
while (!empty($allCategory[$vendorInfo['top_category_id']][3])) {
    $vendorInfo['top_category_id'] = $allCategory[$vendorInfo['top_category_id']][3];
    $vendorInfo['parents'][] = $vendorInfo['top_category_id'];
}
$vendorInfo['parents'] = array_reverse($vendorInfo['parents']);
//判断供应商是否是视频制作供应商
$vendorInfo['is_video'] =Data_Config_Site::isVideo($vendorInfo['top_category_id']);
//读取供应商的产品信息
$productInfo = Data_Mysql_Table_Product_Info::select('*', array('vendor_id' => $vendorId, 'status' => 1), '', 5);

foreach ($productInfo as $key => $value) {
    $productInfo[$key]['attr'] = json_decode($value['attr'], 1);
    $productInfo[$key]['media'] = json_decode($value['media'], 1);
    if (!empty($productInfo[$key]['media'])) {
        foreach ($productInfo[$key]['media'] as $mk => $mv) {
            //主图
            if (empty($productInfo[$key]['logo'])) {
                $productInfo[$key]['logo'] = $mv['path'];
            }
            if (strpos($mv['tags'], '@主图') !== false) {
                $productInfo[$key]['logo'] = $mv['path'];
                break;
            }
        }
    }
    $productInfo[$key]['price'] = $value['price'] / 100;
}

//读取供应商的活动案例
$caseInfo = array();
$caseInfo = Data_Mysql_Table_Event_Case::select('event_id,case_name,product_name,logo,des', array(
    'vendor_id' => $vendorId,
), '', 10, '{table} LEFT JOIN {prefix}event_info ON  {prefix}event_info.id = {table}.vendor_id');

//处理图片数组
if (!empty($vendorInfo['media'])) {
    $media = array();
    foreach ($vendorInfo['media'] as $k => $v) {
        $tags = explode(',', $v['tags']);
        foreach ($tags as $tv) {
            if ($tv{0} == '@') {
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
    $vendorInfo['media'] = $media;
}

//更新供应商信息计数器
Data_Mysql_Table_Vendor_Info::query('UPDATE {table} SET counter_view = counter_view+1 WHERE id = ?', array($vendorInfo['id']));
if (rand(1, 30) == 2) {
    Data_Mysql_Table_Vendor_Info::exec("UPDATE  {table} SET counter_view_index =  counter_view");
}

Data_Config_Site::seo('service_info', $vendorInfo);
Tpl_Smarty::assign('_category_info', $allCategory);
Tpl_Smarty::assign('productInfo', $productInfo);
Tpl_Smarty::assign('caseInfo', $caseInfo);
Tpl_Smarty::assign('info', $vendorInfo);
Tpl_Smarty::display('Web', 'vendor-info.tpl');
