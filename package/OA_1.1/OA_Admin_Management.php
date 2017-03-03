<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-8-3
 * Time: 下午2:07
 * 创建管理员
 */
class OA_Admin_Management
{
    static function handle()
    {
        $department=Data_Mysql_Table_Department::getAllDepartmentName();
        Tpl_Smarty::assign('department',$department);
        $_REQUEST['action']=empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'list':
                self::getAdminList();
                break;
            case "detail":
                self::handleAdminInfo();
                break;
            case "add_admin_submit":
                self::handleAdminInfoSubmit();
                break;
            case "delete_admin":
                self::handleDeleteAdmin();
                break;
//            case "change_admin_session":
//                self::changeAdminSession();
//                break;
            case "recovery":
                self::recoveryAdminInfo();
                break;
            case "pass":
                self::passAdmin();
                break;
            case "add_department":
                self::addDepartment();
                break;
            case "remove_department":
                self::removeDepartment();
                break;
            case "integral_list":
                self::handleIntegralList();
                break;
            default:
                self::getAdminList();
                break;
        }
    }
    //获取管理员列表
    static function getAdminList(){
        $condition=array();
        $_REQUEST['handle_type']=empty($_REQUEST['handle_type'])?'normal':$_REQUEST['handle_type'];
        if(!empty($_REQUEST['search'])){
            $request=Func_Input::filter(array(
                'username'=>'string',
                'fullname'=>'string',
                'position'=>'string',
                'city'=>'string',
                'phone'=>'string',
                'team_name'=>'string',
                'department_name'=>'string'
            ),$_REQUEST['search']);
            if(!empty($request['username'])){
                $condition[]='({table}.username like "%'.$request['username'].'%" OR {table}.fullname like "%'.$request['username'].'%")';
            }
            if(!empty($_REQUEST['search']['phone']) && empty($request['phone'])){
                Func_Header::back("请输入正确的手机号！");
            }
            if(!empty($request['phone'])){
                $condition['{table}.phone = ?']=$request['phone'];
            }
            if(!empty($request['position'])){
                $condition['{prefix}department_member.position = ?']=$request['position'];
            }
            if(!empty($request['team_name'])){
                $condition['{prefix}department_member.team_name = ?']=$request['team_name'];
            }
            if(!empty($request['department_name'])){
                $condition['{prefix}department_member.department_name = ?']=$request['department_name'];
            }
            if(!empty($request['city'])){
                $condition['{prefix}department_member.city = ?']=$request['city'];
            }
        }
        switch($_REQUEST['handle_type']){
            case 'waiting':
                $condition['{table}.status = ?']=0;
                break;
            case 'normal':
                $condition['{table}.status = ?']=1;
                break;
//            case 'stop':
//                $condition['{table}.status = ?']=98;
//                break;
            case 'recycle':
                $condition['({table}.status = ?  OR {table}.status = ?)']=array(99,98);
                break;
            default:
                break;
        }
        $admin_list=Api_Administrator_List::getAdminList($condition);
        if (!empty($request)) {
            $searchKey = array_keys($request);
            $searchVal = array_values($request);
            $searchnum = count($request);
            $urls='';
            for($i=0;$i<$searchnum;$i++){
                $urls .= 'search['.$searchKey[$i].']='.$searchVal[$i].'&';
            }
            Tpl_Smarty::assign('urls', $urls);
        }
        Tpl_Smarty::assign('_data',$admin_list);
        Tpl_Smarty::display('OA_Static','admin/admin_list.tpl');
    }
    static $teamType = array(
        // '市场部' => array(
        //     '商家成长',
        //     '供应商拓展',
        //     '空间拓展',
        // ),
        // '拓展部' => array(
        //     '商家成长',
        //     '供应商拓展',
        //     '空间拓展',
        // ),
        '销售部' => array(
            'KA',
            '标准',
        ),
    );

    //修改和添加管理员
    static function handleAdminInfo(){
        if(!empty($_REQUEST['admin_id'])){
            $adminInfo=Api_Administrator_List::getAdminInfo($_REQUEST['admin_id'],$_REQUEST['department_name']);
            if(empty($adminInfo)){
                Func_Header::back('数据不存在！！');
            }
            if(!empty($adminInfo['role_ids'])){
                $adminInfo['role_ids'] = array_fill_keys(explode('|',$adminInfo['role_ids']), 1);
                $adminInfo['role_urls'] = json_decode($adminInfo['role_urls'], 1);
            }
            if(!empty($adminInfo['team_name'])){
                $temp_arr=explode("-",$adminInfo['team_name']);
                $adminInfo['is_ka'] = $temp_arr[0];
                $adminInfo['team_name'] = empty($temp_arr[1])?$temp_arr[0]:$temp_arr[1];
            }
            Tpl_Smarty::assign('_data',$adminInfo);
        }
        Tpl_Smarty::assign('teams', self::$teamType);
        Tpl_Smarty::assign('roles', Data_Mysql_Table_Admin_Role::getInstance()->___allRole);
        Tpl_Smarty::display('OA_Static','admin/admin_detail.tpl');
    }

    //增加或修改管理员信息提交
    static function handleAdminInfoSubmit(){
        $request=Func_Input::filter(array(
            'handle_type'=>'string',
            'username'=>'string',
            'fullname'=>'string',
            'password'=>'string',
            'position'=>'string',
            'level'=>'int', //0 普通  1主管
            'city'=>'string',
            'is_ka'=>'string',
            'team_name'=>'string',
            'department_name'=>'string',
            'old_department_name'=>'string',
            'phone'=>'phone',
            'email'=>'email',
            'admin_id'=>'int',
            'role_ids'=>'array',
        ),$_REQUEST['data']);
        if((!empty($_REQUEST['data']['phone']) &&  empty($request['phone']))){
            Func_Header::back('请输入正确的手机号！');
        }
        if(empty($request['email'])){
            Func_Header::back('请输入正确的邮箱！');
        }
        if(empty($request['username']) || empty($request['fullname'])){
            Func_Header::back('管理员名称和昵称不能为空！！');
        }
        if($request['level']==1){
            $request['position']='主管';
        }else{
            $request['position']='普通';
        }


        //管理员信息
        $admin_data['username']=$request['username'];
        $admin_data['phone']=$request['phone'];
        $admin_data['fullname']=$request['fullname'];
        $admin_data['email']=$request['email'];
        if(!empty($request['password'])){
            $admin_data['password']=Data_Mysql_Table_Administrator::makePassword($request['password']);
        }
        if(!empty($request['role_ids'])){
            Data_Mysql_Table_Administrator::exec("UPDATE {table} SET role_cache = '' WHERE 1");
        }
        $admin_data['role_ids']=implode('|',$request['role_ids']);
        //部门管理的信息
        $department_data['department_name']=$request['department_name'];
        if (!empty($request['is_ka'])) {
            $request['team_name'] = $request['is_ka'] . ($request['team_name'] ? ("-" . $request['team_name']) : '');
        } else {
            $request['team_name'] = '无' . ($request['team_name'] ? ("-" . $request['team_name']) : '');
        }
        $department_data['team_name']=$request['team_name'];
        $department_data['city']=$request['city'];
        $department_data['level']=$request['level'];
        $department_data['position']=$request['position'];
        if(empty($request['admin_id'])){
            $admin_data['register_time']=time();
            $admin_data['password']=Data_Mysql_Table_Administrator::makePassword('111111');
            $admin_data['status']=0;
            $rs=Data_Mysql_Table_Administrator::insert($admin_data);

            if(empty($rs[0])){
                Func_Header::back('创建/修改管理员失败，可能是用户名或邮箱已存在，请修改重试！！');
            }else{
                $department_data['admin_id']=$rs[0];
            }
        }else{
            $rs=Data_Mysql_Table_Administrator::update(array('id'=>$request['admin_id']),$admin_data);
            $department_data['admin_id']=$request['admin_id'];
        }

        if(!empty($request['admin_id']) && !empty($request['old_department_name'])){
            $department_data['reset_time']=time();
//            $rs_d=Data_Mysql_Table_Department_Member::update(array('admin_id'=>$request['admin_id'],'department_name'=>$request['old_department_name']),$department_data);
        }else{
//            $rs_d=Data_Mysql_Table_Department_Member::insert($department_data);

        }
        $rs_d=Data_Mysql_Table_Department_Member::update($department_data);
//
//        $condition_d['admin_id']=$department_data['admin_id'];
//        $condition_d['(department_name = ? OR department_name = ?)']=array($department_data['department_name'],'');
//        $department=Data_Mysql_Table_Department_Member::select('id',$condition_d);
//        if(!empty($department[0])){
//            $department_data['reset_time']=time();
//            $rs_d=Data_Mysql_Table_Department_Member::update($department[0]['id'],$department_data);
//        }else{
//            $rs_d=Data_Mysql_Table_Department_Member::insert($department_data);
//        }
        if(empty($rs_d[0])){
            Func_Header::back('管理员部门信息更新失败！！');
        }else{
            Func_Header::to(' 管理员信息添加成功！！','?handle_type='.$request['handle_type']);
        }

    }

    //删除管理员的部门信息
    static function handleDeleteAdmin(){
        if(empty($_REQUEST['admin_id'])){
            Func_Header::back('参数错误！！');
        }
        //删除管理员
        if(empty($_REQUEST['department_name'])){
            $rs=Data_Mysql_Table_Administrator::update(array('id'=>$_REQUEST['admin_id']),array('status'=>99));
            $msg="已将该管理员放入回收站";
        }else{
            $rs=Data_Mysql_Table_Department_Member::delete(array('admin_id'=>$_REQUEST['admin_id'],'department_name'=>$_REQUEST['department_name']));
            $msg="已将该管理员从".$_REQUEST['department_name'].'删除!';
        }
        if(!empty($rs[0])){
           Func_Header::to(' '.$msg,'?');
        }else{
            Func_Header::back('管理员删除失败！！');
        }
    }
    //恢复管理员
    static function recoveryAdminInfo(){
        if(empty($_REQUEST['admin_id'])){
            Func_Header::back('参数错误！！');
        }
        $rs=Data_Mysql_Table_Administrator::update(array('id'=>$_REQUEST['admin_id']),array('status'=>1));
        if(!empty($rs[0])){
            Func_Header::to(' 已经该管理员恢复正常','?');
        }else{
            Func_Header::back('管理员恢复失败！！');
        }
    }
    //管理员审核通过
    static function passAdmin(){
        if(empty($_REQUEST['admin_id'])){
            Func_Header::back('参数错误！！');
        }
        $rs=Data_Mysql_Table_Administrator::update(array('id'=>$_REQUEST['admin_id']),array('status'=>1));
        if(!empty($rs[0])){
            Func_Header::to(' 该管理员已审核通过','?');
        }else{
            Func_Header::back('管理员审核失败！！');
        }
    }
   //添加部门名称
    static function addDepartment(){
        $request=Func_Input::filter(array(
            "department_name"=>"string",
        ));
        if(empty($request['department_name'])){
            Func_Header::back("部门名称不能为空!");
        }
        $rs=Data_Mysql_Table_Department::insert($request);
        if(empty($rs[0])){
            Func_Header::back("添加部门失败，可能是由于部门已经存在！！");
        }else{
            Func_Header::to(" 部门添加成功！！","?");
        }
    }
    //移除部门
    static function removeDepartment(){
        $request=Func_Input::filter(array(
            "remove_department_name"=>"string",
            "replace_department_name"=>"string",
        ));
        if(empty($request['remove_department_name']) || empty($request['replace_department_name'])){
            Func_Header::back("要移除和替换的部门名称不能为空!");
        }

        //删除部门名称
        $rs=Data_Mysql_Table_Department::delete(array("department_name"=>$request['remove_department_name']));
        if(empty($rs[0])){
            Func_Header::back("删除部门失败");
        }else{
            //将原有部门管理中的管理员移到替换的部门下面
            Data_Mysql_Table_Department_Member::query("UPDATE IGNORE {table} SET department_name = ? WHERE department_name= ?",array($request['replace_department_name'],$request['remove_department_name']));
            Func_Header::to(" 部门移除成功！！","?");
        }
    }

    //变身
    static function changeAdminSession(){
        $request = Func_Input::filter(
            array(
                'admin_id'=>'int',
            ),$_REQUEST);
        if(empty($request['admin_id'])){
            Func_Header::back('参数错误！！');
        }
        $rs = Data_Mysql_Table_Administrator::select("*", array('id=?'=>$request['admin_id']));
        if (empty($rs[0]['id'])) {
            Func_Header::back('Account does not exist!');
        }
        unset($_SESSION['administrator']['role_cache']);
        $_SESSION['administrator']['role_cache'] = self::_getRoleCache($rs[0]);
        $_SESSION['administrator']['is_change_session_role'] = 1;
        Func_Header::to(" 变身成功！！","");
    }

    static  function _getRoleCache($user)
    {
        if (empty($user['role_ids']) && empty($user['role_urls'])) {
            return array();
        }
        if (!empty($user['role_cache'])) {
            return json_decode($user['role_cache'], 1);
        }
        $roleCache = empty($user['role_urls']) ? array() : json_decode($user['role_urls'], 1);
        if (!empty($user['role_ids'])) {
            $roleIds = Func_Input::filterIds(explode('|', $user['role_ids']));
            if (!empty($roleIds)) {
                $rs = Data_Mysql_Table_Admin_Role::select('id, role_urls', array("id in (" . implode(',', $roleIds) . ")", 'status' => 0), '', 100);
                if ($rs) {
                    foreach ($rs as $v) {
                        $v['role_urls'] = json_decode($v['role_urls'], 1);
                        foreach ($v['role_urls'] as $vk => $vv) {
                            if (empty($roleCache[$vk])) {
                                $roleCache[$vk] = $vv;
                            } else {
                                $roleCache[$vk] += $vv;
                            }
                        }
                    }
                }
            }
        }
        return $roleCache;
    }
/**积分列表*/
    static function handleIntegralList(){
        $request = Func_Input::filter(
            array(
                'account_id'=>'int',
                'search'=>'array',
            ),$_REQUEST);
        $condition=array();
        if(!empty($request['account_id'])){
            $condition['t1.account_id =?']=$request['account_id'];
        }
        if(!empty($request['search'])){
            $search = Func_Input::filter(array(
                'start_time'=>'string',
                'end_time'=>'string',
                'integral' =>'int',
                'fullname' =>'string',
            ),$request['search']);
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $condition['t1.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $condition['t1.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $condition['t1.create_time < ?'] = strtotime($search['end_time']);
            }
            if($search['integral']){
                $condition['t1.integral =?'] =$search['integral'];
            }
            if($search['fullname']){
                $condition['t2.fullname like ?'] ='%'.$search["fullname"].'%';
            }
        }
        $table="{table} as t1 LEFT JOIN {prefix}account as t2 ON t1.account_id =t2.id";
     //  Data_Mysql_Table_Integral_Record::debug(1);
        $rs =Data_Mysql_Table_Integral_Record::page(0,15,'t1.*,t2.fullname',$condition,'order by t1.create_time DESC',$table);
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::display('OA_Static','integral_list.v1.0/integral_list.tpl');
    }
}