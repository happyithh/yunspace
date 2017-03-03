<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-4-27
 * Time: 下午7:46
 */
class Web_Product_Info extends Page_Base
{
    /*
     * 获取产品Id
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

    /*
     * 获取产品信息
     */
    function productInfo()
    {
        if ($this->isUpdate) {
            $u_where['id'] = $this->id;
            $u_where[] = " status IN(1,2,3)";
            $rs = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', $u_where);
        } else {
            $rs = Data_Mysql_Table_Product_Info::select('*', array('id' => $this->id, 'status' => 1));
        }
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        $productInfo = $rs[0];
        $productInfo['attr_new'] = json_decode($productInfo['attr_new'], 1);
        $temp_arr=explode(',',$productInfo['attr_new'][46]);
        $productInfo['city'] = $temp_arr[0];
        $productInfo['attr'] = json_decode($productInfo['attr'], 1);
        $productInfo['media'] = json_decode($productInfo['media'], 1);
        $productInfo['price'] = ($productInfo['price'] > 10000) ? ($productInfo['price'] / 100) : 0;
        $allCategory = $this->categoryInfo();
        if (empty($allCategory[$productInfo['category_id']])) {
            $productInfo['category_id'] = $this->vendorInfo['top_category_id'];
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
        //处理图片数组
        if (!empty($productInfo['media'])) {
            $picsName = $productInfo['is_space'] ? '外景图片' : '产品图片';
            $code = array(
                $picsName,
                "内景图片",
                "平面图",
                "视频"
            );
            $img = array('jpeg', 'jpg', 'png', 'gif');
            $media = array();
            foreach ($productInfo['media'] as $k => $v) {
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

            $productInfo['media'] = $filter_media;
        }
        return $productInfo;
    }

    /*
    *获取产品的标签属性
    */
    function tags()
    {
        return Data_Mysql_Table_Product_Category::getTagsInfo($this->productInfo['category_id'], 0, 1);
    }

    /*
     * 获取分类信息
     */
    function categoryInfo()
    {
        return Data_Mysql_Table_Product_Category::getInfoCache();
    }

    /*
     * 获取标签信息
     */
    function tagsInfo()
    {
        return Data_Mysql_Table_Tags::getInfoCache();
    }

    /*
     * 获取标签列表
     */
    function tagsTree()
    {
        return Data_Mysql_Table_Tags::getTreeCache();
    }

    /*
     * 获取活动案例
     */
    function eventInfo()
    {
        if ($this->isTemporary) {
            return false;
        }
        $event = Data_Mysql_Table_Event_Case::page(0, 0, '{table}.event_id,t2.logo, t2.event_name, t2.des, {table}.des as case_des, {table}.product_name, {table}.case_name,{table}.media', array(
            'product_id' => $this->id,
        ), '', '{table} LEFT JOIN {prefix}event_info as t2 ON {table}.event_id = t2.id ');
        if (!empty($event['rows'])) {
            foreach ($event['rows'] as $ek => $ev) {
                if (strpos($ev['case_name'], ']')) {
                    $case_arr = explode(']', $ev['case_name']);
                    $event['rows'][$ek]['case_name'] = trim($case_arr[1]);
                }
                if (!$ev['des']) {
                    $event['rows'][$ek]['des'] = $ev['case_des'];
                }
                //处理图片数组
                if (!empty($ev['media'])) {
                    $event['rows'][$ek]['media'] = json_decode($ev['media'], 1);
                    foreach ($event['rows'][$ek]['media'][1] as $k => $v) {
                        $event['rows'][$ek]['case_logo'] = $v['path'];
                        //主图
                        if (strpos($v['tags'], '@主图') !== false) {
                            $event['rows'][$ek]['case_logo'] = $v['path'];
                            break;
                        }
                    }
                }
                if (empty($event['rows'][$ek]['case_logo'])) {
                    $event['rows'][$ek]['case_logo'] = $ev['logo'];
                }
            }
        }
        return $event;
    }

    /*
     *获取供应商信息
     */
    function vendorInfo()
    {
        $vendorInfo = self::getVendorInfo($this->productInfo['vendor_id']);
        return $vendorInfo;
    }

    static function getVendorInfo($vendor_id)
    {
        $data = array();
        $rs = Data_Mysql_Table_Vendor_Info::select('id,categories_id,vendor_name, base_info, attr, logo, des,vendor_remarks,vendor_account_id', array('id' => $vendor_id));
        if (!empty($rs[0]['id'])) {
            $data = $rs[0];
            $data['base_info'] = json_decode($data['base_info'], 1);
            $data['attr'] = json_decode($data['attr'], 1);
            $data['vendor_remarks'] = json_decode($data['vendor_remarks'], 1);
            $allCategory = Data_Mysql_Table_Product_Category::getInfoCache();;
            $data['categories_id'] = intval($data['categories_id']);
            if (!empty($allCategory[$data['categories_id']])) {
                $data['category'] = $allCategory[$data['categories_id']];
                $data['category_name'] = $data['category'] [0];
            }
            $data['parents'] = array();
            $data['top_category_id'] = $data['categories_id'];
            $data['parents'][] = $data['top_category_id'];
            while (!empty($allCategory[$data['top_category_id']][3])) {
                $data['top_category_id'] = $allCategory[$data['top_category_id']][3];
                $data['parents'][] = $data['top_category_id'];
            }
            $data['parents'] = array_reverse($data['parents']);
            //判断供应商是否是视频制作供应商
            $data['is_video'] = Data_Config_Site::isVideo($data['top_category_id']);
        }
        return $data;
    }

    /*
     *@猜你喜欢
     */
    function  guessYouLike()
    {
        //猜你喜欢数据
        $guessConditions = Web_Account::getFootPrintConditions();
        $guessConditions['attr_index'][46] = '+' . $_COOKIE['city'];
        $guessConditions['status'] = 1;
        $guessList = Data_Mysql_Table_Product_Search::select('id, product_name, logo, price', $guessConditions, '', 12);
        foreach ($guessList as $k => $v) {
            $guessList[$k]['price'] = $v['price'] > 10000 ? intval($v['price'] / 100) : 0;
        }
        return $guessList;
    }
}