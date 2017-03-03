<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 17:35
 * IP内容管理列表
 */
//@session_start();
//q($_SESSION);
class OA_Winchance_list {
    static function handle()
    {
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::winchanceList();
                break;
            case 'add':
                self::winchanceEdit();
                break;
            case 'edit':
                self::winchanceEdit();
                break;
            case 'dataSubmit':
                self::WinchanceSubmit();
                break;
            case 'delete':
                self::WinchanceDelete();
                break;

        }
    }
    static function winchanceList(){
        /*
         * 获取模板必要数据------开始
         * */
        $ip_type = empty($_REQUEST['ip_type'])?'done':$_REQUEST['ip_type'];
        Tpl_Smarty::assign('ip_type',$ip_type);
        // 运营范围
        $city =Data_Mysql_Table_Winchance_Fields::getContent('运营范围');
        Tpl_Smarty::assign('city',$city);
        // 表现形式
        $manifestation =Data_Mysql_Table_Winchance_Fields::getContent('表现形式');
        Tpl_Smarty::assign('manifestation',$manifestation);
        // 分类
        $category =Data_Mysql_Table_Winchance_Fields::getContent('分类');
        Tpl_Smarty::assign('category',$category);
        //  来源国家
        $country =Data_Mysql_Table_Winchance_Fields::getContent('来源国家');
        Tpl_Smarty::assign('country',$country);
        //合作模式
        $cooperating_mode =Data_Mysql_Table_Winchance_Fields::getContent('合作模式');
        Tpl_Smarty::assign('cooperating_mode',$cooperating_mode);
        // 合作阶段
        $step = Data_Mysql_Table_Winchance_New::$step;
        Tpl_Smarty::assign('step',$step);
        // 负责人
        $admin = Data_Mysql_Table_Winchance_Order::getTeamUserList();
        Tpl_Smarty::assign('admin',$admin);
        /*
         * 获取模板必要数据------结束
         * */
        $isManager = self::is_manager();
        Tpl_Smarty::assign('is_manager',$isManager);
        // 获取操作人ID
        @session_start();
        if(!empty($_SESSION['administrator']['id'])){
            $operator_id = $_SESSION['administrator']['id'];
            Tpl_Smarty::assign('operator_id',$operator_id);
        }

        // IP数据列表数据
        $data = Api_Winchance_New_Ip_List::ipList();
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display("OA_Static::winchance_new/winchance_list.tpl");
    }
    static function winchanceEdit(){
        /*
        * 获取模板必要数据------开始
        * */
        $step = empty($_REQUEST['step'])?'1':$_REQUEST['step'];
        Tpl_Smarty::assign('step',$step);
        // 运营范围
        $city =Data_Mysql_Table_Winchance_Fields::getContent('运营范围');
        Tpl_Smarty::assign('city',$city);
        // 表现形式
        $manifestation =Data_Mysql_Table_Winchance_Fields::getContent('表现形式');
        Tpl_Smarty::assign('manifestation',$manifestation);
        // 分类
        $category =Data_Mysql_Table_Winchance_Fields::getContent('分类');
        Tpl_Smarty::assign('category',$category);
        //  来源国家
        $country =Data_Mysql_Table_Winchance_Fields::getContent('来源国家');
        Tpl_Smarty::assign('country',$country);
        //合作模式
        $cooperating_mode =Data_Mysql_Table_Winchance_Fields::getContent('合作模式');
        Tpl_Smarty::assign('cooperating_mode',$cooperating_mode);
        /*
         * 获取模板必要数据------结束
         * */

        // IP详情数据
        if(!empty($_REQUEST['id']) || !empty($_REQUEST['check_id'])){
            $detail = Api_Winchance_New_Ip_Detail::detail();
            Tpl_Smarty::assign('data',$detail[0]);
        }
        Tpl_Smarty::display("OA_Static::winchance_new/winchance_edit.tpl");
    }

    static function winchanceSubmit(){
         Api_Winchance_New_Ip_Submit::ipSubmit();
//        if($res['status']==1){
//            Func_Header::to('   操作成功！',"?action=list&ip_type=waiting");
//        }else{
//            Func_Header::back($res['msg']);
//        }
    }
    static function winchanceDelete(){
        Core::output('');
        $request = Func_Input::filter(array(
            'id'=>'int',
            'check_id'=>'int',
        ),$_REQUEST);
        if(empty($request['id']) && empty($request['check_id'])){
            Func_Output::json('error','','ID异常！');
        }
        if(!empty($request['id'])){
            $res = Data_Mysql_Table_Winchance_New::update(array('id'=>$request['id']),array('status'=>-1));
        }
        if(!empty($res[0]) || !empty($request['check_id'])){
            if(!empty($request['check_id'])){
                Data_Mysql_Table_Winchance_Check::update(array('id'=>$request['check_id']),array('status'=>-2));

            }else{
                Data_Mysql_Table_Winchance_Check::update(array('ip_id'=>$request['id']),array('status'=>-2));
            }
            Func_Output::json('success','','操作成功！');
        }else{
            Func_Output::json('error','','操作失败！');
        }
    }

    static function is_manager(){
        $yun_principal = Data_Mysql_Table_Winchance_Order::getTeamUserList();
        if(in_array($_SESSION['administrator']['id'],array_keys($yun_principal))){
            $admin_auth_info = $yun_principal[$_SESSION['administrator']['id']];
            if($admin_auth_info['auth']==0){
                return false;
            }else{
                return true;
            }
        }else{
            return false;
        }
    }
}