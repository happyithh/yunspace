<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-3-30
 * Time: 下午3:18
 * yl
 * 供应商案例审核
 */
$_REQUEST['action'] = empty($_REQUEST['action']) ? 'check_case' : $_REQUEST['action'];

class OA_Check_Case_Info
{
    static function handle()
    {
        if (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'refuse') {
            self::handleCaseRefuse();
        } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'pass') {
            self::handleCasePass();
        } else {
            self::handleCaseDetail();
        }
    }

    /*
   *案例信息详情页
   */
    static function handleCaseDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $cols = array('{table}.id,{table}.case_name,{table}.des,{table}.media,{prefix}event_info.event_name,{prefix}event_info.id as event_id,{prefix}event_info.attr,{prefix}product_info.product_name');
        $conditions['id'] = $_REQUEST['id'];
        $case = Data_Mysql_Table_Event_Case::subTable('_update')->select($cols, $conditions, '', 1, '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id LEFT JOIN {prefix}product_info ON {table}.product_id = {prefix}product_info.id');
        if (empty($case[0])) {
            Func_Header::notFound();
        }
        $caseInfo = $case[0];
        if(!empty($caseInfo['media'])){
            $caseInfo['media'] = json_decode($caseInfo['media'], 1);
            $caseInfo['attr'] = $caseInfo['media'][0];
            $caseInfo['media'] = $caseInfo['media'][1];
            $caseInfo['event_name'] = "[".$caseInfo['event_id']."]&nbsp;".$caseInfo['event_name'];
        }else{
            $caseInfo['attr'] = json_decode($caseInfo['attr'], 1);
        }
        $reason = array(
            '证件不全','资历不够','其他原因'
        );
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('data', $caseInfo);
        Tpl_Smarty::display('OA', 'check/case_detail.tpl');
    }

    /*
     *案例通过审核
     */
    static function handleCasePass()
    {
//        q($_REQUEST);
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        //更新event_case_update表信息
        $condition = array('id' => $_REQUEST['id']);
        $data = array('status' => 1);
        $cols = array('id,event_id,product_set_id,vendor_id,case_name,des,media,product_id');
        $case_data = Data_Mysql_Table_Event_Case::subTable('_update')->select($cols, array('id' => $_REQUEST['id']));
//        q($case_data);
        //更新event_info 信息
        if(!empty($case_data[0])){
            Data_Mysql_Table_Event_Info::update(array('id'=>$case_data[0]['event_id']),array('status'=>'1'));
        }
        //将信息放入主表中
        if (!empty($case_data[0]['media'])) {
            $case_data[0]['media'] = json_decode($case_data[0]['media'], 1);
        }
        //如果之前被拒绝过则去掉名称“|”以及后面之前的拒绝理由
        if (!empty($case_data[0]['case_name'])) {
            $case_data[0]['case_name'] = preg_replace('/\|.*/','',$case_data[0]['case_name']);
        }
        $update_rs = Data_Mysql_Table_Event_Case::subTable('_update')->update($condition, $data);
        if ($update_rs[0] > 0) {
            $rs = Data_Mysql_Table_Event_Case::update($case_data[0]);
            if ($rs[0] > 0) {
                //创建操作日志
                $vendorInfo=Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id',array('id'=>$case_data[0]['vendor_id']));
                if(!empty($vendorInfo[0]['vendor_account_id'])){
                    Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'],$_SESSION['administrator']['id'],'活动案例通过审核','审核案例',$case_data[0]['id']);
                }
                //创建历史记录
                $history_data=array('object_id'=>$case_data[0]['id'],'admin_id'=>$_SESSION['administrator']['id'],'operate_type'=>1,'data_backup'=>$case_data[0]);
                Data_Mysql_Table_History::subTable('_event' . date("_Ym"))->insert($history_data);
                Func_Header::to(' 案例信息审核成功！', Core::$urls['path']."?action=waiting&vendor_id=".$_REQUEST['vendor_id'].'&admin_name='.$_REQUEST['admin_name'].'&time='.time());
            }
        }
        Func_Header::back('案例信息审核失败，请重试！');
    }

    /*
     *案例未通过审核
     */
    static function handleCaseRefuse()
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
        $condition = array('id' => $request['id']);
        $data = array(
            'status' => 3,
//            'case_name = CONCAT (case_name ,"|",?)' => $request['reason'],
        );
        $update_rs = Data_Mysql_Table_Event_Case::subTable('_update')->update($condition, $data);
        if ($update_rs[0] > 0) {
            $vendorInfo=Data_Mysql_Table_Vendor_Info::select('{table}.vendor_account_id,{prefix}event_case_update.id',array('{prefix}event_case_update.id = ?'=>$request['id']),'',1,'{table} LEFT JOIN {prefix}event_case_update ON {table}.id = {prefix}event_case_update.vendor_id');

            //审核拒绝则发送邮件
            $admin_name = empty($_REQUEST['admin_name']) ? '' : $_REQUEST['admin_name'];
            $id = empty($_REQUEST['id']) ? '' : $_REQUEST['id'];
            $vendor_id = empty($_REQUEST['vendor_id']) ? '' : $_REQUEST['vendor_id'];
            $href = 'http://www.yunspace.com.cn/vendor_center/vendor_admin/case_edit?case_id='.$id;
            if($_REQUEST['action'] = 'check_case') {
                $sort = '案例';
            }else{
                $sort = '';
            }
            //根据供应商案例id查询出相关数据
            if(!empty($id)) {
                $rs = Data_Mysql_Table_Event_Case::subTable('_update')->select("id,case_name",array('id = ?'=> $id));
                $rs[0]['case_name'] = preg_replace('/\|.*/','',$rs[0]['case_name']);
            }
            //根据供应商id查询出相关数据
            if(!empty($vendor_id)) {
                $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("vendor_name",array('id = ?'=> $vendor_id));
                $r[0]['vendor_name'] = preg_replace('/\|.*/','',$r[0]['vendor_name']);
            }
            //有负责人则发送邮件给负责人
            if(!empty($admin_name))
            {
                OA_Account_Check::refuseMailtoAdmin($admin_name,$request['reason'],$r[0]['vendor_name'],$sort,$rs[0]['id'],$rs[0]['case_name']);
            } else {
                //发送邮件给供应商账户
                OA_Account_Check::refuseMailtoAccount($vendorInfo[0]['vendor_account_id'],$request['reason'],$r[0]['vendor_name'],$sort,$rs[0]['id'],$rs[0]['case_name'],$href);
            }
            //创建操作日志
            if(!empty($vendorInfo[0])){
                Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'],$_SESSION['administrator']['id'],'案例未通过审核','审核案例',$request['id']);
            }
            Func_Header::to(' 该案例未通过审核！', Core::$urls['path']."?action=waiting&vendor_id=".$_REQUEST['vendor_id'].'&admin_name='.$_REQUEST['admin_name']);
        }
        Func_Header::back('操作错误！');
    }
}