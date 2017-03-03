<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-1-4
 * Time: 下午5:06
 */
class OA_Baike_List{
    static function handle($cid=0){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getBaikeList($cid);
                break;
            case "add_spacepedia":
                OA_Spacepedia_Management::addSpacepedia();
                break;
            case "edit":
                self::editSpacepedia();
                break;
            case "edit_submit":
                self::editSubmitSpacepedia();
                break;
            case "case":
                Spacepedia_Case_Management::handle();
                break;
            case "assign":
                OA_Spacepedia_Management::assignSpacepedia();
                break;
            case "assign_submit":
                OA_Spacepedia_Management::submitAssignSpacepedia();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }
    static function getBaikeList($cid=0){
        $conditions=array();
//        $conditions['{table}.status = ? OR {table}.status = ?']=array(0,1);
        if($cid){
            $children=Data_Mysql_Table_Spacepedia::getChildren($cid);
            $children[]=$cid;
            $conditions[]='{table}.category_id in ('.implode(",",$children).')';
        }
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'city' => 'string',
                'level' => 'int',
                'end_time' => 'string',
                'start_time' => 'string',
                'create_time'=>'string',
            ),$_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['{table}.id = ?'] = $search['title'];
                } else {
                    $conditions['space_name'] =$search['title'];
                }
            }

            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.update_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:00'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.update_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.update_time < ?'] = strtotime($search['end_time'].'23:59:59');
            }

            //城市筛选
            if (!empty($search['city'])) {
                $conditions['{table}.city = ?'] = $search['city'];
            }

            //创建时间筛选
            if(!empty($search['create_time'])){
                $conditions['{table}.create_time >= ?'] =strtotime($search['create_time']);
            }
            //等级筛选
            if(isset($search['level']) &&  $search['level']!=100){
                $conditions['{table}.level= ?'] =$search['level'];
            }
        }
        $handle_type=empty($_REQUEST['handle_type'])?"all":$_REQUEST['handle_type'];
        switch($handle_type){
            case "online":
                $conditions['{table}.status = ?']=1;
                break;
            case "offline":
                $conditions['{table}.status = ?']=0;
                break;
            case "deleted":
                $conditions['{table}.status = ?']=-1;
                break;
            case "all":
                break;
        }
        $data=Api_Spacepedia_List_And_Info::getSpacepediaList($conditions);
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[city]='.$search['city'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[create_time]='.$search['create_time'];
            $data['other']['urls'] =  $sea_url;
        }
        $data['other']['handle_type'] =$handle_type;
        //获取场地百科分类
        $category = Data_Mysql_Table_Spacepedia::$category_name;
        if($cid){
            foreach($category as $k=>$v){
                if($v['id']==$cid || $v['parent']==$cid){
                    $categoryName[]=$v;
                }
            }
            Tpl_Smarty::assign('category_name', $categoryName);
        }else{
            Tpl_Smarty::assign('category_name', $category);

        }
        $history=$ids=array();
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k =>$v){
                $ids[] = $v['id'];
            }
            $contion[]='object_id IN (' . implode(',', $ids) . ')';
            $contion['status'] =0;
            $history = Data_Mysql_Table_History::subTable('_baike_'.date("Ym"))->select('object_id,status,create_time',$contion,'group by object_id order by create_time DESC',9999);
            if(empty($history)){
                $tmp_date=date("Ym");
                //切割出年份
                $tmp_year=substr($tmp_date,0,4);
                //切割出月份
                $tmp_mon =substr($tmp_date,4,2);
                $tmp_forwardmonth=date("Ym",mktime(0,0,0,$tmp_mon-1,1,$tmp_year));
                $history = Data_Mysql_Table_History::subTable('_baike_'.$tmp_forwardmonth)->select('object_id,status,create_time',$contion,'group by object_id order by create_time DESC',9999);
            }
        }
        //获取场地状态值
        $status = Data_Mysql_Table_Spacepedia::$status;
        Tpl_Smarty::assign("status",$status);

        Tpl_Smarty::assign("history",$history);
        Tpl_Smarty::assign("_data",$data);
        Tpl_Smarty::assign("level",Data_Mysql_Table_Spacepedia::$level);
        Tpl_Smarty::assign("is_admin", Admin_Authority::checkUrl('space/space_level', 0));
        Tpl_Smarty::display("OA_Static","baike/baike_list.tpl");
    }

    //百科编辑页面
    static function editSpacepedia(){
        if(empty($_REQUEST['space_id'])){
            Func_Header::back('参数缺失！！');
        }

        //获取场地百科分类
        $category = Data_Mysql_Table_Spacepedia::$category_name;
        $categoryInfo = Data_Mysql_Table_Spacepedia::getCategoryInfo($category);
        Tpl_Smarty::assign('category_info', $categoryInfo);

        //调取历史表中的数据
        $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($_REQUEST['space_id']);
        if(empty($spacepedia)){
            //历史表中数据不存在，调用百科表数据
            $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($_REQUEST['space_id']);
            if(empty($spacepedia_info[0])){
                Func_Header::back('数据不存在！！');
            }else{
                $data_edit["object_id"]=$spacepedia_info[0]['id'];
                $data_edit["data_backup"]=$spacepedia_info[0];
                if (!empty($spacepedia_info[0]['category_id']) && ($spacepedia_info[0]['category_id']==112 ||(isset($categoryInfo[$spacepedia_info[0]['category_id']]['parent_id'])&&$categoryInfo[$spacepedia_info[0]['category_id']]['parent_id']==112))) {
                    Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($spacepedia_info[0]['category_id']));
                }
                Tpl_Smarty::assign('category_id', $spacepedia_info[0]['category_id']);
            }
        }else{
            if(empty($_REQUEST['history_id'])){
                $_REQUEST['history_id']=$spacepedia[0]['id'];
            }
            foreach($spacepedia as $k =>$v){
                if($_REQUEST['history_id']==$v['id']){
                    $data_edit=$v;
                }
            }
            //调取百科的category_id
            $category_baike = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($_REQUEST['space_id']);
            if (!empty($category_baike[0]['category_id']) && ($category_baike[0]['category_id']==112 || $categoryInfo[$category_baike[0]['category_id']]['parent']==112)) {
                Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($category_baike[0]['category_id']));
            }
            Tpl_Smarty::assign('category_id', $category_baike[0]['category_id']);
        }
        Tpl_Smarty::assign('status',Data_Mysql_Table_History::$status);
        if(!empty($data_edit['data_backup']['media'])){
            foreach($data_edit['data_backup']['media'] as $k=>$v){
                if(empty($v['tags']) || $v['tags']=="@主图"){
                    $v['tags']="外景图片";
                }
                $data_edit['data_backup']['media1'][$v['tags']][]=$v;
            }
        }
        Tpl_Smarty::assign('_data',$spacepedia);
        Tpl_Smarty::assign('data_edit',$data_edit);
        Tpl_Smarty::assign("level",Data_Mysql_Table_Spacepedia::$level);
        Tpl_Smarty::display("OA_Static","baike/baike_edit.tpl");
    }
    /*
    *场地百科修改表单提交
    */
    static function editSubmitSpacepedia(){
        if(empty($_REQUEST['space_id'])){
            Func_Header::back('参数缺失！！');
        }
        $_REQUEST['data']['space_id']=$_REQUEST['space_id'];
        $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($_REQUEST['data']);
        if(empty($return["status"])){
            Func_Header::back($return["msg"]);
        }else{
            Func_Header::to(" 场地百科数据已更新，请等待审核！！","?");
        }
    }
}