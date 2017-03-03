<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-7
 * yl
 * 供应商信息审核
 */
$_REQUEST['action'] = empty($_REQUEST['action']) ? 'check_vendor' : $_REQUEST['action'];

class OA_Check_Vendor_Info
{
    static function handle()
    {
        if (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'refuse') {
            self::handleVendorRefuse();
        } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'pass') {
            self::handleVendorPass();
        } else {
            self::handleVendorDetail();
        }
    }
    /*
    *供应商信息详情页
    */
    static function handleVendorDetail()
    {
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $condition = array('id' => $_REQUEST['id']);
        $cols = array('id,vendor_name,addr,vendor_account_id,status,base_info,attr,categories_id,media,des,logo');
        $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->select($cols, $condition);
        if (empty($vendor[0])) {
            Func_Header::notFound();
        }
        $vendorInfo = $vendor[0];
        $vendorInfo['attr'] = json_decode($vendorInfo['attr'], 1);
        $vendorInfo['base_info'] = json_decode($vendorInfo['base_info'], 1);
//        $vendorInfo['media'] = json_decode($vendorInfo['media'], 1);
        $vendorInfo['categories_id'] = explode(',', $vendorInfo['categories_id']);
        $reason = array(
            '证件不全','资历不够','其他原因'
        );
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::assign('data', $vendorInfo);
        Tpl_Smarty::display('OA', 'check/vendor_detail_scan.tpl');

    }

    /*
     *供应商通过审核
     */
    static function handleVendorPass()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
            'categories_id' => 'array',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $cols = array('id,vendor_name,attr,city,attr_index,addr,base_info,categories_id,media,des,logo,vendor_account_id,vendor_remarks,create_time,update_time');
        $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select($cols, array('id' => $_REQUEST['id']));
        if (empty($request['categories_id'])) {
            Func_Header::back('请选择供应商的服务范围！');
        }else{
            $data[0]['categories_id'] = implode(',', $request['categories_id']);
        }
        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], 1);
        }
        if (!empty($data[0]['attr_index'])) {
            $data[0]['attr_index'] = json_decode($data[0]['attr_index'], 1);
        }
        if (!empty($data[0]['media'])) {
            $data[0]['media'] = json_decode($data[0]['media'], 1);
        }
        if (!empty($data[0]['base_info'])) {
            $data[0]['base_info'] = json_decode($data[0]['base_info'], 1);
        }
        if (!empty($data[0]['vendor_remarks'])) {
            $data[0]['vendor_remarks'] = json_decode($data[0]['vendor_remarks'], 1);
        }
        //如果之前被拒绝过则去掉名称“|”以及后面之前的拒绝理由
        if (!empty($data[0]['vendor_name'])) {
            $data[0]['vendor_name'] = preg_replace('/\|.*/','',$data[0]['vendor_name']);
        }
        //获取原供应商数据
        $old_data=Data_Mysql_Table_Vendor_Info::select('id,vendor_name', array('id' => $request['id']));
        //供应商名称更改时执行更改产品update_time操作
        $temp=false;
        if(!empty($old_data[0]) && $data[0]['vendor_name'] != $old_data[0]['vendor_name']){
            $temp=true;
        }

        //更新update表信息
        $condition = array('id' => $_REQUEST['id']);
        $update = array('status' => 1,'categories_id'=>$data[0]['categories_id']);
        $update_rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->update($condition, $update);

        //更新联系人的company字段
        if(!empty($update_rs)&&!empty($data[0]['vendor_account_id'])){
            $com = Data_Mysql_Table_Contact_Library::select('id',array('account_id'=>$data[0]['vendor_account_id']),"",100);
            if(!empty($com)){
                foreach($com as $k=>$v){
                    $company = Data_Mysql_Table_Contact_Library::update(array('id'=>$v),array('company'=>$data[0]['vendor_name']));
                }
            }
        }
        //将信息放入主表中
        //通过并上线
        if(isset($_REQUEST['upstatus'])){
            $data[0]['status'] = 1;
        }
        $rs = Data_Mysql_Table_Vendor_Info::update($data[0]);
        if ($update_rs[0]>0 && $rs[0] > 0) {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($data[0]['vendor_account_id'],$_SESSION['administrator']['id'],'供应商审核通过','供应商审核',$data[0]['id']);
            //创建历史记录
            $history_data=array('object_id'=>$data[0]['id'],'admin_id'=>$_SESSION['administrator']['id'],'operate_type'=>1,'data_backup'=>$data[0]);
            Data_Mysql_Table_History::subTable('_vendor' . date("_Ym"))->insert($history_data);
           if($temp){
               //更新产品的update_time+1
               Data_Mysql_Table_Product_Info::exec('UPDATE {table} set update_time=update_time+1 where vendor_id='.$request['id'].' AND status=1 limit 300',true);
           }

            Func_Header::to(' 供应商信息审核成功！',Core::$urls['path']."?action=waiting&vendor_id=".$_REQUEST['id'].'&admin_name='.$_REQUEST['admin_name'].'&time='.time());
        }
        Func_Header::back('供应商信息审核失败，请重试！');
    }

    /*
     *供应商未通过审核
     */
    static function handleVendorRefuse()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
            'reason' => 'string',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        if (empty($request['reason'])) {
            Func_Header::back('请输入拒绝理由');
        }
        //更新供应商update表状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 3,
//            'vendor_name = CONCAT(vendor_name,"|",?)' => $request['reason'],
        );

        $update_rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->update($condition, $data);
        if ($update_rs[0] > 0) {
//            q(123);
            $admin_name = empty($_REQUEST['admin_name']) ? '' : $_REQUEST['admin_name'];
            $vendor_id = empty($_REQUEST['id']) ? '' : $_REQUEST['id'];
            $href = 'http://www.yunspace.com.cn/vendor_center/vendor_admin/vendor_edit?vendor_id='.$vendor_id;
            //根据供应商id查询出相关数据
            if(!empty($vendor_id)) {
                $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("id,vendor_name",array('id = ?'=> $vendor_id));
                $r[0]['vendor_name'] = preg_replace('/\|.*/','',$r[0]['vendor_name']);
            }
            if($_REQUEST['action'] = 'check_vendor') {
                $sort = '供应商审核';
            }else{
                $sort = '';
            }
            //有负责人则发送邮件给负责人
            if(!empty($admin_name))
            {
                OA_Account_Check::refuseMailtoAdmin($admin_name,$request['reason'],$r[0]['vendor_name'],$sort,$r[0]['id'],$r[0]['vendor_name']);
            } else {
                //发送邮件给供应商账户
                $vendorinfo = Data_Mysql_Table_Vendor_Info::select('{table}.vendor_account_id', array('{prefix}product_info_update.id = ?' => $request['id']), '', 1, '{table} LEFT JOIN {prefix}product_info_update ON {table}.id = {prefix}product_info_update.vendor_id');
                OA_Account_Check::refuseMailtoAccount($vendorinfo[0]['vendor_account_id'],$request['reason'],$r[0]['vendor_name'],$sort,$r[0]['id'],$r[0]['vendor_name'],$href);
            }

            //创建操作日志
            $vendor_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_account_id',$condition);
            Data_Mysql_Table_Account_Log::insertAccountLog($vendor_update[0]['vendor_account_id'],$_SESSION['administrator']['id'],'供应商未通过审核','供应商审核');
            Func_Header::to(' 供应商未通过审核！', Core::$urls['path']."?action=waiting&vendor_id=".$_REQUEST['id'].'&admin_name='.$_REQUEST['admin_name']);
        }
        Func_Header::back('操作错误！');
    }

}