<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-1-4
 * Time: 下午5:06
 */
class OA_My_Baike_List{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getBaikeList();
                break;
            case "case":
                Spacepedia_Case_Management::handle();
                break;
            case "edit":
                OA_Baike_List::editSpacepedia();
                break;
            case "edit_submit":
                OA_Baike_List::editSubmitSpacepedia();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }
    static function getBaikeList($cid=0){
        $conditions=array();
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
        $conditions['{prefix}space_assign.phone = ?']=$_SESSION['administrator']['phone'];
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
        $data=Data_Mysql_Table_Spacepedia::page(0,20,'{table}.*',$conditions,'ORDER BY {table}.update_time DESC',"{table} LEFT JOIN {prefix}space_assign ON {table}.id = {prefix}space_assign.space_pedia_id");
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[city]='.$search['city'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[create_time]='.$search['create_time'];
            $data['other']['urls'] =  $sea_url;
        }
        $data['other']['handle_type'] =$handle_type;
        //获取场地百科分类
        $categoryName = Data_Mysql_Table_Spacepedia::$category_name;
        Tpl_Smarty::assign('category_name', $categoryName);

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
        Tpl_Smarty::assign("history",$history);
        Tpl_Smarty::assign("_data",$data);
        Tpl_Smarty::assign("level",Data_Mysql_Table_Spacepedia::$level);
        Tpl_Smarty::assign("is_admin", Admin_Authority::checkUrl('space/space_level', 0));
        Tpl_Smarty::assign("is_my", 1);
        Tpl_Smarty::display("OA_Static","baike/baike_list.tpl");
    }
}