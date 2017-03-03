<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/15
 * Time: 18:03
 */
class OA_Pedia_Space_Update{

    static function handle()
    {
        $action = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($action) {
            case "is_submit":
                self::updatePediaSpaceInfo();
                break;
            case "list":
                self::getUpdateList();
                break;
            case "update_spacepedia_submit":
                self::updatePediaSearchSubmit();
                break;
        }
    }

    static function getUpdateList($i=0){
        Core::output('');
        $cityId = Page_Site_Global::tagsName('城市');
        Data_Mysql_Table_Spacepedia_Search::select('1');
        $conditions[] = "(s1.update_time != p1.update_time or  s1.update_time is null or s1.status != p1.status or s1.update_time<".(time()-86400*30).")";
//        $conditions[] ="p1.addr!= ''";
        $conditions[] ="p1.category_id not in (200,300,400)";
        $table = "{table} as p1 left join {prefix}spacepedia_search as s1 ON s1.id=p1.id";
//        Data_Mysql_Table_Spacepedia::debug(1);
        $newData = Data_Mysql_Table_Spacepedia::select('p1.id,p1.attr,p1.addr,p1.space_name,s1.update_time,p1.update_time as update_time2, s1.addr as addr2, s1.geo_lat,s1.geo_lng', $conditions, 'ORDER BY p1.update_time DESC', 10, $table);
//        q($newData);
        $order = array("\r\n", "\n", "\r");
//        if (empty($newData)) {
//            Tpl_Smarty::display("OA_Static","spacepedia/update/product_search_update.tpl");
//            die();
//        }
        $upToTime = time() - 86400 * 7;
        foreach ($newData as $k => $v) {
            if (($v['addr'] == $v['addr2'] && $v['update_time'] > $upToTime)  || (!empty($_SESSION['map_retry'][$v['id']]) && $_SESSION['map_retry'][$v['id']] > 3) || $v['addr2']='') {
                self::updateSearch($v['id']);
                unset($newData[$k]);
                continue;
            }
            $data = json_decode($v['attr'], true);
//            if (!$data[$cityId]) {
//                self::updateSearch($v['id']);
//                unset($newData[$k]);
//                continue;
//            }
            $data_city = isset($data[$cityId])?$data[$cityId]:'';
            $newData[$k]['attr'] = $data;
            $newData[$k]['city'] = $data_city;
            $newData[$k]['newAddr'] = str_replace($order, '', $data_city . ' ' . $newData[$k]['addr']);
            //防止重复
            $_SESSION['map_retry'][$v['id']] = empty($_SESSION['map_retry'][$v['id']]) ? 1 : $_SESSION['map_retry'][$v['id']] + 1;
        }
        if (empty($newData) && $i < 10) {
            return self::getUpdateList($i + 1);
        }
//        Tpl_Smarty::assign('_package', Core::$urls['package']);
        Tpl_Smarty::assign('addrData', $newData);
        Tpl_Smarty::display("OA_Static","spacepedia/update/product_search_update.tpl");
    }


    static  function updatePediaSearchSubmit(){
        $shangquanId = Page_Site_Global::tagsName('所属商圈');
        $quyuId = Page_Site_Global::tagsName('行政区域');
        Core::output('');
        if(empty($_REQUEST['addrInfos'])){
            echo "no data";
            die();
        }
        $list = $_REQUEST['addrInfos'];
        $list = json_decode($list);
        $insertTime = 0;
        foreach ($list as $k => $v) { //0为id 1为lng 2为lat 3为商圈和行政区
            $spacepedia_id[] = $v[0];
            $spacepedia_info = Data_Mysql_Table_Spacepedia::select('id,attr,update_time', $v[0]);
            if (empty($spacepedia_info[0])) {
                continue;
            }
            $spacepedia_info = $spacepedia_info[0];
            $attr_new = json_decode($spacepedia_info['attr'], 1);
            if (empty($v[3][0])) {
                $v[3][0] = '';
            }
            if (empty($v[3][1])) {
                $v[3][1] = '';
            }
            $attr_new[$shangquanId] = str_replace('、', ',', $v[3][0]);
            $attr_new[$quyuId] = str_replace('、', ',', $v[3][1]);
//            $dataMain = array(
//                'geo_lng' => intval($v[1] * 10000),
//                'geo_lat' => intval($v[2] * 10000),
//                'attr' => $attr_new,
////                'update_time' => time()
//            );
            if($spacepedia_info['update_time']<(time()-86400*30)){
                $sql = "UPDATE {table} SET geo_lng=?,geo_lat=?,attr=?,update_time=? WHERE id=?";
                $contions = array(intval($v[1] * 10000),intval($v[2] * 10000),json_encode($attr_new),(time()-86400*7),$spacepedia_info['id']);
            }else{
                $sql = 'UPDATE {table} SET geo_lng=?,geo_lat=?,attr=? WHERE id=?';
                $contions = array(intval($v[1] * 10000),intval($v[2] * 10000),json_encode($attr_new),$spacepedia_info['id']);
            }
            Data_Mysql_Table_Spacepedia::query($sql,$contions);
            $insertTime += 1;
        }
        if(!empty($spacepedia_id)){
            self::updateSearch($spacepedia_id);
        }
        if ($insertTime !== 0 && $insertTime == count($list)) {
            echo 'ok';
        } else {
            echo 'notOk';
        }
        die();
    }
    //更新到product_search表中
    static function updateSearch($spacepedia_id)
    {
        if (empty($spacepedia_id)) {
            return false;
        }
        if (is_array($spacepedia_id)) {
            foreach ($spacepedia_id as $v) {
                unset($_SESSION['map_retry'][$v]);
            }
            $conditions[] = "tb1.id IN(" . implode(',', $spacepedia_id) . ")";
        } else {
            $conditions['tb1.id=?'] = $spacepedia_id;
            unset($_SESSION['map_retry'][$spacepedia_id]);
        }
        $cols = 'tb1.*,tb2.click,tb2.is_love,tb2.is_good,tb2.is_go';
//        $cols .= '{table}.media,{table}.price,{table}.vendor_id,{table}.id,{table}.product_name,{table}.category_id,{table}.addr,{table}.logo,{table}.geo_lat,{table}.geo_lng,{table}.attr_new,{table}.des,{table}.status,
//           {table}.update_time,{table}.counter_follow,{table}.counter_order,{table}.counter_order_complete,{table}.product_size as order_product_size,{table}.score as order_score,{table}.counter_view as order_counter_view,{table}.order_lv,v1.vendor_remarks,v1.vendor_account_id';
        $table = '{table} as tb1 left join {prefix}baike_statistical  as tb2 ON tb2.space_id=tb1.id';
//        $product_info = Data_Mysql_Table_Product_Info::select($cols, $conditions, '', '30', $table);
        $result = Data_Mysql_Table_Spacepedia::select($cols, $conditions,'',30,$table);
        foreach ($result as $key => $val) {
            $val = self::getLogo($val);
            $val = OA_Pedia_Make_Index::updatePediaIndex($val);
            if (!$val['logo']) {
                $val['logo'] = '';
                Core::log('baike_search',$val['space_name'].':logo为空','space_id:'.$val['id']);
            }
            if (empty($val['addr'])) {
                $val['addr'] = '';
                Core::log('baike_search',$val['space_name'].':地址为空','space_id:'.$val['id']);
            }
            if(empty($val['geo_lat'])){
                Core::log('baike_search',$val['space_name'].':geo_lat为空','space_id:'.$val['id']);
            }
            if(empty($val['geo_lng'])){
                Core::log('baike_search',$val['space_name'].':geo_lng为空','space_id:'.$val['id']);
            }
            if(empty($val['tag'][77]['所属商圈'])){
                Core::log('baike_search',$val['space_name'].':所属商圈为空','space_id:'.$val['id']);
            }
            if(empty($val['tag'][77]['行政区域'])){
                Core::log('baike_search',$val['space_name'].':行政区域为空','space_id:'.$val['id']);
            }
            $mainData = array(
                'id'=>$val['id'],
                'space_name' =>$val['space_name'],
                'nickname' => $val['nickname'],
                'category_id' => $val['category_id'],
                'vendor_id' => $val['vendor_id'],
                'city' => $val['city'],
                'addr' => $val['addr'],
                'logo' => $val['logo'],
                'mobile_logo' =>$val['mobile_logo'],
                'attr' => $val['attr'],
//                'media' => $val['media'],
                'des' => $val['des'],
                'status' => $val['status'],
//                'subhead'=>json_decode($val['subhead'],1),
                'level'=>$val['level'],
                'create_time' => $val['create_time'],
                'update_time' => $val['update_time'],
                'geo_lat' => $val['geo_lat'],
                'geo_lng' => $val['geo_lng'],
                'product_id' => $val['product_id'],
                'size'=>isset($val['attr'][10])?intval($val['attr'][10]):0,
                'order_index'=>$val['order_index'],
                'click'=>$val['click'],
                'level'=>$val['level'],
                'price_unit' => $val['price_unit'],
                'min_price' => $val['min_price'],
                'max_price' => $val['max_price'],
            );
            //暂时先不分表。如果查询的时候。按照category_id 来区分文创项目还是一般  而且现在文创项目暂时没有单独搜索
//            $parent_id = Data_Mysql_Table_Spacepedia::getParent($val['category_id']);
//            if($parent_id==0 && $val['category_id']==200){
//                Data_Mysql_Table_Spacepedia_Search::subTable('_winchance')->update($mainData);
//            }
//            if($parent_id==0 && $val['category_id']==300){
//                Data_Mysql_Table_Spacepedia_Search::subTable('_raiders')->update($mainData);
//            }
//            if($parent_id==0 && $val['category_id']==400){
//                Data_Mysql_Table_Spacepedia_Search::subTable('_information ')->update($mainData);
//            }
//            if($parent_id==112 || $val['category_id']==112){
//                Data_Mysql_Table_Spacepedia_Search::update($mainData);
//            }
            Data_Mysql_Table_Spacepedia_Search::update($mainData);
//            $update_month=date("Ym",$val['create_time']);
//            unset($mainData['id']);
//            $condition = array('data_backup'=>$mainData);
//            Data_Mysql_Table_History::subTable('_baike_' . $update_month)->update($val['id'], $condition);
        }
    }

    static function getLogo($product_info)
    {
        $product_info['media'] = json_decode($product_info['media'], 1);
        $firstPic = '';
        if (!empty($product_info['media'])) {
            foreach ($product_info['media'] as $mk => $mv) {
                $mv['path'] = str_replace('//', '/', $mv['path']);
                if(!$firstPic){
                    $firstPic = $mv['path'];
                }
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
        $item = Data_Mysql_Table_Space_Item::select("*",array('space_id'=>$product_info['id']),'',1);
        if (empty($product_info['logo'])&&!$firstPic) {
//            $item = Data_Mysql_Table_Space_Item::select("*",array('space_id'=>$product_info['id']),'',1);
            if (!empty($item)&& isset($item[0]['media'])) {
                $item[0]['media'] = json_decode($item[0]['media'],1);
                foreach ($item[0]['media'] as $mk => $mv) {
                    $mv['path'] = str_replace('//', '/', $mv['path']);
                    if(!$firstPic){
                        $firstPic = $mv['path'];
                    }
                    //主图
                    if (strpos($mv['tags'], '@主图') !== false) {
                        $product_info['logo'] = $mv['path'];
                        break;
                    }
                    if (strpos($mv['tags'], '@logo') !== false) {
                        $product_info['logo'] = $mv['path'];
                        break;
                    }
                    if (strpos($mv['tags'], '外景图片') !== false) {
                        $product_info['logo'] = $mv['path'];
                        break;
                    }
                }
            }
        }
        $product_info['price_unit'] = (isset($item[0]['price_unit'])&&!empty($item[0]['price_unit']))?$item[0]['price_unit']:"/天";
        $product_info['min_price']= (isset($item[0]['min_price'])&&!empty($item[0]['min_price']))?$item[0]['min_price']:0;
        $product_info['max_price']= (isset($item[0]['max_price'])&&!empty($item[0]['max_price']))?$item[0]['max_price']:0;
        if(empty($product_info['logo'])){
            $product_info['logo'] = $firstPic;
        }
        return $product_info;
    }
}