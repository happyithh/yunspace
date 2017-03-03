<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */
switch (Core::$urls['action']) {
    case 'category':
        Admin_Data_Table::quick(Data_Mysql_Table_Event_Category::subTable());
        break;
    case 'tags':
        Admin_Data_Table::quick(Data_Mysql_Table_Tags::subTable('_event'));
        break;
    case 'list':
        OA_Event::handle();
        break;
    case 'case':
        Admin_Data_Table::quick(Data_Mysql_Table_Event_Case::subTable());
        break;
    case 'history':
        Admin_Data_Table::quick(Data_Mysql_Table_History::subTable('_event' . date("_Ym")));
        break;
    case 'search':
        die("Coming soon!");
        break;
    case 'static':
        Admin_Data_Table::quick(Data_Mysql_Table_Static::subTable('_event' . date("_Ym")));
        break;
    case 'brand':       //活动品牌
        OA_Event_Brand::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}

class Event_Info
{
    static function handleEventList()
    {
        $conditions = array(
            "status" => 1
        );
        $data = Data_Mysql_Table_Event_Info::page(0, 10, 'id,event_name,event_time,addr,attr,des', $conditions, 'ORDER BY id DESC');
        foreach ($data['rows'] as $k => &$v) {
            $v['attr'] = json_decode($v['attr'], true);
            $v['event_time'] = date('Y-m-d H:i:s', $v['event_time']);
        }
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display("B2B_Admin", "event_info_list.tpl");
    }

    static function handleEdit()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
            'ids' => 'array'
        ));
        if (!$request['action']) {
            die("参数错误！！");
        }
        if (!$request['ids']) {
            die("参数错误！！");
        }
        $conditions = array(
            'id' => $request['ids'][0],
        );
        $data = Data_Mysql_Table_Event_Info::select('id,event_name,event_time,addr,attr,des,media,logo', $conditions);
        foreach ($data as $k => &$v) {
            $v['attr'] = json_decode($v['attr'], true);
            $v['event_time'] = date('Y-m-d H:i:s', $v['event_time']);
            $v['media'] = json_decode($v['media'], true);
        }
        Tpl_Smarty::assign('city', $_REQUEST['cities']);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display("B2B_Admin", "event_info_edit.tpl");
    }

    static function updateEvent()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'event_name' => 'string',
            'event_time' => 'string',
            'addr' => 'string',
            'attr' => 'array',
            'logo' => 'string'
        ));
        if (!$request['event_name']) {
            die('必须填写活动名称！！');
        }
        if (!$request['event_time']) {
            die('必须填写活动时间！！');
        }
        if (!$request['attr']) {
            die('标签不能为空！！');
        }
        if (!$request['addr']) {
            die('地址不能为空！！');
        }
        $conditions = array(
            'id' => $request['id']
        );
        $request['des'] = $_REQUEST['des'];
        $arr = explode(' ', $request['event_time']);
        $date = explode('-', $arr[0]);
        $str_time = mktime($arr[1], 0, 0, $date[1], $date[2], $date[0]);
        $request['event_time'] = $str_time;
        $request['update_time'] = time();
        $update = Data_Mysql_Table_Event_Info::update($conditions, $request);
        if ($update) {
            Func_Header::back('活动信息已更新！！');
        }
    }

    static function deleteEvent()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
            'ids' => 'array'
        ));
        if (!$request['action']) {
            die("参数错误！！");
        }
        if (!$request['ids']) {
            die("参数错误！！");
        }
        $conditions = array(
            'id' => $request['ids'][0]
        );
        $data = array(
            'status' => 99
        );
        $update = Data_Mysql_Table_Event_Info::update($conditions, $data);
        if ($update) {
            Func_Header::back('删除成功！！');
        }
    }

    static function stopEvent()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
            'ids' => 'array'
        ));
        if (!$request['action']) {
            die("参数错误！！");
        }
        if (!$request['ids']) {
            die("参数错误！！");
        }
        $conditions = array(
            'id' => $request['ids'][0]
        );
        $data = array(
            'status' => 98
        );
        $update = Data_Mysql_Table_Event_Info::update($conditions, $data);
        if ($update) {
            Func_Header::back('停用成功！！');
        }
    }
}