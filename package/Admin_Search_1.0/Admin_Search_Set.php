<?php

/**
 * 套餐的 search 表
 */
class Admin_Search_Set
{
    static function handle()
    {
//        Data_Mysql_Table_Product_Search::debug(1);
//        Data_Mysql_Table_Product_Search::update(array(
//            'attr_index' => array(Page_Site_Global::tagsName('城市') => '北京')
//        ), array('update_time' => 0));
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'update_product_submit') {
            self::updateSetSearchSubmit();
        } else {
            self::getUpdateSetSearchList();
        }
    }
    //提交数据
    static function updateSetSearchSubmit()
    {
        $shangquanId = Page_Site_Global::tagsName('所属商圈');
        $quyuId = Page_Site_Global::tagsName('行政区域');
        Core::output('');
        $list = $_REQUEST['addrInfos'];
        $list = json_decode($list);
        $insertTime = 0;
        foreach ($list as $k => $v) { //0为id 1为lng 2为lat 3为商圈和行政区
            $product_id[] = $v[0];
            $product_info = Data_Mysql_Table_Product_Set::select('id,attr_new,update_time', $v[0]);
            if (empty($product_info[0])) {
                continue;
            }
            $product_info = $product_info[0];
            if (empty($v[3][0])) {
                $v[3][0] = '';
            }
            if (empty($v[3][1])) {
                $v[3][1] = '';
            }
            $attr_new[$shangquanId] = str_replace('、', ',', $v[3][0]);
            $attr_new[$quyuId] = str_replace('、', ',', $v[3][1]);
            $dataMain = array(
                'geo_lng' => $v[1] * 1000,
                'geo_lat' => $v[2] * 1000,
                'update_time' => $product_info['update_time']
            );
            Data_Mysql_Table_Product_Set::update($product_info['id'], $dataMain);
            $insertTime += 1;
        }
        self::updateSetSearch($product_id);

        if ($insertTime !== 0 && $insertTime == count($list)) {
            echo 'ok';
        } else {
            echo 'notOk';
        }
        die();
    }

    //找出需要更新的套餐
    static function  getUpdateSetSearchList($i = 0)
    {
        Core::output('');
        $cityId = Page_Site_Global::tagsName('城市');
        Data_Mysql_Table_Product_Search::select('1');

        Data_Mysql_Table_Product_Info::select('1');
        $conditions[] = "(s2.update_time != p1.update_time or  s2.update_time is null or s2.status != p1.status)";
        $table = "{table} as p1 left join {prefix}product_search as s1 ON s1.id=p1.id left join {prefix}set_search as s2 ON s2.id=p1.id left join {prefix}product_info as s3 ON s1.id=s3.id";
      //  Data_Mysql_Table_Product_Set::debug();
        $newData = Data_Mysql_Table_Product_Set::select('p1.id,s3.attr_new,p1.addr,p1.set_name,s1.update_time, s2.addr as addr2, s1.geo_lat', $conditions, '', 10, $table);
        $order = array("\r\n", "\n", "\r");
 // q($newData);
        if (empty($newData)) {
            Tpl_Smarty::display('Admin_Search', 'set_search_update.tpl');
            die();
        }
        $upToTime = time() - 86400 * 7;
        foreach ($newData as $k => $v) {
            if (($v['addr'] == $v['addr2'] && $v['update_time'] > $upToTime) || !$v['addr'] || (!empty($_SESSION['map_retry'][$v['id']]) && $_SESSION['map_retry'][$v['id']] > 3)) {
                self::updateSetSearch($v['id']);
                unset($newData[$k]);
                continue;
            }
            $data = json_decode($v['attr_new'], true);
            if (!$data[$cityId]) {
                self::updateSetSearch($v['id']);
                unset($newData[$k]);
                continue;
            }

            $newData[$k]['city'] = $data[$cityId];
            $newData[$k]['newAddr'] = str_replace($order, '', $data[$cityId] . ' ' . $newData[$k]['addr']);
            //q($newData);
            //防止重复
            $_SESSION['map_retry'][$v['id']] = empty($_SESSION['map_retry'][$v['id']]) ? 1 : $_SESSION['map_retry'][$v['id']] + 1;
        }

        if (empty($newData) && $i < 10) {
            return self::getUpdateSetSearchList($i + 1);
        }
        Tpl_Smarty::assign('_package', Core::$urls['package']);
//q( Core::$urls['package']);
        Tpl_Smarty::assign('addrData', $newData);
        Tpl_Smarty::display('Admin_Search','set_search_update.tpl');
    }

    //更新到set_search表中
    static function updateSetSearch($set_id)
    {
        if (empty($set_id)) {
            return false;
        }
        if (is_array($set_id)) {
            foreach ($set_id as $v) {
                unset($_SESSION['map_retry'][$v]);
            }
            $conditions[] = "{table}.id IN(" . implode(',', $set_id) . ")";
        } else {
            $conditions['id'] = $set_id;
            unset($_SESSION['map_retry'][$set_id]);
        }
//q($conditions);
        $cols= '{table}.set_name,{table}.set_price,{table}.version,{table}.id,{table}.addr,{table}.category_id,{table}.vendor_id,{table}.vendor_name,{table}.hours,{table}.people,{table}.schedule_product_id,{table}.create_time,{table}.attr_index,{table}.logo,{table}.detail,{table}.detail_des,{table}.counter_order,{table}.update_time,v1.order_counter_view,v1.order_index,v2.attr_new,{table}.status,
{table}.media,v2.counter_follow,v2.order_lv,';
        $cols.='v1.order_score';
        $table = '{table} left join {prefix}product_search  as v1 ON v1.id={table}.id left join {prefix}product_info  as v2 ON v2.id=v1.id';
    // Data_Mysql_Table_Product_Set::debug(1);
        $product_info = Data_Mysql_Table_Product_Set::select($cols, $conditions, '', '30', $table);
      //  q($product_info);
        foreach ($product_info as $key => $val) {
            $val = self::getLogo($val);
            if (!$val['logo']) {
                $val['logo'] = '';
            }
            if (empty($val['addr'])) {
                $val['addr'] = '';
            }
            $mainData = array(
                'set_name' => $val['set_name'],
                'version' => $val['version'],
                'addr' => $val['addr'],
                'category_id' => $val['category_id'],
                'vendor_id' => $val['vendor_id'],
                'vendor_name' => $val['vendor_name'],
                'hours' => $val['hours'],
                'people' => $val['people'],
                'schedule_product_id' => $val['schedule_product_id'],
                'attr_index' =>$val['attr_index'],
                'logo' => $val['logo'],
                'detail' => $val['detail'],
                'detail_des' => $val['detail_des'],
                'counter_order' => $val['counter_order'],
                'create_time' => $val['create_time'],
                'update_time' => $val['update_time'],
                'order_score' => $val['order_score'],
                'order_counter_view' => $val['order_counter_view'],
                'set_price' => $val['set_price'],
                'order_index' => self::calOrderIndex($val['order_counter_view'], $val['counter_follow'], $val['counter_order'], $val['update_time'], $val['order_lv']), //TODO:定义一个算法
                'attr_new' => $val['attr_new'],
                'status' => $val['status'],


            );
           // q($mainData);
          //  Data_Mysql_Table_Set_Search::debug(1);
            Data_Mysql_Table_Set_Search::update($mainData);
        }
    }
    /**
     * $order_lv 优先级分为高2中1低0  依次增加 200*2  200*1  0
     * $counter_view 浏览量按照默认值
     * $counter_follow 收藏量  按照 $counter_follow*10
     * $counter_order 订单量  $counter_order*100
     * $update_time 距离时间戳起始多少周。 周数*1000  这是最为优先的
     */
    static function calOrderIndex($counter_view, $counter_follow, $counter_order, $update_time, $order_lv)
    {
        $lvcount = 0;
        $weekn = (date('Y', $update_time) - 1970) * 52 + date('W', $update_time);
        $lvcount = $counter_view + ($counter_follow * 10) + ($counter_order * 100) + $weekn * 200 + $order_lv * 1000;
        return $lvcount;
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