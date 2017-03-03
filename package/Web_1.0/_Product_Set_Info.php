<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/13
 * Time: 14:47
 * @套餐详情
 */
class  Web_Product_Set_Info extends Page_Base
{
    /*
    * 获取套餐Id
    */
    function id()
    {
        $action_arr = explode('/', Core::$urls['action']);
        if (count($action_arr) == 2) {
            return substr($action_arr[1], 0, -5);
        } else {
            return substr($action_arr[0], 0, -5);
        }
    }

    /*
     * 获取是否要调取update表中产品
     */
    function isUpdate()
    {
        $action_arr = explode('/', Core::$urls['action']);
        if (count($action_arr) == 2 && $action_arr[0] == md5($this->id)) {
            return true;
        } else {
            return false;
        }
    }
    //类别
    function allCategory()
    {
        return Data_Mysql_Table_Product_Set::$category_name;
    }
    /*
     * 获取套餐信息
     */
    function info()
    {
        if ($this->isUpdate) {
            $u_where['id'] = $this->id;
            $u_where[] = " status IN (1,2,3)";
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', $u_where);

        } else {
            $rs = Data_Mysql_Table_Product_Set::select('*', array('id' => $this->id, 'status' => 1));
        }
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        $info = Data_Mysql_Table_Product_Set::rowFormat($rs[0]);
        $info['category_name'] = Data_Mysql_Table_Product_Set::$category_name[$info['category_id']];
        if (!empty($info['detail_data'])) {
            foreach ($info['detail_data'] as $k => $v) {
                if (isset($v['产品']) && is_array($v['产品'])) {
                    foreach ($v['产品'] as $vk => $vv) {
                        if (!is_numeric($vv)) {
                            $info['detail_data'][$k]['产品'][$vk] = intval(basename($vv));
                        }
                    }
                }
            }
        }
        if(!empty($info['attr_index']['城市'])){
            $temp_arr=explode(",",$info['attr_index']['城市']);
            $info['city']=$temp_arr[0];
        }

        return $info;
    }

    function isV2()
    {
        return !empty($this->info['version']);
    }

    /*
     *获取供应商信息
     */
    function vendorInfo()
    {
        return Web_Product_Info::getVendorInfo($this->info['vendor_id']);
    }

    function media()
    {
        if (empty($this->info['media'])) {
            return array();
        }
        //处理图片数组
        $picsName = '套餐图片';
        $code = array(
            '外景图片',
            '产品图片',
            '活动图片',
            "内景图片",
            "平面图",
            "视频"
        );
        $img = array('jpeg', 'jpg', 'png', 'gif');
        $media = array();
        foreach ($this->info['media'] as $k => $v) {
            //过滤非法图片
            $extension = strtolower(substr($v['path'], strrpos($v['path'], '.') + 1));
            if (in_array($extension, $img)) {
                if (!empty($v['video'])) {
                    $v['tags'] = '视频';
                }
                $tags = explode(',', $v['tags']);
                foreach ($tags as $tv) {
                    if (empty($tv) || !in_array($tv, $code)) {
                        $tv = $picsName;
                    }
                    empty($v['video']) and $v['video'] = '';
                    $media[$tv][$k] = array($v['name'], $v['path'], $v['video']);
                }
            }
        }
        $filter_media = array();
        if (!empty($media['视频'])) {
            foreach ($media as $k1 => $v1) {
                if (empty($v1)) {
                    unset($media[$k1]);
                }
                $filter_media['视频'] = $media['视频'];
                if ($k1 != '视频') {
                    foreach ($v1 as $vk1 => $vv1) {
                        $filter_media['图片'][$vk1] = $vv1;
                    }
                }
            }
        } else {
            $filter_media = $media;
        }
        return $filter_media;
    }

    function isBegin()
    {
        return $this->info['attr_index']['开始时间'] && strtotime($this->info['attr_index']['开始时间']) < time();
    }

    function isEnd()
    {
        return $this->info['attr_index']['开始时间'] && $this->info['attr_index']['结束时间'] && strtotime($this->info['attr_index']['结束时间']) < time();
    }

    function space_info()
    {
        if (!empty($this->info['schedule_product_id'])) {
            $r = Data_Mysql_Table_Product_Info::select('id,category_id,product_name,price,attr_new,des', array('id' => $this->info['schedule_product_id']));
            if (!empty($r[0]['id'])) {
                $r[0]['attr_new'] = json_decode($r[0]['attr_new'], 1);
                $r[0]['price'] = intval(abs($r[0]['price'] / 100));
                $r[0]['tags'] = Data_Mysql_Table_Product_Category::getTagsInfo($r[0]['category_id'], 0, 1);
                return $r[0];
            }
        }
    }

    function products()
    {
        $products = array();
        if (empty($this->info['detail_data'])) {
            return $products;
        }
        $productIds = array();
        foreach ($this->info['detail_data'] as $k => $v) {
            if (isset($v['产品']) && is_array($v['产品'])) {
                $productIds = array_merge($productIds, $v['产品']);
            }
        }
        $rs = Data_Mysql_Table_Product_Info::select('id,category_id,product_name,price,attr_new,des', array('id IN (' . implode(',', $productIds) . ')'), '', count($productIds));
        if (!empty($rs)) {
            foreach ($rs as $v) {
                $v['attr_new'] = json_decode($v['attr_new'], 1);
                unset($v['attr_new'][46]);
                $v['price'] = intval(abs($v['price'] / 100));
                $products[$v['id']] = $v;
            }
        }
        return $products;
    }

    function detail()
    {
        if ($this->isV2) {

            return array(
                array(
                    '名称' => $this->info['version'],
                    '市场价' => $this->info['detail']['市场价'],
                    '价格' => $this->info['detail']['套餐价'],
                    '折扣' => empty($this->info['detail']['市场价']) ? 0 : intval($this->info['detail']['套餐价'] / $this->info['detail']['市场价'] * 100) / 10
                )
            );
        }
        //套餐改版前数据处理，之后要删掉
        if (empty($this->info['detail_data'])) {
            return array();
        }
        $detail = $this->info['detail_data'];
        foreach ($detail as $k => $v) {
            //原价 与 折扣
            $detail[$k]['市场价'] = 0;
            if (isset($v['产品']) && is_array($v['产品'])) {
                foreach ($v['产品'] as $vk) {
                    if (!empty($this->products[$vk]['price'])) {
                        $detail[$k]['市场价'] += abs($this->products[$vk]['price']);
                    }
                }
            } else {
                $detail[$k]['产品'] = array();
            }
            if (!$detail[$k]['市场价']) {
                $detail[$k]['市场价'] = $detail[$k]['价格'];
            }
            $detail[$k]['折扣'] = intval($detail[$k]['价格'] / $detail[$k]['市场价'] * 100) / 10;
        }
        return $detail;
    }

    function detailTags()
    {
        $tags = array();
        foreach ($this->detail as $k => $v) {
            $k = $v['名称'];
            if ($v['产品']) {
                foreach ($v['产品'] as $vk => $vv) {
                    if (empty($tags[$vk]['id'])) {
                        $tags[$vk]['id'] = $vv;
                        $tags[$vk]['type'] = 1;
                    } else {
                        if ($vv != $tags[$vk]['id']) {
                            $tags[$vk]['type'] = 2;
                        }
                    }
                    if (empty($tags[$vk]['tags'])) {
                        $tags[$vk]['tags'] = array();
                    }
                    if (!empty($this->products[$vv])) {
                        $tags[$vk]['tags'] += $this->products[$vv]['attr_new'];
                    }
                    $tags[$vk]['ids'][$k] = array($k, $vv);
                }
            }
        }
        foreach ($tags as $k => $v) {
            $tags[$k]['ids'] = array_values($v['ids']);
            if ($v['type'] == 1) {
                $tags[$k]['tags'] = Data_Mysql_Table_Product_Category::getTagsInfo($this->products[$v['id']]['category_id'], 0, 1);
            }
        }
        return $tags;
    }

    /*
   * 获取活动案例
   */

    function eventInfo()
    {
        $cols = '{table}.event_id,t2.id,t2.logo, t2.event_name, t2.des,{table}.case_name,{table}.media';
        $conditions['product_set_id'] = $this->id;
        $conditions['status'] = 1;
        $event = Data_Mysql_Table_Event_Case::subTable('_update')->select($cols, $conditions, '', 5, '{table} LEFT JOIN {prefix}event_info as t2 ON {table}.event_id = t2.id ');
        if (!empty($event)) {
            foreach ($event as $ek => $ev) {
                if (strpos($ev['case_name'], ']')) {
                    $case_arr = explode(']', $ev['case_name']);
                    $event[$ek]['case_name'] = trim($case_arr[1]);
                }
                //处理图片数组
                if (!empty($ev['media'])) {
                    $event[$ek]['media'] = json_decode($ev['media'], 1);
                    foreach ($event[$ek]['media'][1] as $k => $v) {
                        $event[$ek]['case_logo'] = $v['path'];
                        //主图
                        if (strpos($v['tags'], '@主图') !== false) {
                            $event[$ek]['case_logo'] = $v['path'];
                            break;
                        }
                    }
                }
            }
        }
        return $event;
    }

    /*
       *获取产品的标签属性
       */
    function allTags()
    {
        return Data_Mysql_Table_Tags::getIdsCache();;
    }

    function recommanService()
    {
        $ids = array(
            '168' => '168',
            '3150' => '3150',
            '3046' => '3046',
            '2975' => '2975',
            '2835' => '2835',
            '150' => '150',
            '2568' => '2568',
        );
    }

    /*
     * 获取该套餐所有版本
     */
    function otherVersion()
    {
        $versions = array(
            '品质版'=>'',
            '奢华版'=>'',
        );
        $data = array();
//        $conditions['id != ?']=$this->id;
        if(empty($this->info['schedule_product_id'])){
            return $versions=array(array('id'=>$this->id,'version'=>$this->info['version']));
        }
        $conditions['vendor_id = ?'] = array($this->info['vendor_id']);
        $conditions['schedule_product_id = ?'] = array($this->info['schedule_product_id']);
        $conditions['category_id = ? and category_id != ? AND status >0'] = array($this->info['category_id'], 0);
        $rs = self::getData($conditions, 10);
        foreach($rs as $k=>$v){
            $versions[$v['version']] = $v;
        }
        foreach($versions as $k=>$v){
            if(!$v){
                unset($versions[$k]);
            }
        }
        return array_values($versions);
    }

    /*
     *获取同类套餐
     */
    function sameCategory()
    {
        $data = array();
        $conditions['id != ?'] = $this->id;
        if (!empty($this->info['category_id'])) {
            $conditions['category_id'] = $this->info['category_id'];
        }
        $conditions['status>?'] = 0;
        return self::getData($conditions, 10);
    }

    static function getData($conditions = array(), $limit = 10)
    {
        $data = Data_Mysql_Table_Product_Set::select('id,set_name,logo,media,category_id,version', $conditions, '', $limit);
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                if (!empty($v['media']) && empty($v['logo'])) {
                    $data[$k]['media'] = json_decode($v['media'], 1);
                    foreach ($data[$k]['media'] as $mk => $mv) {
                        $data['logo'] = $mv['path'];
                        //主图
                        if (strpos($mv['tags'], '@主图') !== false) {
                            $data['logo'] = $mv['path'];
                            break;
                        }
                    }
                }
            }
        }
        return $data;
    }

    /*
     *获取某时间段内的不包含周六周日的天数
     */
    static function getRestDays($start_time, $end_time)
    {
        if ($start_time > $end_time) {
            Func_Header::back('日期错误！！');
        }
        $rest_days = 0;
        $total = round(($end_time - $start_time) / 86400) + 1;
        for ($i = 0; $i < $total; $i++) {
            $dateandtime = $start_time + ($i * 24 * 3600);
            if ((date('w', $dateandtime) == 6) || (date('w', $dateandtime) == 0)) {
                $rest_days++;
            }
        }
        return $total - $rest_days;
    }

}