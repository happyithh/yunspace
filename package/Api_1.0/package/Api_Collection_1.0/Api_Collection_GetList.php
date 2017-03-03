<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/1
 * Time: 09:59
 */
class Api_Collection_GetList extends Api
{
    static function handle($args = '')
    {
        //判断是否登录
        Api_Session::checkToken();
//接受参数
        /*
         *  type     分类
         *
         *
         */
//返回结果：

        /*
        array (size=3)
  'status' => string '1' (length=1)
  'data' =>
    array (size=1)
      0 =>
        array (size=11)
          'create_time' => string '2015-05-21 10:49:31' (length=19)                  收藏时间
          'logo' => string '/upload/201505/o_19liosd1i14tars81af72rumlgk.png' (length=48)           产品图片
          'id' => string '4334' (length=4)                                                      产品id
          'category_id' => string '112' (length=3)                                              产品分类id
          'name' => string '月见花派对酒会套餐场地' (length=33)                                产品名称
          'addr' => string '中山南路505号3号楼1楼(老码头创意园区内)' (length=55)                    场地地址
          'product_size' => string '450' (length=3)   场地大小
          'attr_index' => string '{"4":"\u9ec4\u6d66\u533a","2":"\u5916\u6ee9,\u8001\u7801\u5934","3":"9\u53f7\u7ebf","46":"\u4e0a\u6d77","10":"450\u33a1","6":"5\u7c73","11":"1\u5428","8":"100~130\u4eba","14":"\u6709","13":"\u6709","12":"\u6709","7":"15KWH","15":"\/","16":"4\u7c73","17":"\u6709","18":"\u6709","5":"10\u4e2a","19":"\u65e0","20":"\u6709","21":"\u6709","22":"","23":"","24":"","25":"","26":"","27":"","28":"","29":"","30":"","9":"\u91d1\u878d,\u6c7d\u8f66,\u5962\u4f88\u54c1","49":"\u5546\u4e1a\u53d1\u5e03,\u65b0\u54c1\u53d1\u5e03'... (length=545)
          'counter_follow' => string '1' (length=1)                                         收藏数
          'counter_order' => string '0' (length=1)                                          订单数
          'category_name' => string '空间场地' (length=12)                              产品分类名称
  'msg' => string '返回成功' (length=12)
        */
        $result = self::getCollectionList($args);
        return $result;
    }

    /**
     * 接受用户id。接受用户ID，
     */

    static function getCollectionList($args)
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
        ), $args);
        //接受用户id。接受用户ID，查找消息列表中联系人聊天列表  Data_Mysql_Table_Live_Chat_Message_List
        $uid = Api_Session::user_id();
        if (empty($uid)) {
            $result = self::request('error', '', "用户未登陆");
            return $result;
        }
        $type = empty($_REQUEST['type']) ? 'space' : $_REQUEST['type'];
        $conditions = array(
            'user_id' => $uid,
            'is_cancel' => 1
        );
        $order = 'ORDER BY {table}.create_time desc';
        switch ($type) {
            case 'set':
                $cols = "{table}.create_time,{prefix}product_set.id,{prefix}product_set.logo,{prefix}product_set.set_name,{prefix}product_set.addr,{prefix}product_set.category_id,{prefix}product_set.attr_index";

                $join = "{table}   LEFT JOIN {prefix}product_set  ON {table}.follow_id = {prefix}product_set.id";

                break;
            case 'space':
                $cols = array('{table}.create_time', 't2.logo', 't2.id', 't2.category_id', 't2.product_name',
                    't2.addr', 't2.order_product_size as product_size',  't2.attr_index', 't2.counter_follow',
                    't2.counter_order');
                $join = '{table} LEFT JOIN {prefix}product_search as t2 ON {table}.follow_id = t2.id';
                break;
            case 'vendor':
                $cols = array('{table}.create_time', '{prefix}vendor_info.id', '{prefix}vendor_info.categories_id as category_id', '{prefix}vendor_info.vendor_name',
                    '{prefix}vendor_info.base_info', '{prefix}vendor_info.attr', '{prefix}vendor_info.media', '{prefix}vendor_info.counter_follow',
                    '{prefix}vendor_info.counter_order');
                $join = '{table} LEFT JOIN {prefix}vendor_info ON {table}.follow_id = {prefix}vendor_info.id';
                break;
            case 'event':
                $cols = array('{table}.create_time', '{prefix}event_info.id', '{prefix}event_info.category_id', '{prefix}event_info.event_name',
                    '{prefix}event_info.addr', '{prefix}event_info.attr', '{prefix}event_info.des', '{prefix}event_info.media', '{prefix}event_info.counter_follow',
                    '{prefix}event_info.counter_view', '{prefix}event_info.logo');
                $join = '{table} LEFT JOIN {prefix}event_info ON {table}.follow_id = {prefix}event_info.id';
                break;
        }
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
//        Data_Mysql_Table_Follow::subTable("_$type")->debug(1);
        $rs = Data_Mysql_Table_Follow::subTable("_$type")->select( $cols, $conditions, $order,50, $join);
        if (!empty($rs)) {
            foreach ($rs as $key => $value) {

                if (!empty($value['attr'])) {
                    $rs[$key]['attr'] = json_decode($value['attr'], 1);
                }
                if (!empty($value['base_info'])) {
                    $rs[$key]['base_info'] = json_decode($value['base_info'], 1);
                }
                if (!empty($value['media'])) {
                    $rs[$key]['media'] = json_decode($value['media'], 1);
                    foreach ($rs[$key]['media'] as $mk => $mv) {
                        //主图
                        if (empty($rs[$key]['logo'])) {
                            $rs[$key]['logo'] = $mv['path'];
                        }
                        $mvTags = explode(',', $mv['tags']);
                        foreach ($mvTags as $mTag) {
                            if ($mTag == '@主图') {
                                $rs[$key]['logo'] = $mv['path'];
                            }
                            $rs[$key]['media'][$mTag][$mv['path']] = $mv['name'];
                        }
                    }
                }
                if(!empty($value['logo'])){
                    $rs[$key]['logo'] =  Data_Config_Site::displayMedia($value['logo'],275,195);
                }
                if ($type == 'set') {
                    if (!empty($value['attr_index'])) {
                        $rs[$key]['attr_index'] = json_decode($value['attr_index'], 1);
                    }
                    if(isset($value['category_id'])){
                        $rs[$key]['category_name'] = Data_Mysql_Table_Product_Set::$category_name[$value['category_id']];
                    }
                } else {
                    if (!empty($value['attr_index'])) {
                        $rs[$key]['attr_index'] = json_decode($value['attr_index'], 1);
                    }
                    if (!empty($categories[$value['category_id']][0])) {
                        $rs[$key]['category_name'] = $categories[$value['category_id']][0];
                    }
                }
                switch($type){
                    case "space":
                        $rs[$key]['name']  = $value['product_name'];
                        break;
                    case "set":
                        $rs[$key]['name']  = $value['set_name'];
                        break;
                    case "vendor":
                        $rs[$key]['name']  = $value['vendor_name'];
                        break;
                    case "space":
                        $rs[$key]['name']  = $value['product_name'];
                        break;
                    default:
                        $rs[$key]['name']  = $value['event_name'];
                        break;
                }
                if(empty($value['id'])){
                    unset($rs[$key]);
                }
            }
        }
        if (!empty($rs)) {
            $result = self::request('success', $rs, "返回成功");
        } else {
            $result = self::request('error', '', "没有收藏数据");
        }
        return $result;
    }
}

