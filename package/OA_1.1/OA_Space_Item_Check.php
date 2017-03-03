<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-20
 * Time: 下午3:54
 */
class OA_Space_Item_Check{
    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? 'check_list' : $_REQUEST['action'];
        switch($_REQUEST['action']){
            case "check_list":
                self::getSpaceItemCheckList();
                break;
            case "check_detail":
                self::getCheckInfo();
                break;
            case "pass":
                self::handleSpaceItemPass();
                break;
            case "refuse":
                self::handleSpaceItemRefuse();
                break;
            default:
                Func_Header::notFound();
                break;
        }

    }

    /*
     *获取所有待审核的子空间列表
     */
    static function getSpaceItemCheckList(){
        $conditions['{table}.status = ?']=2;
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'space_name'=>'string',
                'city' => 'string',
                'contacts' => 'string',
                'phone' => 'phone',
                'end_time' => 'string',
                'start_time' => 'string',
                'create_time'=>'string',
            ),$_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['{table}.id = ?'] = $search['title'];
                } else {
                    $conditions['{table}.item_name = ?'] = $search['title'];
                }
            }
            //百科筛选
            if (!empty($search['space_name'])) {
                $conditions['{prefix}spacepedia.space_name = ?'] = $search['space_name'];
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

            //联系人筛选
            if (!empty($search['contacts'])) {
                $conditions['{table}.contacts = ?'] = $search['contacts'];
            }

            //手机号筛选
            if (!empty($search['phone'])) {
                $conditions['{table}.phone = ?'] = $search['phone'];
            }

            //创建时间筛选
            if(!empty($search['create_time'])){
                $conditions['{table}.create_time >= ?'] =strtotime($search['create_time']);
            }
        }
        $data=Api_Space_Item_List_And_Info::getSpaceItemList($conditions);
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[space_name]='.$search['space_name'].'&search[city]='.$search['city'].'&search[contacts]='.$search['contacts'].'&search[phone]='.$search['phone'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[create_time]'.$search['create_time'];
            $data['other']['urls'] =  $sea_url;
        }
        Tpl_Smarty::assign("_data",$data);
        Tpl_Smarty::assign("_categoryList",Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign("_categoryInfo",Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static","space_item_check/space_item_check_list.tpl");
    }

    /*
     *获取待审核百科的详细信息
     */
    static function getCheckInfo(){
        if(empty($_REQUEST['item_id'])){
            Func_Header::back('参数缺失！！');
        }
        $space_item=Api_Space_Item_List_And_Info::getSpaceItemInfoById($_REQUEST['item_id']);
        if(empty($space_item)){
            Func_Header::back('数据不存在！！');
        }
        Tpl_Smarty::assign('_data',$space_item);
        Tpl_Smarty::display("OA_Static","space_item_check/space_item_check_detail.tpl");
    }



    /*
     *子空间通过审核
     */
    static function handleSpaceItemPass()
    {
        if (empty($_REQUEST['item_id'])) {
            Func_Header::back("参数缺失！！");
        }
        $data=Data_Mysql_Table_Space_Item::select("*",array('id'=>$_REQUEST['item_id']));
        if(empty($data[0])){
            Func_Header::back('数据不存在！！');
        }
        $data[0]['status'] =empty($_REQUEST['status'])?0:$_REQUEST['status'];
        $data[0]['item_id']=$data[0]['id'];
        $data[0]['min_price']=$data[0]['min_price']/100;
        $data[0]['max_price']=$data[0]['max_price']/100;
        unset($data[0]['id']);
        $return=Api_Space_Item_Submit::spaceItemSubmit($data[0]);
        if($return){
            Func_Header::to(' 子空间信息审核成功！',"?");
        }else{
            Func_Header::back("子空间数据审核失败！！");
        }
    }

    /*
     *子空间未通过审核
     */
    static function handleSpaceItemRefuse()
    {
        $request = Func_Input::filter(array(
            'item_id' => 'id',
            'reason' => 'string',
        ));
        if (empty($request['item_id'])) {
            Func_Header::notFound();
        }
        if (empty($request['reason'])) {
            Func_Header::back('请输入拒绝理由');
        }
        $rs = Data_Mysql_Table_Space_Item::update(array('id'=>$request['item_id']), array('status'=>3,'refuse_reason'=>$request['reason']));
        if ($rs[0] > 0) {
            Func_Header::to(' 子空间未通过审核！', '?');
        }else{
            Func_Header::back('子空间未通过失败');
        }
    }
}