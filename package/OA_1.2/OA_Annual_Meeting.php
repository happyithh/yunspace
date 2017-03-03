<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/9
 * Time: 14:38
 */
@session_start();
class OA_Annual_Meeting {

    static function handle(){
        $type = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];

        switch ($type) {
            case 'list':
                self::handleList();
                break;
            case 'add':
                self::handleAdd();
                break;
            case 'edit':
                self::handleAdd();
                break;
            case 'submit_edit':
                self::handleSubmit();
                break;
            case 'category_list':
                self::categoryList();
                break;
            case 'category_add':
                self::categoryAdd();
                break;
            case 'category_edit':
                self::categoryAdd();
                break;
            case 'category_submit':
                self::categorySubmit();
                break;
            default:
                self::handleList();
                break;
        }
    }

    static function handleList(){
        $conditions = array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'id' => 'int',
                'category' => 'string',
                'city' => 'string',
                'space_name' => 'string',
                'item_name' => 'string',
                'status' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
            ), $_REQUEST['search']);
            if($search['id']&&is_numeric($search['id'])){
                $conditions['id=?'] = $search['id'];
            }
            if (!empty($search['category'])){
                $conditions['category=?'] = $search['category'];
            }
            if (!empty($search['city'])){
                $conditions['city=?'] = $search['city'];
            }
            $search['space_name']= trim($search['space_name']);
            if (!empty($search['space_name'])){
                $conditions[] = "space_name like '".$search['space_name']."%'";
            }
            $search['item_name']= trim($search['item_name']);
            if (!empty($search['item_name'])){
                $conditions[] = "item_name like '".$search['item_name']."%'";
            }
            if ($search['status']!='all'){
                $conditions['status=?'] = $search['status'];
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:01'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time'].'23:59:59');
            }
            Tpl_Smarty::assign('search', $search);
        }
//        q($conditions);
//        $status = isset($_REQUEST['status']) ? $_REQUEST['status'] : 1;
//        Tpl_Smarty::assign('status', $status);
//        $conditions['status=?'] = $status;
        $list = Data_Mysql_Table_Annual_Meeting::page(0, 10, "id,space_name,item_name,city,category,status,create_time,start_time,end_time", $conditions, 'ORDER BY update_time DESC');
        foreach($list['rows'] as $k=>$v){
            $list['rows'][$k]['status']=$v['status']==1?'上线':'下线';
//            $num = mb_strlen($v['title']);
//            if($num>=20){
//                $list['rows'][$k]['title'] = mb_substr($v['title'],0,20,"utf-8")."...";
//            }
//            $list['rows'][$k]['url_id'] = Func_NumEncode::e($v['id'].'9528');
        }
        $category_list =Data_Mysql_Table_Annual_Meeting_Category::select('id,category',array('status=?'=>1),'order by create_time desc',30);
        Tpl_Smarty::assign('category_list', $category_list);
        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::display('OA_Static::website/meeting/meeting_list.tpl');
    }

    static function handleAdd(){
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        if (!empty($request['id'])) {
            $info = Data_Mysql_Table_Annual_Meeting::select('*', array('id =?' => $request['id']), '', 1);
            if($info){
                $info_data = $info[0];
                $info_data['info_img'] = json_decode($info_data['info_img'],1);
                $info_data['space_item_name'] = $info_data['space_name']."-".$info_data['item_name'];
                Tpl_Smarty::assign('info', $info_data);
            }else{
                Func_Header::back('异常请求');
            }
        }
        $category_list =Data_Mysql_Table_Annual_Meeting_Category::select('id,category',array('status=?'=>1),'order by create_time desc',30);
        Tpl_Smarty::assign('category_list', $category_list);
        Tpl_Smarty::display('OA_Static::website/meeting/meeting_add.tpl');
    }
    static function handleEdit(){
        Tpl_Smarty::display('OA_Static::website/meeting/meeting_add.tpl');
    }
    static function handleSubmit(){
        $request = Func_Input::filter(array(
            'tid' => 'int',
            'item_id' => 'int',
            'space_item_name' => 'string',
            'space_info' => 'string',
            'category' => 'string',
            'status' => 'int',
            'start_time' => 'string',
            'end_time' => 'string',
            'old_price' => 'string',
            'new_price' => 'string',
            'remarks' => 'string',
            'start_seat' => 'int',
            'max_seat' => 'int',
            'space_des' => 'html',
            'annual_des' => 'html',
            'book_des' => 'html',
            'list_img'=>'string',
            'recommend_img'=>'string',
            'info_img' => 'array',
        ), $_REQUEST);
        $files = Func_Input::filter(array(
            'list_img_upload' => 'array',
            'recommend_img_upload' => 'array',
        ), $_FILES);
        if (!empty($files['list_img_upload']['name'])) {
            $list_img_upload = Func_Upload::image('list_img_upload');
            if (!empty($list_img_upload)) {
                $request['list_img'] = $list_img_upload;
            }
        }
        if (!empty($files['recommend_img_upload']['name'])) {
            $recommend_img_upload = Func_Upload::image('recommend_img_upload');
            if (!empty($recommend_img_upload)) {
                $request['recommend_img'] = $recommend_img_upload;
            }
        }
        if(!empty($request['info_img'])){
            unset($request['info_img']['$$']);
            $request['info_img'] = $request['info_img'];
        }
        //获取城市 地理位置 地址
        $request['space_item_name'] = explode('-',$request['space_item_name']);
        if(empty($request['space_item_name'][0])||empty($request['space_item_name'][1])){
            Func_Header::back('请选择场地空间');
        }
        if(empty($request['space_info'])){
            Func_Header::back('请选择场地空间介绍！！！');
        }
        $data['space_name'] =$request['space_item_name'][0];
        $data['item_name'] =$request['space_item_name'][1];
        $data['space_info'] = $request['space_info'];
        $data['category'] = $request['category'];
        $data['status'] = $request['status'];
        $data['start_time'] = $request['start_time'];
        $data['end_time'] = $request['end_time'];
        $data['old_price'] = $request['old_price'];
        $data['new_price'] = $request['new_price'];
        $data['remarks'] = $request['remarks'];
        $data['start_seat'] = $request['start_seat'];
        $data['max_seat'] = $request['max_seat'];
        $data['space_des'] = $request['space_des'];
        $data['annual_des'] = $request['annual_des'];
        $data['book_des'] = $request['book_des'];
        $data['list_img'] = $request['list_img'];
        $data['recommend_img'] = $request['recommend_img'];
        $data['info_img'] = $request['info_img'];
        $data['update_time'] =time();
        $data['admin_id'] =$_SESSION['administrator']['id'];
        $data['admin_name'] =$_SESSION['administrator']['username'];
        $condition_space_item = array(
            't1.space_name=?'=>$data['space_name'],
            't2.item_name=?'=>$data['item_name'],
        );
        $tables = "{table} as t1 left join {prefix}space_item as t2 ON t1.id=t2.space_id";
        $space_info = Data_Mysql_Table_Spacepedia::select('t1.id,t1.city,t1.addr,t1.geo_lat,t1.geo_lng,t2.size,t2.is_outside',$condition_space_item,'',1,$tables);
        $data['city'] =$space_info[0]['city'];
        $data['geo_lat'] =$space_info[0]['geo_lat'];
        $data['geo_lng'] =$space_info[0]['geo_lng'];
        $data['addr'] =$space_info[0]['addr'];
        $data['area'] =$space_info[0]['size'];
        $data['is_outside'] =$space_info[0]['is_outside'];
//        Q($data);
        if(empty($request['tid'])){
            $msg = '添加';
//            $condition_space_item = array(
//                't1.space_name=?'=>$data['space_name'],
//                't2.item_name=?'=>$data['item_name'],
//            );
//            $tables = "{table} as t1 left join {prefix}space_item as t2 IN t1.id=t2.space_id";
//            $space_info = Data_Mysql_Table_Spacepedia::select('t1.id,t1.city,t1.addr,t1.geo_lat,t1.geo_lng,t2.size',$condition_space_item,'',1,$tables);
//            Q($space_info);
//            $data['city'] =$space_info[0]['city'];
//            $data['geo_lat'] =$space_info[0]['geo_lat'];
//            $data['geo_lng'] =$space_info[0]['geo_lng'];
//            $data['addr'] =$space_info[0]['addr'];
//            $data['city'] =$space_info[0]['city'];
            $data['create_time'] =time();
            $rs =  Data_Mysql_Table_Annual_Meeting::insert($data);
        }else{
            $msg = '修改';
            $rs =  Data_Mysql_Table_Annual_Meeting::update(array('id=?'=>$request['tid']),$data);
        }
        if(!empty($rs[0])){
           Func_Header::to($msg.'成功','?action=list');
        }else{
            Func_Header::back($msg.'操作失败');
        }
    }


    static function categoryList(){
        $conditions = array();
//        $status = isset($_REQUEST['status']) ? $_REQUEST['status'] : 1;
//        Tpl_Smarty::assign('status', $status);
//        $conditions['status'] = $status;
        $list = Data_Mysql_Table_Annual_Meeting_Category::page(0, 10, "*", $conditions, 'ORDER BY update_time DESC');
        if($list){
            foreach($list['rows'] as $k=>$v){
                $list['rows'][$k]['status']=$v['status']==1?'上线':'下线';
            }
        }
        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::display("OA_Static::website/meeting/category_list.tpl");
    }

    static function categoryAdd(){
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        if (!empty($request['id'])) {
            $info = Data_Mysql_Table_Annual_Meeting_Category::select('*', array('id =?' => $request['id']), '', 1);
            Tpl_Smarty::assign('info', $info[0]);
        }
        Tpl_Smarty::display('OA_Static::website/meeting/category_add.tpl');
    }

    static function categorySubmit(){
        $request = Func_Input::filter(array(
            'cid' => 'int',
            'category' => 'string',                       //分类名称
            'des' => 'string',             //类别图片
            'status' => 'int',               //0下线   1上线
        ),$_REQUEST);
//        if(!empty($request['big_picture'])){
//            Func_Image::thumCenterImage(Core::$paths['root'].$request['big_picture'], Core::$paths['root'].$request['big_picture'], 450, 150);
//        }
        if(empty($request['category'])){
            Func_Header::back('分类名不能为空！');
        }
        $data['category'] = $request['category'];
        $data['des'] = $request['des'];
        $data['status'] = $request['status'];
        $data['update_time'] = time();
        if (!empty($request['cid'])) {
            $data['id'] = $request['cid'];
        } else {
            $data['create_time'] = time();
        }
        $rows = Data_Mysql_Table_Annual_Meeting_Category::update($data);
        if ($rows > 0) {
            Func_Header::to(' 操作成功！','?action=category_list');
        } else {
            Func_Header::back('操作失败！');
        }
    }

} 