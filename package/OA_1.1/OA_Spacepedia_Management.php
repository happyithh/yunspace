<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:02
 * 场地百科管理
 */
class OA_Spacepedia_Management{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getSpacepediaList();
                break;
            case "add_spacepedia":
                self::addSpacepedia();
                break;
            case "detail":
                self::detailSpacepedia();
                break;
            case "case":
                Spacepedia_Case_Management::handle();
                break;
            case "assign":
                self::assignSpacepedia();
                break;
            case "assign_submit":
                self::submitAssignSpacepedia();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }


    //场地百科和下属子空间分配给手机号
    static function assignSpacepedia() {
        $conditions = array();
        if(empty($_REQUEST['space_id'])){
            Func_Header::back('参数缺失！！');
        }
        $conditions['{table}.space_id = ?'] = $_REQUEST['space_id'];
        $rs = Data_Mysql_Table_Space_Item::select('{table}.id,item_name,{table}.status,{prefix}spacepedia.id as space_id,{prefix}spacepedia.space_name',$conditions,'',10,'{table} LEFT JOIN {prefix}spacepedia ON {prefix}spacepedia.id={table}.space_id');
//        q($rs);
        Tpl_Smarty::assign('space_id',$_REQUEST['space_id']);
        Tpl_Smarty::assign('data',$rs);
        Tpl_Smarty::display("OA_Static","spacepedia/spacepedia_assign.tpl");

    }

    //场地百科和下属子空间分配给手机号 ->提交
    static function submitAssignSpacepedia() {
        if(!empty($_REQUEST['data'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'space_item_id' => 'array',
                'phone' => 'phone',
                'pedia_assign_status' => 'int',
            ), $_REQUEST['data']);

            if(!empty($request['space_pedia_id'])) {
                $request['pedia_assign_status'] = 1;
            } else {
                $request['pedia_assign_status'] = 2;
                $request['space_pedia_id'] = $_REQUEST['space_id'];
            }
            if(empty($request['phone'])){
                Func_Header::back('请输入正确的手机号码！！');
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
                Func_Header::to(' 授权成功！',"?action=assign&space_id=".$_REQUEST['space_id']);
            }
            Func_Header::back('授权失败，请重试！');
        }
    }

    /*
     *获取场地百科的列表信息
     */
    static function getSpacepediaList(){
        $conditions=array();
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'vendor_name'=>'string',
                'city' => 'string',
                'category_id' => 'int',
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
            //供应商筛选
            if (!empty($search['vendor_name'])) {
                $conditions['{prefix}vendor_info_update.vendor_name = ?'] = $search['vendor_name'];
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

            //服务分类筛选
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Spacepedia::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
//                $conditions['{table}.category_id = ?'] = $search['category_id'];
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
                $conditions['{table}.status >= ?']=0;
                break;
        }
        if($handle_type=='article_count'){
            $order = "ORDER BY {prefix}baike_statistical.article_sum DESC,{table}.update_time DESC";
        }else{
            $order = "ORDER BY {table}.update_time DESC";
        }
        $data=Api_Spacepedia_List_And_Info::getSpacepediaList($conditions,$order);
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[vendor_name]='.$search['vendor_name'].'&search[city]='.$search['city'].'&search[category_id]='.$search['category_id'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[create_time]='.$search['create_time'];
            $data['other']['urls'] =  $sea_url;
        }
        $data['other']['handle_type'] =$handle_type;
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
        //获取场地百科分类
        $categoryName = Data_Mysql_Table_Spacepedia::$category_name;
        Tpl_Smarty::assign('category_name', $categoryName);
        //获取场地状态值
        $status = Data_Mysql_Table_Spacepedia::$status;
        Tpl_Smarty::assign("status",$status);

        Tpl_Smarty::assign("history",$history);
        Tpl_Smarty::assign("_data",$data);
        Tpl_Smarty::assign("level",Data_Mysql_Table_Spacepedia::$level);
        Tpl_Smarty::assign("is_admin", Admin_Authority::checkUrl('space/space_level', 0));
//        Tpl_Smarty::assign("_categoryList",Data_Mysql_Table_Product_Category::getTreeCache());
//        Tpl_Smarty::assign("_categoryInfo",Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static","spacepedia/spacepedia_list.tpl");
    }

    /*
     *添加场地百科
     */
    static function addSpacepedia(){
        $request=Func_Input::filter(array(
            'space_name'=>'string',
            'category_id'=>'int',
        ));
        if(empty($request['space_name'])){
            Func_Header::back('场地百科名称不能为空！！');
        }
        //判断名称是否重复
        $name_exists=Data_Mysql_Table_Spacepedia::select("id,space_name",array('space_name = ?'=>$request['space_name']));
        if(!empty($name_exists[0])){
            Func_Header::back('该场地百科名称已经存在！');
        }
        $request['status']=2;
        $rs=Data_Mysql_Table_Spacepedia::insert($request);
        if(!empty($rs[0])){
            $space_id = $rs[0];
        }else{
            return false;
        }
        $id =Data_Mysql_Table_Spacepedia::select('id,space_name,category_id',array('id'=>$space_id));
        $constion['data_backup']['space_name'] =$id[0]['space_name'];
        $constion['data_backup']['space_id'] =$id[0]['id'];
        $constion['data_backup']['category_id'] =$id[0]['category_id'];
        $constion['object_id'] =$id[0]['id'];
        $constion['status'] =0;
        $constion['create_time'] =time();
        $constion['admin_id'] = $_SESSION['administrator']['id'];
       $hos = Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->insert($constion);
        if(empty($rs[0])){
            Func_Header::back('创建百科失败！！');
        }else{
            //创建操作日志
            $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => Api_Session::admin_id()));
            $account_id = !empty($account['account_id']) ? $account['account_id'] : $_SESSION['administrator']['id'];
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id,$_SESSION['administrator']['id'],'新建百科','新建百科',$id[0]['id']);
            Func_Header::to(' 百科已创建，等待审核！！',"?");
        }
    }

    /*
     *场地百科详细和子空间列表页
     */
    static function detailSpacepedia(){
        if(empty($_REQUEST['space_id'])){
            Func_Header::back('参数缺失！！');
        }

        //获取场地百科分类
        $category = Data_Mysql_Table_Spacepedia::$category_name;
        $categoryInfo = Data_Mysql_Table_Spacepedia::getCategoryInfo($category);
        Tpl_Smarty::assign('category_info', $categoryInfo);


        $data_edit=array();
       if(!empty($_REQUEST['tab']) && $_REQUEST['tab'] ==2){
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
                   if (!empty($spacepedia_info[0]['category_id']) && ($spacepedia_info[0]['category_id']==112 ||(isset($categoryInfo[$spacepedia_info[0]['category_id']]['parent'])&&$categoryInfo[$spacepedia_info[0]['category_id']]['parent']==112))) {
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
       }else{
           //页面进入详情页时的数据调用
            $spacepedia = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($_REQUEST['space_id']);
           if (empty($spacepedia)) {
               Func_Header::back('数据不存在！！');
           }
       }

        $vendor_info = Data_Config_Vendor_Attr::all();
        $contacts_city = $vendor_info['attr']['城市'];
        Tpl_Smarty::assign('_contacts_city', $contacts_city);

        Tpl_Smarty::assign('status',Data_Mysql_Table_History::$status);
        Tpl_Smarty::assign('_data',$spacepedia);
     //q($spacepedia);
        if(!empty($spacepedia[0]['new_id'])){
            $newspace = Data_Mysql_Table_New_Space::select('*',array('id =?'=>$spacepedia[0]['new_id']));
            $newspace[0]['card'] = json_decode($newspace[0]['card'],1);
           // q($newspace[0]);
            Tpl_Smarty::assign('card',$newspace[0]);
        }
        if(!empty($data_edit['data_backup']['media'])){
            foreach($data_edit['data_backup']['media'] as $k=>$v){
                if(empty($v['tags']) || $v['tags']=="@主图"){
                    $v['tags']="外景图片";
                }
                $data_edit['data_backup']['media1'][$v['tags']][]=$v;
            }
        }
        Tpl_Smarty::assign('data_edit',$data_edit);
        $tab_action=empty($_REQUEST['tab_action'])?"item_list":$_REQUEST['tab_action'];
        switch($tab_action){
            case "edit_item":
                OA_Space_Item::editItemShow();
                break;
            case "edit_item_submit":
                OA_Space_Item::editItemInfoSubmit();
                break;
            case "item_list":
                OA_Space_Item::getSpaceItemList();
                break;
            case "submit_spacepedia":
                self::submitSpacepediaInfo();
                break;
            default:
                break;
        }

        Tpl_Smarty::assign("level",Data_Mysql_Table_Spacepedia::$level);
//        Tpl_Smarty::assign("_categoryList",Data_Mysql_Table_Product_Category::getTreeCache());
//        Tpl_Smarty::assign("_categoryInfo",Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("OA_Static","spacepedia/spacepedia_detail.tpl");
    }

    /*
     *场地百科修改表单提交
     */
    static function submitSpacepediaInfo(){
        if(empty($_REQUEST['space_id'])){
            Func_Header::back('参数缺失！！');
        }
        $_REQUEST['data']['space_id']=$_REQUEST['space_id'];
        $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($_REQUEST['data']);
        if(empty($return["status"])){
            Func_Header::back($return["msg"]);
        }else{
            //创建操作日志
            $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => Api_Session::admin_id()));
            $account_id = !empty($account['account_id']) ? $account['account_id'] : $_SESSION['administrator']['id'];
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id,$_SESSION['administrator']['id'],'百科修改','修改百科',$return['data']);
            Func_Header::to(" 场地百科数据已更新，请等待审核！！","?action=".$_REQUEST['action']."&space_id=".$_REQUEST['space_id']);
        }
    }
}