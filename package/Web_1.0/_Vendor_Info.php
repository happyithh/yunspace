<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-4-28
 * Time: 下午7:46
 */
class Web_Vendor_Info extends Page_Base
{
    /*
     * 获取供应商Id
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
     * 获取是否要调取update表中供应商信息
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
     * 获取供应商信息
     */
    function vendorInfo()
    {
        if ($this->isUpdate()) {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('*', array('id' => $this->id));
        } else {
            $rs = Data_Mysql_Table_Vendor_Info::select('*', array('id' => $this->id));
        }
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        $vendorInfo = $rs[0];
        $vendorInfo['base_info'] = json_decode($vendorInfo['base_info'], 1);
        $vendorInfo['attr'] = json_decode($vendorInfo['attr'], 1);
        $vendorInfo['media'] = json_decode($vendorInfo['media'], 1);
        $vendorInfo['vendor_remarks'] = json_decode($vendorInfo['vendor_remarks'], 1);
        //读取分类信息
        $vendorInfo['top_category_ids']=array();
        $allCategory = Data_Mysql_Table_Product_Category::getInfoCache();
        if (!empty($vendorInfo['categories_id'])) {
            $vendorInfo['categories_id'] = explode(',', $vendorInfo['categories_id']);
            $category_name = '';
            foreach ($vendorInfo['categories_id'] as $ck => $cv) {
                $category_name .= $allCategory[$cv][0] . '&nbsp';
                $vendorInfo['top_category_ids'][] = $cv;
                if (!empty($allCategory[$cv][3])) {
                    $vendorInfo['top_category_ids'][] = $allCategory[$cv][3];
                }
            }
            $vendorInfo['category_name'] = $category_name;
        }
        $vendorInfo['is_space']=false;
        if(in_array(Data_Config_Site::$staticConfig['space_id'],array_unique($vendorInfo['top_category_ids']))){
            $vendorInfo['is_space']=true;
        }
//        $vendorInfo['parents'] = array();
//        $vendorInfo['top_category_id'] = intval($vendorInfo['categories_id']);
//        $vendorInfo['parents'][] = $vendorInfo['top_category_id'];
//        while (!empty($allCategory[$vendorInfo['top_category_id']][3])) {
//            $vendorInfo['top_category_id'] = $allCategory[$vendorInfo['top_category_id']][3];
//            $vendorInfo['parents'][] = $vendorInfo['top_category_id'];
//        }
//        $vendorInfo['parents'] = array_reverse($vendorInfo['parents']);
//        //判断供应商是否是视频制作供应商
//        $vendorInfo['is_video'] = Data_Config_Site::isVideo($vendorInfo['top_category_id']);

        //更新供应商信息计数器
        Data_Mysql_Table_Vendor_Info::query('UPDATE {table} SET counter_view = counter_view+1 WHERE id = ?', array($this->id));
        if (rand(1, 30) == 2) {
            Data_Mysql_Table_Vendor_Info::exec("UPDATE  {table} SET counter_view_index =  counter_view");
        }
        return $vendorInfo;
    }

    /*
     *获取供应商下的产品
     */

    function productInfo()
    {
        //读取供应商的产品信息
        $productInfo = Data_Mysql_Table_Product_Info::select('*', array('vendor_id' => $this->id, 'status' => 1), '', 100);
        foreach ($productInfo as $key => $value) {
            $productInfo[$key]['attr_new'] = json_decode($value['attr_new'], 1);
            if (!empty($productInfo[$key]['attr_new'])) {
                $tag_info = Data_Mysql_Table_Tags::getInfoCache();
                $tag_tree = Data_Mysql_Table_Tags::getTreeCache();
                foreach ($productInfo[$key]['attr_new'] as $tk => $tv) {
                    $parent_name = $tag_tree[0][$tag_info[$tk]['parent_id']];
                    $son_name = $tag_info[$tk]['tags_name'];
                    $productInfo[$key]['attr_new_tags'][$parent_name][$son_name] = $tv;
                }
            }
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
        return $productInfo;

    }

    function  setInfo()
    {
        $conditions['status'] = 1;
        $conditions['vendor_id'] = $this->id;
        $rs = Data_Mysql_Table_Product_Set::select('id,logo,set_name,addr', $conditions, 'ORDER BY update_time DESC', 100);
        return $rs;
    }

    /*
     *获取供应商下的活动案例
     */
    function  eventInfo()
    {
        $caseInfo = array();
        $caseInfo = Data_Mysql_Table_Event_Case::select('event_id,case_name,product_name,logo,des', array(
            'vendor_id' => $this->id,
        ), 'ORDER BY update_time DESC', 6, '{table} LEFT JOIN {prefix}event_info ON  {prefix}event_info.id = {table}.vendor_id');
        if (!empty($caseInfo)) {
            foreach ($caseInfo as $ek => $ev) {
                $case_arr = explode(']', $ev['case_name']);
                $caseInfo[$ek]['case_name'] = trim($case_arr[1]);
            }
        }
        return $caseInfo;
    }

}