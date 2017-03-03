<?php

class Admin_Search_Product_Search
{

    static function handle()
    {
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'update_product_submit') {
            self::updateProductSearchSubmit();
        } else {
            self::getUpdateProductInfoList();
        }
    }

    //提交数据
    static function updateProductSearchSubmit()
    {
        $shangquanId = Page_Site_Global::tagsName('所属商圈');
        $quyuId = Page_Site_Global::tagsName('行政区域');
        Core::output('');
        $list = $_REQUEST['addrInfos'];
        $list = json_decode($list);
        $insertTime = 0;
        foreach ($list as $k => $v) { //0为id 1为lng 2为lat 3为商圈和行政区
            $product_id[] = $v[0];
            $product_info = Data_Mysql_Table_Product_Info::select('id,attr_new,update_time', $v[0]);
            if (empty($product_info[0])) {
                continue;
            }
            $product_info = $product_info[0];
            $attr_new = json_decode($product_info['attr_new'], 1);
            if (empty($v[3][0])) {
                $v[3][0] = '';
            }
            if (empty($v[3][1])) {
                $v[3][1] = '';
            }
            $attr_new[$shangquanId] = str_replace('、', ',', $v[3][0]);
            $attr_new[$quyuId] = str_replace('、', ',', $v[3][1]);
            $dataMain = array(
                'geo_lng' => $v[1] * 10000,
                'geo_lat' => $v[2] * 10000,
                'attr_new' => $attr_new,
//                'attr_index' => $attr_index,
//                'logo' => $product_info['logo'],
//                'media' => $product_info['media'],
//                'attr' => $attr,
                'update_time' => $product_info['update_time']
            );
            Data_Mysql_Table_Product_Info::update($product_info['id'], $dataMain);
            $insertTime += 1;
        }
        self::updateProductSearch($product_id);

        if ($insertTime !== 0 && $insertTime == count($list)) {
            echo 'ok';
        } else {
            echo 'notOk';
        }
        die();
    }

    //找出需要更新的产品
    static function  getUpdateProductInfoList($i = 0)
    {
        Core::output('');
        $cityId = Page_Site_Global::tagsName('城市');
        Data_Mysql_Table_Product_Search::select('1');
        $conditions[] = "(s1.update_time != p1.update_time or  s1.update_time is null or s1.status != p1.status)";
        $table = "{table} as p1 left join {prefix}product_search as s1 ON s1.id=p1.id";
//        Data_Mysql_Table_Product_Info::debug();
        $newData = Data_Mysql_Table_Product_Info::select('p1.id,p1.attr_new,p1.addr,p1.product_name,s1.update_time, s1.addr as addr2, s1.geo_lat', $conditions, '', 10, $table);
        $order = array("\r\n", "\n", "\r");
        if (empty($newData)) {
            Tpl_Smarty::display('Admin_Search', 'product_search_update.tpl');
            die();
        }
        $upToTime = time() - 86400 * 7;
        foreach ($newData as $k => $v) {
            if (($v['addr'] == $v['addr2'] && $v['update_time'] > $upToTime) || !$v['addr'] || (!empty($_SESSION['map_retry'][$v['id']]) && $_SESSION['map_retry'][$v['id']] > 3)) {
                self::updateProductSearch($v['id']);
                unset($newData[$k]);
                continue;
            }
            $data = json_decode($v['attr_new'], true);
            if (!$data[$cityId]) {
                self::updateProductSearch($v['id']);
                unset($newData[$k]);
                continue;
            }
            $newData[$k]['city'] = $data[$cityId];
            $newData[$k]['newAddr'] = str_replace($order, '', $data[$cityId] . ' ' . $newData[$k]['addr']);
            //防止重复
            $_SESSION['map_retry'][$v['id']] = empty($_SESSION['map_retry'][$v['id']]) ? 1 : $_SESSION['map_retry'][$v['id']] + 1;
        }
        if (empty($newData) && $i < 10) {
            return self::getUpdateProductInfoList($i + 1);
        }
        Tpl_Smarty::assign('_package', Core::$urls['package']);

        Tpl_Smarty::assign('addrData', $newData);
        Tpl_Smarty::display('Admin_Search', 'product_search_update.tpl');
    }

    //更新到product_search表中
    static function updateProductSearch($product_id)
    {
        if (empty($product_id)) {
            return false;
        }
        if (is_array($product_id)) {
            foreach ($product_id as $v) {
                unset($_SESSION['map_retry'][$v]);
            }
            $conditions[] = "{table}.id IN(" . implode(',', $product_id) . ")";
        } else {
            $conditions['id'] = $product_id;
            unset($_SESSION['map_retry'][$product_id]);
        }
        $cols = 'v1.vendor_name,';
        $cols .= '{table}.media,{table}.price,{table}.vendor_id,{table}.id,{table}.product_name,{table}.category_id,{table}.addr,{table}.logo,{table}.geo_lat,{table}.geo_lng,{table}.attr_new,{table}.des,{table}.status,
           {table}.update_time,{table}.counter_follow,{table}.counter_order,{table}.counter_order_complete,{table}.product_size as order_product_size,{table}.score as order_score,{table}.counter_view as order_counter_view,{table}.order_lv,v1.vendor_remarks,v1.vendor_account_id';
        $table = '{table} left join {prefix}vendor_info  as v1 ON v1.id={table}.vendor_id';
        $product_info = Data_Mysql_Table_Product_Info::select($cols, $conditions, '', '30', $table);
        foreach ($product_info as $key => $val) {
            $val = self::getLogo($val);
            if (!$val['logo']) {
                $val['logo'] = '';
            }
            if (empty($val['addr'])) {
                $val['addr'] = '';
            }
            if (!empty($val['vendor_remarks'])) {
                $val['vendor_remarks'] = json_decode($val['vendor_remarks'], 1);
            } else {
                $val['vendor_remarks']['签约状态'] = 0;
            }
            $attr_new = json_decode($val['attr_new'], 1);

            $mainData = array(
                'id' => $val['id'],
                'vendor_id' => $val['vendor_id'],
                'category_id' => $val['category_id'],
                'vendor_name' => $val['vendor_name'],
                'product_name' => $val['product_name'],
                'addr' => $val['addr'],
                'logo' => $val['logo'],
                'geo_lat' => $val['geo_lat'],
                'geo_lng' => $val['geo_lng'],
                'attr_index' => $attr_new,
                'des' => $val['des'],
                'update_time' => $val['update_time'],
                'order_product_size' => $val['order_product_size'],
                'order_score' => $val['order_score'],
                'counter_follow' => $val['counter_follow'],
                'counter_order' => $val['counter_order'],
                'counter_order_complete' => $val['counter_order_complete'],
                'order_counter_view' => $val['order_counter_view'],
                'status' => $val['status'],
                'price' => $val['price'],
                'order_people_number' => @intval($attr_new[Page_Site_Global::tagsName('人数上限')]),
                //'order_index' => self::calOrderIndex($val['order_counter_view'], $val['counter_follow'], $val['counter_order'], $val['update_time'], $val['order_lv'], $val['vendor_remarks']['签约状态'], $val['vendor_account_id']), //TODO:定义一个算法
                'order_index' => self::newOrderIndex($attr_new),
                'vendor_signing' => $val['vendor_remarks']['签约状态'],
                'vendor_account_id' => $val['vendor_account_id']
            );
            Data_Mysql_Table_Product_Search::update($mainData);
        }
    }

    /**
     * $order_lv 优先级分为高2中1低0  依次增加 200*2  200*1  0
     * $counter_view 浏览量按照默认值
     * $counter_follow 收藏量  按照 $counter_follow*10
     * $counter_order 订单量  $counter_order*100
     * $update_time 距离时间戳起始多少周。 周数*1000  这是最为优先的
     */
    static function calOrderIndex($counter_view, $counter_follow, $counter_order, $update_time, $order_lv, $sign_status, $account_status)
    {
        $lvcount = 0;
        $weekn = (date('Y', $update_time) - 1970) * 52 + date('W', $update_time);
        $sign_s = 0;
        $account_s = 0;
        if (!empty($sign_status)) {
            $sign_s = 5000;
        }
        if (!empty($account_status)) {
            $account_s = 3000;
        }
        $lvcount = $counter_view + ($counter_follow * 10) + ($counter_order * 100) + $weekn * 200 + $order_lv * 10000 + $sign_s + $account_s;
        return $lvcount;
    }

    static function newOrderIndex($attr){
        $lv_count = 0;
        if(!is_array($attr)){
           return  $lv_count;
        }
        foreach($attr as $k=>$v){
            if(!empty($v)){
                $lv_count=$lv_count+1000;
            }
        }
        return $lv_count;
    }

    static function getLogo($product_info)
    {
        $product_info['media'] = json_decode($product_info['media'], 1);
        if (!empty($product_info['media'])) {
            foreach ($product_info['media'] as $mk => $mv) {
                $mv['path'] = str_replace('//', '/', $mv['path']);
                //主图
                if (empty($product_info['logo'])) {
                    $product_info['logo'] = $mv['path'];
                }
                if (strpos($mv['tags'], '@主图') !== false) {
                    $product_info['logo'] = $mv['path'];
                    break;
                }
                if (strpos($mv['tags'], '@logo') !== false) {
                    $product_info['logo'] = $mv['path'];
                    break;
                }
            }
        }
        if (empty($product_info['logo'])) {
            $product_info['logo'] = '';
        }
        return $product_info;
    }

    //供应商修改logo
    static function updateVendorLogo()
    {
        $vendor = Data_Mysql_Table_Vendor_Info::select('id,logo,media', '', '', 99999);
        foreach ($vendor as $key => $val) {
            if (empty($val['logo'])) {
                $val = self::getLogo($val);
                if (!empty($val['logo'])) {
                    Data_Mysql_Table_Vendor_Info::query("UPDATE {table} SET logo = ? WHERE id =? ", array($val['logo'], $val['id']), 1);
                }
            }
        }
    }


}