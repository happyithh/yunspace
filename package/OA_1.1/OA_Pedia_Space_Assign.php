<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/12/10
 * Time: 16:25
 */

class OA_Pedia_Space_Assign
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($action) {
            case "list":
                self::getAssignList();
                break;
            case "delete":
                self::deleteAssign();
                break;
            case "detail":
                self::detailAssign();
                break;
            case "edit":
                self::editAssign();
                break;
            case "submit":
                self::submitAssign();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }


    static function getAssignList() {


        $conditions=array();
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'phone' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
            ),$_REQUEST['search']);

            //百科名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
//                    $conditions['{table}.id = ?'] = $search['title'];
                    $conditions['{prefix}spacepedia.id = ?'] = $search['title'];
                } else {
                    $conditions['{prefix}spacepedia.space_name = ?'] =$search['title'];
                }
            }

            //授权时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:00'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time'].'23:59:59');
            }

            //授权手机筛选
            if (!empty($search['phone'])) {
                $conditions['{table}.phone = ?'] = $search['phone'];
            }
        }
//        $order = 'GROUP BY {prefix}spacepedia.space_name ORDER BY {table}.create_time DESC';
        $order = 'ORDER BY {table}.create_time DESC';
        $data = Data_Mysql_Table_Space_Assign::page(0,10,'{table}.id,{table}.phone,{table}.create_time,{prefix}spacepedia.space_name',$conditions,$order,'{table} LEFT JOIN {prefix}spacepedia ON {table}.space_pedia_id={prefix}spacepedia.id');
//        q($data);
        Tpl_Smarty::assign("_data",$data);
        Tpl_Smarty::display("OA_Static","spacepedia/pedia_space_assign_list.tpl");
    }



    static function submitAssign() {
//        q($_REQUEST['data']);
        if(!empty($_REQUEST['data'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'space_item_id' => 'array',
                'phone' => 'string',
                'pedia_assign_status' => 'int',
            ), $_REQUEST['data']);

            if(empty($request['phone'])) {
                Func_Header::back('请输入要授权的手机号！');
            }
            if(!empty($request['space_pedia_id'])) {
                $request['pedia_assign_status'] = 1;
            } else {
                $request['pedia_assign_status'] = 2;
                $request['space_pedia_id'] = $_REQUEST['space_id'];
            }
//            q($request);
            $rs = Data_Mysql_Table_Space_Assign::select('id',array('space_pedia_id'=>$request['space_pedia_id'],'phone'=>$request['phone']));
            if(empty($rs[0])) {
                $result = Data_Mysql_Table_Space_Assign::insert($request);
            } else {
                $result = Data_Mysql_Table_Space_Assign::update(array('id'=>$rs[0]['id']),$request);
            }
//            q($result);
            if(!empty($result[0])) {
                Func_Header::to(' 修改成功！',Core::$urls['path']);
            }
            Func_Header::back('修改失败，请重试！');
        }
    }


    static function deleteAssign() {
        $request['id'] = $_REQUEST['id'];
        $rs = Data_Mysql_Table_Space_Assign::delete(array('id'=>$request['id']));
        if($rs) {
            Func_Header::to(' 删除成功！',Core::$urls['path']);
        }
        Func_Header::back('删除失败！');
    }


    static function editAssign() {
        $conditions = array();
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数缺失！！');
        }
        $request['id'] = $_REQUEST['id'];
        $result = Data_Mysql_Table_Space_Assign::select('space_pedia_id,pedia_assign_status,space_item_id,phone',array('id'=>$request['id']));
        $result[0]['space_item_id'] = json_decode($result[0]['space_item_id'],1);
        $conditions['{table}.space_id = ?'] = $result[0]['space_pedia_id'];
        $rs = Data_Mysql_Table_Space_Item::select('{table}.id,{table}.status,item_name,{prefix}spacepedia.id as space_id,{prefix}spacepedia.space_name',$conditions,'',10,'{table} LEFT JOIN {prefix}spacepedia ON {prefix}spacepedia.id={table}.space_id');
        Tpl_Smarty::assign('phone',$result[0]['phone']);
        Tpl_Smarty::assign('space_item_id',$result[0]['space_item_id']);
        Tpl_Smarty::assign('status',$result[0]['pedia_assign_status']);
        Tpl_Smarty::assign('space_id',$result[0]['space_pedia_id']);
        Tpl_Smarty::assign('data',$rs);
        Tpl_Smarty::display("OA_Static","spacepedia/spacepedia_assign.tpl");

    }

    static function detailAssign() {
        $request['id'] = $_REQUEST['id'];
        $conditions = $item_name = array();
        $conditions['{table}.id = ?'] = $request['id'];
//        Data_Mysql_Table_Space_Assign::debug(1);
        $data = Data_Mysql_Table_Space_Assign::select('{table}.id,{table}.phone,{table}.space_item_id,{table}.create_time,{prefix}spacepedia.space_name',$conditions,'',1,'{table} LEFT JOIN {prefix}spacepedia ON {table}.space_pedia_id={prefix}spacepedia.id');
        $data[0]['space_item_id'] = json_decode($data[0]['space_item_id'],1);
        if(!empty($data[0]['space_item_id'])) {
            foreach($data[0]['space_item_id'] as $k=>$v) {
                $rs = Data_Mysql_Table_Space_Item::select('item_name',array('id'=>$v),'',1);
                $item_name[] = $rs[0]['item_name'];
            }
        }
//        q($item_name);
//        foreach($data)
//        q($data);
        Tpl_Smarty::assign('item_name',$item_name);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display("OA_Static","spacepedia/pedia_space_assign_detail.tpl");
    }

}