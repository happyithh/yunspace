<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/22
 * Time: 16:46
 * 空间的相关推荐
 */
class  Api_Space_Recommend extends Api
{
    static function  handle($args = '')
    {
        return self::recommend($args);
    }

    static function  recommend($args)
    {
        //TODO 记录未用为什么搜索不到的url和当前用户信息

        $children = Data_Mysql_Table_Product_Category::getChildren(112);
        $children[] = 112;
        $conditions[] = 'category_id in (' . implode(',', $children) . ')';
        $conditions['status =?'] = 1;
        $conditions['attr_index'][46] = $_COOKIE['city'];

        $data = Data_Mysql_Table_Product_Search::select('id,product_name,price,category_id,logo,attr_index,order_people_number,order_product_size', $conditions, '', 4);

        if (empty($data[0])) {
            return Api::request('error', '', 'error');
        }
        foreach ($data as $k => $val) {

            $data[$k]['logo'] = Page_Site_Global::displayMedia($val['logo'], 275, 195);

        }
        return Api::request('success', Api_Map_Search_SpaceList::HandleField($data), 'success');
    }
}