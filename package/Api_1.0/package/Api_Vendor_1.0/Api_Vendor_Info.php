<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 *  供应商列表
 */
class  Api_Vendor_Info extends Api
{
    /*
     *获取供应商信息
     * @param   $table 是否查询update表  update 代表查询vendor_info_update表  info 代表查询vendor_info表
     * $param   $id     供应商id
     */
    static function getVendorInfo($table="info",$id){
        if($table=="update"){
            $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('*', array('id' => $id), '', 1);
        }else{
            $vendor = Data_Mysql_Table_Vendor_Info::select('*', array('id' => $id), '', 1);
        }
        if (empty($vendor[0])) {
            return self::request('error','','供应商不存在');
        }
        $vendorInfo = $vendor[0];
        if (!empty($vendorInfo['attr'])) {
            $vendorInfo['attr'] = json_decode($vendorInfo['attr'], 1);
        }
        if (!empty($vendorInfo['media'])) {
            $vendorInfo['media'] = json_decode($vendorInfo['media'], 1);
        }
        if (!empty($vendorInfo['base_info'])) {
            $vendorInfo['base_info'] = json_decode($vendorInfo['base_info'], 1);
        }

        if (!empty($vendorInfo['vendor_remarks'])) {
            $vendorInfo['vendor_remarks'] = json_decode($vendorInfo['vendor_remarks'], 1);
        }
        if (!empty($vendorInfo['categories_id'])) {
            $vendorInfo['categories_id'] = explode(',', $vendorInfo['categories_id']);
            $allCategory = Data_Mysql_Table_Product_Category::getInfoCache();
            $vendorInfo['category_name']="";
            foreach($vendorInfo['categories_id'] as $ck=>$cv){
                $vendorInfo['category_name'] .= $allCategory[$cv][0]." ";
            }
        }
        return self::request('success',$vendorInfo,'返回供应商信息详情');
    }

    /*
    *供应商信息提交
    * $param   $id     供应商id
    * $param   $data   供应商提交的信息数据
    */
    static function handleVendorSubmit($data,$id=""){
        if(empty($data['vendor_name'])) {
            return self::request('error',"",'供应商名称不能为空！');
        }
        $files = Func_Input::filter(array(
            '公司LOGO' => 'array',
            '资质证书' => 'array',
            '签约附件' => 'array',
        ), $_FILES);
        if (!empty($files['公司LOGO']['name'])) {
            $logo = Func_Upload::image('公司LOGO');
            if (!empty($logo)) {
                $data['logo'] = $logo;
            }
        }
        if (!empty($files['资质证书']['name'])) {
            $intelligence = Func_Upload::file('资质证书');
            if (is_array($intelligence) && $intelligence['code'] == 0) {
                Func_Header::back($intelligence['msg']);
            } else {
                $data['vendor_remarks']['资质证书'] = $intelligence;
            }
        }
        if (!empty($files['签约附件']['name'])) {
            $cooperate = Func_Upload::file('签约附件');
            if (is_array($cooperate) && $cooperate['code'] == 0) {
                Func_Header::back($cooperate['msg']);
            } else {
                $data['vendor_remarks']['签约附件'] = $cooperate;
            }
        }

        //获取供应商信息修改数据
        if (!empty($data['attr'])) {
            $data['attr']['签约状态']=empty($data['vendor_remarks']['签约状态'])?'3':$data['vendor_remarks']['签约状态'];
            $data['attr_index'] = Data_Mysql_Table_Vendor_Info::attrToIndex($data['attr']);
            $data['attr']['城市']=empty($data['attr']['城市'])?'上海':$data['attr']['城市'];
        }
        $data['city']=empty($data['attr']['城市'])?'上海':$data['attr']['城市'];

        if (!empty($data['categories_id'])) {
            $data['categories_id'] = implode(',', $data['categories_id']);
        }
        $data['status'] = 2;
        //写入数据库
        if (!empty($id)) {
            $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id' => $id), $data);
            if (empty($r[0])) {
                return self::request("error","",'供应商信息修改失败！');
            }else{
                //创建操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($id,$_SESSION['administrator']['id'],'供应商信息修改','供应商信息修改',$id);
                return self::request("success","",'提交成功，正在审核！！');
            }
        } else {
            $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->insert($data);
            if (empty($r[0])) {
                return self::request("error","",'供应商信息修改失败！');
            }
            //创建操作日志
            if (empty($r[0])) {
                return self::request("error","",'供应商信息添加失败！');
            }else{
                //创建操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($r[0],$_SESSION['administrator']['id'],'新增供应商','新增供应商',$r[0]);
                return self::request("success",$r[0],'提交成功，正在审核！！');
            }

        }
    }

    /*
     *获取供应商的分类信息
     */
    static function getCategoryInfo($vendorId)
    {
        $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,categories_id', array(
            'id' => $vendorId
        ));
        if (!empty($r[0]['categories_id'])) {
            $categories = explode(',', $r[0]['categories_id']);
        } elseif ($_SESSION['user']['super_vendor']) {
            $categories = array(Data_Config_Site::$staticConfig['space_id']);
        } else {
            return array();
        }
        $categoryInfo = Data_Mysql_Table_Product_Category::getInfoCache();
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        $data = array();
        foreach ($categories as $cv) {
            if (!empty($categoryInfo[$cv][3])) {
                $data[0][$categoryInfo[$cv][3]] = $categoryTree[0][$categoryInfo[$cv][3]];
                $data[$categoryInfo[$cv][3]][$cv] = $categoryInfo[$cv][0];
            } elseif (!empty($categoryTree[0][$cv])) {
                $data[0][$cv] = $categoryTree[0][$cv];
                $data[$cv] = $categoryTree[$cv];
            }
        }
        if (!empty($data[$categoryTree[0][Data_Config_Site::$staticConfig['space_id']]])) {
            $data[$categoryTree[0][Data_Config_Site::$staticConfig['space_id']]] = $categoryTree[Data_Config_Site::$staticConfig['space_id']];
        }
        return $data;
    }

}