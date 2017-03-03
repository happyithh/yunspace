<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/3
 * Time: 17:23
 */
class Api_Element_Product_List extends Api{
    static function elementProductList($args){
        $conditions = array();
        $product = array();
        $request = Func_Input::filter(array(
            'handle_type'=>'string',
            'search'=>'array',
        ),$args);
        //定义筛选面积
        $size_range = array(
            1 => '小于200㎡',
            200 => '200-500㎡',
            500 => '500-800㎡',
            800 => '800-1000㎡',
            1000 => '1000-2000㎡',
            2000 => '2000㎡以上',
        );
        $search = Func_Input::filter(array(
            'title'=>'string',
            'vendor_name'=>'string',
            'size_range'=>'int',
            'search_city' => 'string',
            'category_id' => 'int',
            'end_time' => 'string',
            'start_time' => 'string',
            'create_time'=>'string',
            'is_admin'=>'int'
        ),$request['search']);
        //筛选条件
        if (!empty($search)) {
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['product_name'] = $search['title'];
                }
            }
            //供应商筛选
            if (!empty($search['vendor_name'])) {
                $conditions['vendor_name'] = $search['vendor_name'];
            }
            //面积筛选
            if (!empty($search['size_range'])) {
                $product_size = $search['size_range'];
                switch ($product_size) {
                    case 1:
                        $conditions[] = 'order_product_size < 200';
                        break;
                    case 200:
                        $conditions[] = 'order_product_size >=200 and  order_product_size <= 500';
                        break;
                    case 500:
                        $conditions[] = 'order_product_size >=500 and  order_product_size <= 800';
                        break;
                    case 800:
                        $conditions[] = 'order_product_size >=800 and  order_product_size <= 1000';
                        break;
                    case 1000:
                        $conditions[] = 'order_product_size >=1000 and  order_product_size <= 2000';
                        break;
                    case 2000:
                        $conditions[] = 'order_product_size > 2000';
                        break;
                    default :
                        '';
                        break;
                }
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.update_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:00'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.update_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.update_time < ?'] = strtotime($search['end_time'].'23:59:59');
            }
            //城市筛选
            if (!empty($search['search_city'])) {
                $conditions['attr_index'][46] = '+' . $search['search_city'];
            }
            //服务分类筛选
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Product_Category::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
            }
            //来源筛选
            if(!empty($search['is_admin'])){
                if($search['is_admin']==1){
                    $conditions['admin_id = ?'] ='null';
                }
                if($search['is_admin']==2){
                    $conditions['admin_id != ?'] ='null';
                }
            }
            //创建时间筛选
            if(!empty($search['create_time'])){
                $conditions['create_time >= ?'] =strtotime($search['create_time']);
            }
        }
        $handle_type = empty($_REQUEST['handle_type']) ? 'online' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "reject":
                $conditions['{prefix}product_info_update.status = ? '] = 3;
                break;
            case "waiting":
                $conditions['{prefix}product_info_update.status = ? '] = 2;
                break;
            case "online":
                $conditions['{table}.status = ? '] = 1;
                break;
            case "offline":
                $conditions['{table}.status = ? '] = 0;
                break;
            case "recycle":
                $conditions['{prefix}product_info_update.status = ? '] = -2;
                break;
            case "all":
                break;
        }
//        q($conditions);
        $product = Data_Mysql_Table_Product_Search::page(0, 20, '{table}.*,{prefix}product_info_update.admin_id,{prefix}product_info_update.status as update_status,{prefix}product_info_update.create_by_quick', $conditions, 'ORDER BY {table}.update_time DESC', '{table} LEFT JOIN {prefix}product_info_update ON {table}.id={prefix}product_info_update.id');
        if (!empty($product['rows'])) {
            foreach ($product['rows'] as $k => $v) {
                $product['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
            }
        }
        $product['other']=array();
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[vendor_name]='.$search['vendor_name'].'&search[size_range]='.$search['size_range'].'&search[search_city]='.$search['search_city'].'&search[category_id]='.$search['category_id'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[create_time]'.$search['create_time'].'&search[is_admin]'.$search['is_admin'];
            $product['other']['urls'] =  $sea_url;
        }
        $product['other']['categoryList']= Data_Mysql_Table_Product_Category::getTreeCache();
        $product['other']['_category'] =Data_Mysql_Table_Product_Category::getInfoCache();
        $product['other']['handle_type'] =$handle_type;
        $product['other']['is_admin'] = Admin_Authority::checkUrl('marketing/contact_urgent_list', 0);
        $product['other']['size_range'] = $size_range;
        if(!empty($product['rows'])){
            return self::request('success',$product,'');
        }else{
            return self::request('error',$product,'暂无数据');
        }
    }

    static function elementProductUpdateList($args){
        $conditions = array();
        $product = array();
        $request = Func_Input::filter(array(
            'handle_type'=>'string',
            'search'=>'array',
        ),$args);
        //定义筛选面积
        $size_range = array(
            1 => '小于200㎡',
            200 => '200-500㎡',
            500 => '500-800㎡',
            800 => '800-1000㎡',
            1000 => '1000-2000㎡',
            2000 => '2000㎡以上',
        );
        $search = Func_Input::filter(array(
            'title'=>'string',
            'vendor_name'=>'string',
            'size_range'=>'int',
            'search_city' => 'string',
            'category_id' => 'int',
            'end_time' => 'string',
            'start_time' => 'string',
            'create_time'=>'string',
            'is_admin'=>'int'
        ),$request['search']);
        //筛选条件
        if (!empty($search)) {
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['{table}.id = ?'] = $search['title'];
                } else {
                    $conditions['{table}.product_name = ?'] = $search['title'];
                }
            }
            //供应商筛选
            if (!empty($search['vendor_name'])) {
                $conditions['{prefix}vendor_info_update.vendor_name = ?'] = $search['vendor_name'];
            }
            //面积筛选
            if (!empty($search['size_range'])) {
                $product_size = $search['size_range'];
                switch ($product_size) {
                    case 1:
                        $conditions[] = '{table}.product_size < 200';
                        break;
                    case 200:
                        $conditions[] = '{table}.product_size >=200 and  {table}.product_size <= 500';
                        break;
                    case 500:
                        $conditions[] = '{table}.product_size >=500 and  {table}.product_size <= 800';
                        break;
                    case 800:
                        $conditions[] = '{table}.product_size >=800 and  {table}.product_size <= 1000';
                        break;
                    case 1000:
                        $conditions[] = '{table}.product_size >=1000 and  {table}.product_size <= 2000';
                        break;
                    case 2000:
                        $conditions[] = '{table}.product_size > 2000';
                        break;
                    default :
                        break;
                }
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.update_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:00'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.update_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.update_time < ?'] = strtotime($search['end_time'].'23:59:59');
            }
            //城市筛选
//            if (!empty($search['search_city'])) {
//                $conditions['attr_index'][46] = '+' . $search['search_city'];
//            }
            //服务分类筛选
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Product_Category::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
            }
            //来源筛选
            if(!empty($search['is_admin'])){
                if($search['is_admin']==1){
                    $conditions['{table}.admin_id = ?'] ='null';
                }
                if($search['is_admin']==2){
                    $conditions['{table}.admin_id != ?'] ='null';
                }
            }
            //创建时间筛选
            if(!empty($search['create_time'])){
                $conditions['{table}.create_time >= ?'] =strtotime($search['create_time']);
            }
        }
        $handle_type = empty($_REQUEST['handle_type']) ? 'all' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "online":
                $conditions['{prefix}product_info.status = ? '] = 1;
                break;
            case "all":
                break;
        }
        $product = Data_Mysql_Table_Product_Info::subTable('_update')->page(0, 20, '{table}.*,{prefix}product_info.status as update_status,{prefix}vendor_info_update.vendor_name', $conditions, 'ORDER BY {table}.order_lv DESC, {table}.update_time DESC', '{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.id LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id={prefix}vendor_info_update.id');
        if (!empty($product['rows'])) {
            foreach ($product['rows'] as $k => $v) {
                $product['rows'][$k]['attr_new'] = json_decode($v['attr_new'], 1);
            }
        }
        $product['other']=array();
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[vendor_name]='.$search['vendor_name'].'&search[size_range]='.$search['size_range'].'&search[search_city]='.$search['search_city'].'&search[category_id]='.$search['category_id'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[create_time]'.$search['create_time'].'&search[is_admin]'.$search['is_admin'];
            $product['other']['urls'] =  $sea_url;
        }
        $product['other']['categoryList']= Data_Mysql_Table_Product_Category::getTreeCache();
        $product['other']['_category'] =Data_Mysql_Table_Product_Category::getInfoCache();
        $product['other']['handle_type'] =$handle_type;
        $product['other']['is_admin'] = Admin_Authority::checkUrl('marketing/contact_urgent_list', 0);
        $product['other']['size_range'] = $size_range;
        if(!empty($product['rows'])){
            return self::request('success',$product,'');
        }else{
            return self::request('error',$product,'暂无数据');
        }
    }
}