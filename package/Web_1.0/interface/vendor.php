<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/26
 * Time: 15:14
 */
//header("Cache-Control: no-cache, must-revalidate");
//header("Pragma: no-cache");
$categoryId = Core::$urls['action'];
if ($categoryId && !is_numeric($categoryId)) {
    Func_Header::notFound();
}
//开始绑定数据，渲染页面
$webConfig = Data_Config_Site::get('service_list');
/**
 * 加载列表项
 */
//只显示通过审核的产品
$conditions = array(
    'status' => 1,

);
//分类
if ($categoryId) {
    $children = Data_Mysql_Table_Product_Category::getChildren($categoryId);
    $children[] = $categoryId;
    $conditions[] = 'categories_id in (' . implode(',', $children) . ')';
}
//关键词&&属性筛选
if (!empty($_REQUEST['filter'])) {
    foreach ($_REQUEST['filter'] as $k => $v) {
        if ($v == 'all') {
            unset($_REQUEST['filter'][$k]);
        }
    }
}
$request = Func_Input::filter(array(

    'keyword' => 'string',
    'filter' => 'array'
));
if ($request['keyword']) {
    $conditions['vendor_name'] = $request['keyword'];
}

if ($request['filter']) {
    empty($conditions['attr_index']) and $conditions['attr_index'] = array();
    foreach ($request['filter'] as $k => $v) {
        $conditions['attr_index'][$k] = '+' . $v;
        $request['filter'][$k] = htmlspecialchars($v);
    }
}
$filterString = http_build_query($request);
Tpl_Smarty::assign('filter_string', $filterString . '&');
if (!empty($_COOKIE['city'])) {
    $conditions['attr_index']['城市'] = '+' . $_COOKIE['city'];
} else {
    $_COOKIE['city'] = '上海';
}
//排序方式
$order = 'ORDER BY update_time DESC';
//查询数据库
$list = Data_Mysql_Table_Vendor_Info::page(0, empty($webConfig['page_num']) ? 10 : $webConfig['page_num'], "id, categories_id, des,vendor_name,attr_index,base_info, attr, logo,vendor_remarks, update_time", $conditions, $order);
if (!empty($list['rows'])) {
    foreach ($list['rows'] as $k => $v) {
        $list['rows'][$k]['base_info'] = json_decode($v['base_info'], 1);
        $list['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
        $list['rows'][$k]['vendor_remarks'] = json_decode($v['vendor_remarks'], 1);
        $list['rows'][$k]['attr'] = json_decode($v['attr'], 1);
        $des =  preg_replace("/<(.*?)>/","",htmlspecialchars_decode($v['des']));
        $list['rows'][$k]['des'] = $des;
    }
}

//处理属性
$categoryId = intval($categoryId);
$allCategory = Data_Mysql_Table_Product_Category::getInfoCache();
$parents = array();
$topCategoryId = $categoryId;
$parents[] = $topCategoryId;
while (!empty($allCategory[$topCategoryId][3])) {
    $topCategoryId = $allCategory[$topCategoryId][3];
    $parents[] = $topCategoryId;
}
$filterAttr = Data_Config_Vendor_Attr::all();
unset($filterAttr['attr']['城市']);
Data_Config_Site::seo('service_list', array(
    'category_name' => ($categoryId ? $allCategory[$categoryId][0] : '全部供应商'),
));

//猜你喜欢数据
$guessConditions = Web_Account::getFootPrintConditions();
$guessConditions['status'] = 1;
unset($guessConditions['attr_index']);
$guessList = Data_Mysql_Table_Product_Search::select('id,logo,addr,product_name', $guessConditions, '', 6);


$categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
unset($categoryTree[0][$webConfig['space_id']], $categoryTree[0][93], $categoryTree[0][10], $categoryTree[0][140], $categoryTree[0][3], $categoryTree[0][135]);
Tpl_Smarty::assign('request', $request);
Tpl_Smarty::assign('_web_config', $webConfig);
Tpl_Smarty::assign('_vendor_attr', $filterAttr);
Tpl_Smarty::assign('_category_tree', $categoryTree);
Tpl_Smarty::assign('_category_info', $allCategory);
Tpl_Smarty::assign('top_category_id', $topCategoryId);
Tpl_Smarty::assign('parents', array_reverse($parents));
Tpl_Smarty::assign('category_id', $categoryId);
Tpl_Smarty::assign('list', $list);
Tpl_Smarty::assign('guessList', $guessList);
Tpl_Smarty::assign('nav_index', 5);
Tpl_Smarty::display('Web', 'vendor-list.tpl');