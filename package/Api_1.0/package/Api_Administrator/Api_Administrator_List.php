<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Administrator_List extends Api
{
    static function handle($args='')
    {
        //判断是否登录 //判断权限
        if(empty($_SESSION['administrator']['id'])){
            $result = self::request('error','',"没有登录");
            return $result;
        }
        //接受参数
        //department_name 部门（销售部，市场部）
        // level_name等级（总监，经理，组长，普通）
        // is_ka 组别  （无，KA，标准，测试
        //team_name 分组 （A组,B组,C组，D组）
        //city 城市 （上海，成都，广州，深圳，杭州等）
        //（组别和分组可以用KA-A组，标准-C组，无-B组，测试-D组）

        //返回结果：用户列表
        $result = self::getList($args);
        return $result;
    }
    //返回参数
    static function getList($data){
        $request = Func_Input::filter(array(
            'department_name' => 'string',
            'level_name'=>'string',
            'is_ka'=>'string',
            'team_name'=>'string',
            'city'=>'string',
        ),$data);
        if(empty($request['department_name'])){
            $result = self::request('error','',"部门名称不能为空");
            return $result;
        }
        $contions = array();
        $contions['department_name'] = $request['department_name'];
        $levelarr = array(
            "总监"=>1,
            "经理"=>2,
            "组长"=>3,
            "普通"=>0,
        );
        $request['level'] = !empty($request['level_name']) ? $levelarr[$request['level_name']] : 0;
        $contions['level'] =  $request['level'];
        if(!empty($request['city'])){
            $contions['city'] =  $request['city'];
        }
        if(!empty($request['is_ka']) && !empty($request['team_name']) ){
            $contions['team_name'] = $request['is_ka']."-".$request['team_name'];
        }
        $table = "{table}  left join {prefix}administrator on {table}.admin_id= {prefix}administrator.id";
        $cols = "{table} .*,{prefix}administrator.fullname,{prefix}administrator.email,{prefix}administrator.username,{prefix}administrator.phone";
        $list = Data_Mysql_Table_Department_Member::select($cols,$contions,'order by {table}.level desc',1000,$table);
        if(!empty($list)){
            foreach($list as $k=>$v){
                if(!empty($v['data'])){
                    $list[$k]['data'] = json_decode($v['data'],1);
                }
            }
            $result = self::request('success', $list, "返回成功");
        }else{
            $result = self::request('error', '', "返回成功");
        }
        return $result;
    }

    //返回管理员列表
    static function getAdminList($condition=array(),$no_page=0){
        $return=array();
        $table = "{table} left join {prefix}department_member on {table}.id= {prefix}department_member.admin_id";
        $cols = "{table} .*,{prefix}department_member.department_name,{prefix}department_member.team_name,{prefix}department_member.data,{prefix}department_member.position,{prefix}department_member.city,{prefix}department_member.level";
       if($no_page){
           $list = Data_Mysql_Table_Administrator::select($cols,$condition,'order by {table}.register_time desc',999999999,$table);
           if(!empty($list)){
               foreach($list as $k=>$v){
                   if(!empty($v['data'])){
                      $list[$k]['data'] = json_decode($v['data'],1);
                   }
                   $return[$v['id']]=$v;
               }
           }
       }else{
           $list = Data_Mysql_Table_Administrator::page(0,20,$cols,$condition,'order by {table}.register_time desc',$table);
           if(!empty($list['rows'])){
               foreach($list['rows'] as $k=>$v){
                   if(!empty($v['data'])){
                       $list['rows'][$v['id']]['data'] = json_decode($v['data'],1);
                   }
                   $return['rows'][$v['id']]=$v;
               }
           }
           $return['page']=$list['page'];

       }
        return $return;
    }

    //获取某个管理员和部门信息
    static function getAdminInfo($admin_id,$department_name=''){
        $adminInfo=array();
        if(empty($admin_id)){
            return false;
        }
        //获取管理员信息
        $admin_data=Data_Mysql_Table_Administrator::select('*',array('id'=>$admin_id));
        if(!empty($admin_data[0])){
            $adminInfo=$admin_data[0];
        }
        //获取该管理员的部门信息
        $department_data=Data_Mysql_Table_Department_Member::select('level,department_name,team_name,position,city as department_city',array('admin_id'=>$admin_id,'department_name'=>$department_name));
        if(!empty($department_data[0])){
            $adminInfo=array_merge($adminInfo,$department_data[0]);
        }
        return $adminInfo;
    }
}

