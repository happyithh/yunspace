<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2016/1/7
 * Time: 16:53
 * 场地管理2--------场地百科和子空间列表，修改等
 */
@session_start();

class Web_Mobile_Site_Management extends Base
{
    static function handle() {
        $space_pedia = self::pediaItemBind();
//        q($space_pedia[4]); trim(Core::$urls['route'],'/')
        Tpl_Smarty::assign('space_pedia',$space_pedia);
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m0-0.php.tpl');
//        Tpl_Smarty::display('Web_Mobile_Static::site_management/111.tpl');

    }

    //场地百科数据绑定
    static function pediaItemBind()
    {
        //查询 该session的手机号中授权的场地百科和子空间情况(注意百科和子空间的审核状态)
        $conditions['{table}.phone = ?'] = $_SESSION['user']['phone'];
        //1.查该手机号下的百科名称，子空间名称个数
        //百科表  根据session的手机号查account_id，再查出vendor_id，判断此vendor_id是否存在于百科表中（场地百科查询--列表1）
        //此种情况，子空间应该是查询出来的百科下的所有子空间
        $rs_a = Data_Mysql_Table_Account::select('{prefix}space_item.id as space_item_id,{prefix}space_item.item_name',$conditions,'',10,'{table} LEFT JOIN {prefix}vendor_info ON {prefix}vendor_info.vendor_account_id={table}.id LEFT JOIN {prefix}spacepedia ON {prefix}vendor_info.id = {prefix}spacepedia.vendor_id LEFT JOIN {prefix}space_item ON {prefix}space_item.space_id={prefix}spacepedia.id');

        //2.如果上述根据session手机号查不到结果,则根据此手机号去查询子空间表和授权表，根据查询出来的子空间所归属的场地百科（场地百科--列表2）
        //此种情况，子空间应该是根据该手机号查询子空间表和授权表

        //查询该手机号的account
        $rs_b = Data_Mysql_Table_Space_Item::select('{table}.id as space_item_id,{table}.item_name',$conditions,'',10,'{table}');
        $rs_c = Data_Mysql_Table_Space_Assign::select('{table}.space_item_id,{table}.pedia_assign_status',$conditions,'',10,'{table}');
        foreach($rs_c as $k=>$v) {
            $rs_c[$k]['space_item_id'] = json_decode($v['space_item_id'],1);
        }
        $space_pedia = $space_item_id = array();
        //将所有的子空间item_id装进一个数组
        if(!empty($rs_a[0]['space_item_id'])) {
            foreach($rs_a as $k=>$v) {
                if(!empty($v['space_item_id'])) {
                    $space_item_id[] = $v['space_item_id'];
                }
            }
        }
        if(!empty($rs_b[0])) {
            foreach ($rs_b as $k => $v) {
                $space_item_id[] = $v['space_item_id'];
            }
        }
        if(!empty($rs_c[0])) {
            foreach ($rs_c as $k => $v) {
                foreach ($v as $kk => $vv) {
                    if ($kk == 'space_item_id' && !empty($vv)) {
                        foreach ($vv as $kkk => $vvv) {
                            $space_item_id[] = $vvv;
                        }
                    }
                }
            }
        }
        $space_item_id = array_unique($space_item_id);
        $condition_item[] = '{table}.id IN ('.implode(',',$space_item_id).')';
        $rs_row = Data_Mysql_Table_Space_Item::select('{table}.id as space_item_id,{table}.item_name,{table}.logo as item_logo,{table}.size,{table}.min_price,{table}.max_price,{prefix}spacepedia.id as space_pedia_id,{prefix}spacepedia.space_name,{prefix}spacepedia.attr,{prefix}spacepedia.addr,{prefix}spacepedia.logo as space_logo',$condition_item,'',10,'{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id={prefix}spacepedia.id');

        foreach($rs_row as $k=>$v) {
            $rs_row[$k]['attr'] = json_decode($v['attr'],1);
        }
        foreach($rs_row as $k=>$v) {
            if(!empty($v['attr']['特色标签'])) {
                $rs_row[$k]['attr']['特色标签'] = explode(',',$v['attr']['特色标签']);
            }
        }
//        q($rs_row);
        foreach($rs_row as $k=>$v) {
            foreach($v as $kk=>$vv) {
                if($kk=='space_pedia_id') {
                    //场地百科id和名字的绑定
                    $space_pedia[$vv]['space_name'] = $v['space_name'];
                    $space_pedia[$vv]['space_logo'] = $v['space_logo'];
                    $space_pedia[$vv]['space_pedia_id'] = $v['space_pedia_id'];
                    $space_pedia[$vv]['addr'] = $v['addr'];
                    $space_pedia[$vv]['attr'] = $v['attr'];
//                    $space_pedia[$vv]['item_info'][$v['space_item_id']]['space_item_id'] = $v['space_item_id'];
//                    $space_pedia[$vv]['item_info'][$v['space_item_id']]['item_name'] = $v['item_name'];
//                    $space_pedia[$vv]['item_info'][$v['space_item_id']]['item_logo'] = $v['item_logo'];
//                    $space_pedia[$vv]['item_info'][$v['space_item_id']]['min_price'] = $v['min_price'];
//                    $space_pedia[$vv]['item_info'][$v['space_item_id']]['max_price'] = $v['max_price'];
//                    $space_pedia[$vv]['item_info'][$v['space_item_id']]['size'] = $v['size'];
                }
            }
        }
        $space_pedia = array_values($space_pedia);
//        foreach($space_pedia as $k=>$v) {
//            $space_pedia[$k]['item_info'] = array_values($v['item_info']);
//        }
//        q($space_pedia);
        return $space_pedia;

    }

    //场地百科的基本信息展示
    static function basicInfo()
    {


//        $rs_spacepedia = self::pediaInfoByid();
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        self::canEdit();
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-1.php.tpl');
    }


    //根据地址栏上的百科id查询百科详情信息封装
    static function pediaInfoByid()
    {
        $conditions_spacepedia['{table}.id=?'] = $_REQUEST['space_pedia_id'];
        $rs_spacepedia = Data_Mysql_Table_Spacepedia::select('{table}.*,{prefix}vendor_info.vendor_name',$conditions_spacepedia,'',1,'{table} LEFT JOIN {prefix}vendor_info ON {table}.vendor_id={prefix}vendor_info.id');
        @$rs_spacepedia[0]['attr'] = json_decode($rs_spacepedia[0]['attr'],1);
        if(!empty($rs_spacepedia[0]['attr']['特色标签'])) {
            $rs_spacepedia[0]['attr']['特色标签'] = explode(',',$rs_spacepedia[0]['attr']['特色标签']);
        }
        if(!empty($rs_spacepedia[0]['attr'][2])) {
            $rs_spacepedia[0]['attr'][2] = explode(',',$rs_spacepedia[0]['attr'][2]);
        }
        if(!empty($rs_spacepedia[0]['attr'][3])) {
            $rs_spacepedia[0]['attr'][3] = explode(',',$rs_spacepedia[0]['attr'][3]);
        }
        if(!empty($rs_spacepedia[0]['attr'][9])) {
            $rs_spacepedia[0]['attr'][9] = explode(',',$rs_spacepedia[0]['attr'][9]);
        }
        if(!empty($rs_spacepedia[0]['attr'][49])) {
            @$rs_spacepedia[0]['attr'][49] = explode(',',$rs_spacepedia[0]['attr'][49]);
        }
        return $rs_spacepedia;
//        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
    }

    //从历史表中将最新的该百科信息调取出来
    static function historyPediaInfo()
    {
        $pedia_data = array();
        //调取历史表中的数据
        $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($_REQUEST['space_pedia_id']);
        if(empty($spacepedia)){
            //历史表中数据不存在，调用百科表数据
            $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($_REQUEST['space_pedia_id']);
            if(empty($spacepedia_info[0])){
                Func_Header::back('数据不存在！！');
            }else{
                $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                $pedia_data["data_backup"]=$spacepedia_info[0];
            }
        }else{
            $pedia_data = $spacepedia[0];
        }
        if(!empty($pedia_data['data_backup']['attr']['特色标签'])) {
            $pedia_data['data_backup']['attr']['特色标签'] = explode(',',$pedia_data['data_backup']['attr']['特色标签']);
        }
        if(!empty($pedia_data['data_backup']['attr'][2])) {
            $pedia_data['data_backup']['attr'][2] = explode(',',$pedia_data['data_backup']['attr'][2]);
        }
        if(!empty($pedia_data['data_backup']['attr'][3])) {
            $pedia_data['data_backup']['attr'][3] = explode(',',$pedia_data['data_backup']['attr'][3]);
        }
        if(!empty($pedia_data['data_backup']['attr'][9])) {
            $pedia_data['data_backup']['attr'][9] = explode(',',$pedia_data['data_backup']['attr'][9]);
        }
        if(!empty($pedia_data['data_backup']['attr'][49])) {
            @$pedia_data['data_backup']['attr'][49] = explode(',',$pedia_data['data_backup']['attr'][49]);
        }
        return $pedia_data;
    }



    //查询session中的手机号是否有 该百科id的权限（是否可以修改该百科）
    static function canEdit()
    {
        //查询session中的手机号是否有 该百科id的权限（是否可以修改该百科）
        $conditions['{table}.phone = ?'] = $_SESSION['user']['phone'];
        $conditions['{prefix}spacepedia.id = ?'] = $_REQUEST['space_pedia_id'];

        $rs_a = Data_Mysql_Table_Account::select('{prefix}spacepedia.id',$conditions,'',1,'{table} LEFT JOIN {prefix}vendor_info ON {prefix}vendor_info.vendor_account_id={table}.id LEFT JOIN {prefix}spacepedia ON {prefix}vendor_info.id = {prefix}spacepedia.vendor_id');
//        q($rs_a);
        if(!empty($rs_a[0])) {
            //可以修改该百科
            Tpl_Smarty::assign('can_edit',1);
        } else{
            $conditions_b['{table}.phone = ?'] = $_SESSION['user']['phone'];
            $conditions_b['{table}.space_pedia_id = ?'] = $_REQUEST['space_pedia_id'];
            $rs_b = Data_Mysql_Table_Space_Assign::select('{table}.space_pedia_id,{table}.pedia_assign_status',$conditions_b);
//            q($rs_b);
            if($rs_b[0]['pedia_assign_status']==1) {
                //百科和手机号绑定，即百科也授权给了该手机号，可以编辑百科
                Tpl_Smarty::assign('can_edit',1);
            } else {
                //百科不能修改（隐藏修改）
                Tpl_Smarty::assign('can_edit',0);
            }
        }
    }

    //基本信息编辑
    static function basicInfoEdit()
    {

//        q(Core::$urls);
        if (!empty($_REQUEST['vendor_auto_complete'])) {
            self::handleVendorAutoComplete();
        }elseif(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'space_name' => 'string',
//                'attr_new' => 'array',
                'attr' => 'array',
                'addr' => 'string',
                'des' => 'html',
            ), $_REQUEST['data']);
//            q($request);
            if(empty($request['space_name'])) {
                Func_Header::back('请输入场地名称！');
            }
            if(mb_strwidth($request['des'],'utf-8')<30) {
                Func_Header::back('请至少输入15个字的场地描述！');
            }

            //******
            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)){
            //历史表中数据不存在，调用百科表数据
            $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
            if(empty($spacepedia_info[0])){
            Func_Header::back('数据不存在！！');
            }else{
            $pedia_data["object_id"]=$spacepedia_info[0]['id'];
            $pedia_data["data_backup"]=$spacepedia_info[0];
            }
            }else{
            $pedia_data = $spacepedia[0];
            }
//            q($pedia_data['data_backup']);
            $pedia_data['data_backup']['space_name'] = $request['space_name'];
            $pedia_data['data_backup']['addr'] = $request['addr'];
            $pedia_data['data_backup']['des'] = $request['des'];
            $pedia_data['data_backup']['attr'][4] = $request['attr'][4];
            $pedia_data['data_backup']['attr']['营销标题'] = $request['attr']['营销标题'];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Header::to('修改成功，请等待审核！','/'.Core::$urls['package'].Core::$urls['route'].'basic_info?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }


        //-------------此段代码要封装一下---------------
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        //-------------此段代码要封装一下-----------------
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-2.php.tpl');
    }



    //供应商自动查询
    static function handleVendorAutoComplete()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            die('参数错误!');
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("id = ? and status >= ?" => array($request['id'], 0)));
        } else {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("(id like ? OR vendor_name like ?) and status >= ?" => array($request['q'] . '%', $request['q'] . '%', 0)), '', 5);
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => 1,
                    'name' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['name'] = '';
            $ajax_arr['items'][$key]['full_name'] = $val['name'];
        }
        echo json_encode($ajax_arr);
        die();
    }

    //特色标签编辑
    static function tagsEdit()
    {
        Core::output('');
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'tags_attr'=>'string',
            ), $_REQUEST);

            $pedia_data = array();
               //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)) {
                    //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            } else {
                $pedia_data = $spacepedia[0];
            }

            $pedia_data['data_backup']['attr']['特色标签'] = $request['tags_attr'];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Output::json('success','','修改成功，请等待审核！');
            }else{
                Func_Output::json('error','','修改失败');
            }
        }

        //展示数据页面

        $rs_spacepedia = self::historyPediaInfo();
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-3.php.tpl');

    }

    //交通轨道编辑
    static function trafficEdit()
    {
        Core::output('');
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'traffic'=>'string',
            ), $_REQUEST);

            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)) {
                //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            } else {
                $pedia_data = $spacepedia[0];
            }

            $pedia_data['data_backup']['attr'][3] = $request['traffic'];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Output::json('success','','修改成功，请等待审核！');
            }else{
                Func_Output::json('error','','修改失败');
            }
        }

        //展示数据页面
        $rs_spacepedia = self::historyPediaInfo();
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-4.php.tpl');
    }

    //商圈编辑
    static function businessEdit()
    {
        Core::output('');
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'business_attr'=>'string',
            ), $_REQUEST);

            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)) {
                //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            } else {
                $pedia_data = $spacepedia[0];
            }

            $pedia_data['data_backup']['attr'][2] = $request['business_attr'];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Output::json('success','','修改成功，请等待审核！');
            }else{
                Func_Output::json('error','','修改失败');
            }
        }

        //展示数据页面

        $rs_spacepedia = self::historyPediaInfo();
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-5.php.tpl');

    }


    static function spaceStd()
    {
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        self::canEdit();
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m2-1.php.tpl');
    }


    static function spaceStdEdit()
    {
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
//                'space_name' => 'string',
                'attr' => 'array',
//                'addr' => 'string',
//                'des' => 'html',
            ), $_REQUEST['data']);

            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)){
                //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            }else{
                $pedia_data = $spacepedia[0];
            }
//            q($pedia_data['data_backup']);
            $pedia_data['data_backup']['attr'][6] = $request['attr'][6];
            $pedia_data['data_backup']['attr'][8] = $request['attr'][8];
            $pedia_data['data_backup']['attr'][10] = $request['attr'][10];
            $pedia_data['data_backup']['attr'][11] = $request['attr'][11];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Header::to('修改成功，请等待审核！','/'.Core::$urls['package'].Core::$urls['route'].'space_std?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }

        //-------------此段代码要封装一下---------------
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        //-------------此段代码要封装一下-----------------
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m2-2.php.tpl');
    }

    static function matingService()
    {
        $rs_spacepedia = self::historyPediaInfo();
        self::canEdit();
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m3-1.php.tpl');

    }


    static function matingServiceEdit()
    {
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'attr' => 'array',
            ), $_REQUEST['data']);

            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)){
                //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            }else{
                $pedia_data = $spacepedia[0];
            }

//            q($pedia_data['data_backup']);
            $pedia_data['data_backup']['attr'][14] = $request['attr'][14];
            $pedia_data['data_backup']['attr'][13] = $request['attr'][13];
            $pedia_data['data_backup']['attr'][12] = $request['attr'][12];
            $pedia_data['data_backup']['attr'][15] = $request['attr'][15];
            $pedia_data['data_backup']['attr'][17] = $request['attr'][17];
            $pedia_data['data_backup']['attr'][18] = $request['attr'][18];
            $pedia_data['data_backup']['attr'][5] = $request['attr'][5];
            $pedia_data['data_backup']['attr'][19] = $request['attr'][19];
            $pedia_data['data_backup']['attr'][20] = $request['attr'][20];
            $pedia_data['data_backup']['attr'][21] = $request['attr'][21];
            $pedia_data['data_backup']['attr'][24] = $request['attr'][24];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Header::to('修改成功，请等待审核！','/'.Core::$urls['package'].Core::$urls['route'].'mating_service?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }
        //-------------此段代码要封装一下---------------
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        //-------------此段代码要封装一下-----------------
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m3-2.php.tpl');
    }



    static function useStd()
    {
        $rs_spacepedia = self::pediaInfoByid();
        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
        self::canEdit();
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m4-1.php.tpl');
    }




    static function useStdEdit()
    {
        if(!empty($_REQUEST['is_submit'])) {
            $_REQUEST['data']['attr_new'] = json_decode($_REQUEST['data']['attr_new'],1);
//            q($_REQUEST['data']['attr_new']);
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'attr_new' => 'array',
                'attr' => 'array',
            ), $_REQUEST['data']);
            $data_space_pedia = array();
            $data_space_pedia['attr'] = $request['attr_new'];
            $data_space_pedia['attr'][7] = $request['attr'][7];
            $data_space_pedia['attr'][15] = $request['attr'][15];
            $data_space_pedia['attr'][16] = $request['attr'][16];
//            q($data_space_pedia);
            $rs = Data_Mysql_Table_Spacepedia::update(array('id'=>$request['space_pedia_id']),$data_space_pedia);
            if($rs[0]>0) {
                Func_Header::to('修改成功！','/'.Core::$urls['package'].Core::$urls['route'].'use_std?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }
        //展示数据页面
        $rs_spacepedia = self::pediaInfoByid();
        if(!empty($rs_spacepedia[0]['attr']['特色标签'])) {
            $rs_spacepedia[0]['attr']['特色标签'] = implode(',',$rs_spacepedia[0]['attr']['特色标签']);
        }
        if(!empty($rs_spacepedia[0]['attr'][2])) {
            $rs_spacepedia[0]['attr'][2] = implode(',',$rs_spacepedia[0]['attr'][2]);
        }
        if(!empty($rs_spacepedia[0]['attr'][3])) {
            $rs_spacepedia[0]['attr'][3] = implode(',',$rs_spacepedia[0]['attr'][3]);
        }
        if(!empty($rs_spacepedia[0]['attr'][9])) {
            $rs_spacepedia[0]['attr'][9] = implode(',',$rs_spacepedia[0]['attr'][9]);
        }
        if(!empty($rs_spacepedia[0]['attr'][49])) {
            $rs_spacepedia[0]['attr'][49] = implode(',',$rs_spacepedia[0]['attr'][49]);
        }
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::assign('data_attr',json_encode($rs_spacepedia[0]['attr'],1));
        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m4-2.php.tpl');

    }


    static function matingDrink()
    {
        $rs_spacepedia = self::pediaInfoByid();
        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
        self::canEdit();
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m5-1.php.tpl');

    }


    static function matingDrinkEdit()
    {
        if(!empty($_REQUEST['is_submit'])) {
            $_REQUEST['data']['attr_new'] = json_decode($_REQUEST['data']['attr_new'],1);
//            q($_REQUEST['data']['attr_new']);
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'attr_new' => 'array',
                'attr' => 'array',
            ), $_REQUEST['data']);
            $data_space_pedia = array();
            $data_space_pedia['attr'] = $request['attr_new'];
            $data_space_pedia['attr'][22] = $request['attr'][22];
            $data_space_pedia['attr'][23] = $request['attr'][23];
//            q($data_space_pedia);
            $rs = Data_Mysql_Table_Spacepedia::update(array('id'=>$request['space_pedia_id']),$data_space_pedia);
            if($rs[0]>0) {
                Func_Header::to('修改成功！','/'.Core::$urls['package'].Core::$urls['route'].'mating_drink?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }
        //展示数据页面
        $rs_spacepedia = self::pediaInfoByid();
        if(!empty($rs_spacepedia[0]['attr']['特色标签'])) {
            $rs_spacepedia[0]['attr']['特色标签'] = implode(',',$rs_spacepedia[0]['attr']['特色标签']);
        }
        if(!empty($rs_spacepedia[0]['attr'][2])) {
            $rs_spacepedia[0]['attr'][2] = implode(',',$rs_spacepedia[0]['attr'][2]);
        }
        if(!empty($rs_spacepedia[0]['attr'][3])) {
            $rs_spacepedia[0]['attr'][3] = implode(',',$rs_spacepedia[0]['attr'][3]);
        }
        if(!empty($rs_spacepedia[0]['attr'][9])) {
            $rs_spacepedia[0]['attr'][9] = implode(',',$rs_spacepedia[0]['attr'][9]);
        }
        if(!empty($rs_spacepedia[0]['attr'][49])) {
            $rs_spacepedia[0]['attr'][49] = implode(',',$rs_spacepedia[0]['attr'][49]);
        }
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::assign('data_attr',json_encode($rs_spacepedia[0]['attr'],1));
        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m5-2.php.tpl');
    }



    static function moneyStd()
    {
        $rs_spacepedia = self::pediaInfoByid();
        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
        self::canEdit();
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m6-1.php.tpl');

    }



    static function moneyStdEdit()
    {
        if(!empty($_REQUEST['is_submit'])) {
            $_REQUEST['data']['attr_new'] = json_decode($_REQUEST['data']['attr_new'],1);
//            q($_REQUEST['data']['attr_new']);
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'attr_new' => 'array',
                'attr' => 'array',
            ), $_REQUEST['data']);
            $data_space_pedia = array();
            $data_space_pedia['attr'] = $request['attr_new'];
            $data_space_pedia['attr'][25] = $request['attr'][25];
            $data_space_pedia['attr'][26] = $request['attr'][26];
            $data_space_pedia['attr'][27] = $request['attr'][27];
            $data_space_pedia['attr'][28] = $request['attr'][28];
            $data_space_pedia['attr'][29] = $request['attr'][29];
            $data_space_pedia['attr'][30] = $request['attr'][30];
//            q($data_space_pedia);
            $rs = Data_Mysql_Table_Spacepedia::update(array('id'=>$request['space_pedia_id']),$data_space_pedia);
            if($rs[0]>0) {
                Func_Header::to('修改成功！','/'.Core::$urls['package'].Core::$urls['route'].'money_std?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }
        //展示数据页面
        $rs_spacepedia = self::pediaInfoByid();
        if(!empty($rs_spacepedia[0]['attr']['特色标签'])) {
            $rs_spacepedia[0]['attr']['特色标签'] = implode(',',$rs_spacepedia[0]['attr']['特色标签']);
        }
        if(!empty($rs_spacepedia[0]['attr'][2])) {
            $rs_spacepedia[0]['attr'][2] = implode(',',$rs_spacepedia[0]['attr'][2]);
        }
        if(!empty($rs_spacepedia[0]['attr'][3])) {
            $rs_spacepedia[0]['attr'][3] = implode(',',$rs_spacepedia[0]['attr'][3]);
        }
        if(!empty($rs_spacepedia[0]['attr'][9])) {
            $rs_spacepedia[0]['attr'][9] = implode(',',$rs_spacepedia[0]['attr'][9]);
        }
        if(!empty($rs_spacepedia[0]['attr'][49])) {
            $rs_spacepedia[0]['attr'][49] = implode(',',$rs_spacepedia[0]['attr'][49]);
        }
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::assign('data_attr',json_encode($rs_spacepedia[0]['attr'],1));
        Tpl_Smarty::assign('data',$rs_spacepedia[0]);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m6-2.php.tpl');

    }


    static function actApply()
    {
        $rs_spacepedia = self::historyPediaInfo();
        Tpl_Smarty::assign('data',$rs_spacepedia);
        self::canEdit();
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m7-1.php.tpl');

    }


    static function tradeTypeEdit()
    {
        Core::output('');
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'trade_attr'=>'string',
            ), $_REQUEST);

            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)) {
                //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            } else {
                $pedia_data = $spacepedia[0];
            }

            $pedia_data['data_backup']['attr'][9] = $request['trade_attr'];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Output::json('success','','修改成功，请等待审核！');
            }else{
                Func_Output::json('error','','修改失败');
            }
        }
        //展示数据页面
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia['data_backup']['attr'][49]);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m7-2.php.tpl');
    }

    static function actTypeEdit()
    {
        Core::output('');
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_pedia_id' => 'int',
                'act_attr'=>'string',
            ), $_REQUEST);

            $pedia_data = array();
            //调取历史表中的数据
            $spacepedia=Api_Spacepedia_List_And_Info::getHistoryInfoById($request['space_pedia_id']);
            if(empty($spacepedia)) {
                //历史表中数据不存在，调用百科表数据
                $spacepedia_info = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_pedia_id']);
                if(empty($spacepedia_info[0])){
                    Func_Header::back('数据不存在！！');
                }else{
                    $pedia_data["object_id"]=$spacepedia_info[0]['id'];
                    $pedia_data["data_backup"]=$spacepedia_info[0];
                }
            } else {
                $pedia_data = $spacepedia[0];
            }

            $pedia_data['data_backup']['attr'][49] = $request['act_attr'];
            $pedia_data['data_backup']['space_id']=$request['space_pedia_id'];
//            q($pedia_data['data_backup']);
            $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($pedia_data['data_backup']);
            if(!empty($return["status"])) {
                Func_Output::json('success','','修改成功，请等待审核！');
            }else{
                Func_Output::json('error','','修改失败');
            }
        }
        //展示数据页面
        $rs_spacepedia = self::historyPediaInfo();
//        q($rs_spacepedia['data_backup']['attr'][49]);
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m7-3.php.tpl');

    }


    static function imageShow()
    {
        $rs_spacepedia = self::historyPediaInfo();
        self::canEdit();
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m8-1.php.tpl');
//        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m8-1.tpl');

    }



    static function imageEdit()
    {
        $rs_spacepedia = self::historyPediaInfo();
        Tpl_Smarty::assign('data',$rs_spacepedia);
        Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
        Tpl_Smarty::assign('space_pedia_id',$_REQUEST['space_pedia_id']);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m8-2.php.tpl');

    }


    //该场地下的子空间列表
    static function spaceItemList()
    {
        $conditions['phone = ?'] = $_SESSION['user']['phone'];
        $conditions['space_id = ?'] = $_REQUEST['space_pedia_id'];
        $rs_item = Data_Mysql_Table_Space_Item::select('id,logo,item_name,size,min_price,max_price',$conditions,'',10);

        Tpl_Smarty::assign('data',$rs_item);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-0.php.tpl');

    }



    static function spaceItemListShow()
    {
//        Data_Mysql_Table_Space_Item::debug(1);
        $rs = Data_Mysql_Table_Space_Item::select('{table}.*,{prefix}spacepedia.space_name',array('{table}.id = ?'=>$_REQUEST['space_item_id']),'',1,'{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id={prefix}spacepedia.id');
        $rs[0]['tags'] = json_decode($rs[0]['tags'],1);
        $tagids = array();
        foreach($rs[0]['tags'] as $k=>$v) {
            $tagids[] = $k;
        }
        $conditions[] = 'id IN ('.implode(',',$tagids).')';
        $tags = Data_Mysql_Table_Demand_Tag::select('id,tag_value',$conditions,'',10);
//        q($tags);
//        q($rs);
        Tpl_Smarty::assign('tags',$tags);
        Tpl_Smarty::assign('data',$rs[0]);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-1.php.tpl');

    }

    static function spaceItemListEdit()
    {
        if(!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'space_item_id' => 'int',
                'space_pedia_id' => 'int',
                'item_name' => 'string',
                'size' => 'int',
                'min_price' => 'int',
                'max_price' => 'int',
                'min_people' => 'int',
                'max_people' => 'int',
                'des' => 'html',
                'contacts' => 'string',
                'phone' => 'string',
                'email' => 'string',
            ), $_REQUEST['data']);
//            q($request);
            $data_space_item = array();
            $data_space_item['id'] = $request['space_item_id'];
            $data_space_item['item_name'] = $request['item_name'];
            $data_space_item['size'] = $request['size'];
            $data_space_item['min_price'] = $request['min_price'];
            $data_space_item['max_price'] = $request['max_price'];
            $data_space_item['min_people'] = $request['min_people'];
            $data_space_item['max_people'] = $request['max_people'];
            $data_space_item['des'] = $request['des'];
            $data_space_item['contacts'] = $request['contacts'];
            $data_space_item['phone'] = $request['phone'];
            $data_space_item['email'] = $request['email'];
//            q($data_space_item);
//            q($_REQUEST['space_pedia_id']);
            $rs = Data_Mysql_Table_Space_Item::update($data_space_item);
            if($rs[0]>0) {
                Func_Header::to('修改成功！','/'.Core::$urls['package'].Core::$urls['route'].'space_item_list?space_pedia_id='.$request['space_pedia_id']);
            }else{
                Func_Header::back('修改失败');
            }
        }

        $rs = Data_Mysql_Table_Space_Item::select('{table}.*,{prefix}spacepedia.space_name',array('{table}.id = ?'=>$_REQUEST['space_item_id']),'',1,'{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id={prefix}spacepedia.id');
        $rs[0]['tags'] = json_decode($rs[0]['tags'],1);
        $tagids = array();
        foreach($rs[0]['tags'] as $k=>$v) {
            $tagids[] = $k;
        }
        $conditions[] = 'id IN ('.implode(',',$tagids).')';
        $tags = Data_Mysql_Table_Demand_Tag::select('id,tag_value',$conditions,'',10);
//        q($tags);
//        q($rs);
        Tpl_Smarty::assign('tags',$tags);
        Tpl_Smarty::assign('data',$rs[0]);
//        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-1.php.tpl');
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-2.php.tpl');

    }


    static function spaceItemTagEdit()
    {
        Core::output('');
        if(!empty($_REQUEST['is_submit'])) {
            $_REQUEST['attr_new'] = json_decode($_REQUEST['attr_new'],1);
            $request = Func_Input::filter(array(
                'space_item_id' => 'int',
                'data_i' => 'array',
                'tags'=>'array',
            ), $_REQUEST);
            foreach($request['tags'] as $tk=>$tv){
                //添加标签
                $tags_id=Api_Demand_Offer_Check_Demand_Tag::getTagID($tv);
                if($tags_id){
                    $request['data_i']['tags'][$tags_id]=1;
                }else{
                    continue;
                }
            }
            $data_space_item = array();
            $data_space_item['tags'] = $request['data_i']['tags'];
            $rs = Data_Mysql_Table_Space_Item::update(array('id'=>$request['space_item_id']),$data_space_item);
            if($rs>0) {
                Func_Output::json('success','','修改成功');
            }else{
                Func_Output::json('error','','修改失败');
            }
        }
        //展示子空间标签数据页面
        $rs = Data_Mysql_Table_Space_Item::select('id,tags',array('id'=>$_REQUEST['space_item_id']));
        $rs[0]['tags'] = json_decode($rs[0]['tags'],1);
        $tags = array_keys($rs[0]['tags']);
//        q($tags);
        $conditions_tag[] = 'id IN ('.implode(',',$tags).')';
        $tags_value = Data_Mysql_Table_Demand_Tag::select('id,tag_value',$conditions_tag,'',10);
        Tpl_Smarty::assign('space_item_id',$_REQUEST['space_item_id']);
        Tpl_Smarty::assign('tags_value',$tags_value);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-3.php.tpl');
    }


}