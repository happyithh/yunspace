<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/10/8
 * Time: 15:01
 * 文创项目
 */
class OA_WinChance
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'winchance_list' : $_REQUEST['action'];
        switch($action){
            case 'winchance_list':
                self::handleWinchanceList();
                break;
            case 'add':
                self::handleWinchanceDetail();
                break;
            case 'is_submit':
                self::handleIsSubmit();
                break;
            case 'edit':
                self::handleWinchanceDetail();
                break;
            case 'delete':
                self::handleDelete();
                break;
            case 'update_status':
                self::handleChangeStatus();
                break;
            case 'convert_baike':
                self::handleConvertBaike();
                break;
            case 'export':
                self::handleWinchanceExport();
                break;
           default:
                Func_Header::notFound();
                break;
        }
//        if($action == 'winchance_list') {
//            self::handleWinchanceList();
//        } elseif ($action == 'add') {
//            self::handleWinchanceDetail();
//        } elseif ($action == 'is_submit') {
//            self::handleIsSubmit();
//        } elseif ($action == 'edit') {
//            self::handleWinchanceDetail();
//        } elseif ($action == 'delete') {
//            self::handleDelete();
//        } elseif ($action == 'update_status') {
//            self::handleChangeStatus();
//        }elseif($action=="convert_baike"){
//            self::handleConvertBaike();
//        }
    }


    //文创项目列表页
    static function handleWinchanceList()
    {

        $conditions = array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'resource_name' => 'string',
                'yun_principal' => 'int',
                'category' => 'int',
                'manifestation' => 'string',
                'operation_range' => 'string',
                'cooperating_state' => 'string',
                'cooperating_mode' => 'string',
                'tags_info' => 'string',
                'area' => 'int',
            ), $_REQUEST['search']);

//            q($search);
            //文章标题或ID筛选
            if (!empty($search['resource_name'])) {
                if (is_numeric($_REQUEST['search']['resource_name'])) {
                    $conditions['id=?'] = $search['resource_name'];
                } else {
                    $conditions['resource_name=?'] = $search['resource_name'];
                }
            }
            //云负责人
            if (!empty($search['yun_principal'])) {
                $conditions['yun_principal=?'] = $search['yun_principal'];
            }
            //作者筛选
//            if (!empty($search['author'])) {
//                $conditions['author'] = $search['author'];
//            }
//            //文章状态筛选
//            if (!empty($search['status'])) {
//                $is_status = $search['status'];
//                switch ($is_status) {
//                    case -1:
//                        $conditions['status = ?'] = -1;
//                        break;
//                    case 1:
//                        $conditions['status = ?'] = 1;
//                        break;
//                    default :
//                        '';
//                        break;
//                }
//            }

            //类别筛选
            if (!empty($search['category'])) {
                $conditions['category=?'] = $search['category'];
            }
            //表现形式
            if (!empty($search['manifestation'])) {
                $conditions['manifestation=?'] = $search['manifestation'];
            }
            //运营范围
            if (!empty($search['operation_range'])) {
                $conditions['operation_range=?'] = $search['operation_range'];
            }
            //合作状态
            if (!empty($search['cooperating_state'])) {
                $conditions['cooperating_state=?'] = $search['cooperating_state'];
            }
            //合作模式
            if (!empty($search['cooperating_mode'])) {
                $conditions['cooperating_mode=?'] = $search['cooperating_mode'];
            }
            //关键词
            if (!empty($search['tags_info'])) {
                $conditions['tags_info'][] = $search['tags_info'];
            }
            //面积
            if (!empty($search['area'])) {
                $conditions['area=?'] = $search['area'];
            }
//            //创建时间筛选
//            if (!empty($search['start_time']) && !empty($search['end_time'])) {
//                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
//                    Func_Header::back('请正确选择时间范围！！');
//                } else {
//                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
//                }
//            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
//                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
//            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
//                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
//            }
        }
//        Q($conditions);
        //tab标签筛选状态
//        if (!empty($_REQUEST['search'])) {
//            $search_url = '&search[title]='.$search['title'].'&search[author]='.$search['author'].'&search[category_id]='.$search['category_id'].'&search[status]='.$search['status'].'&search[start_time]='.$search['start_time'].'&search[end_time]='.$search['end_time'];
//            Tpl_Smarty::assign('urls', $search_url);
//        }
//        Data_Mysql_Table_Winchance::rebuildIndex();
//        Data_Mysql_Table_Winchance::debug(1);
        $order = 'ORDER BY create_time desc';
        $rs = Data_Mysql_Table_Winchance::page(0, 10, 'id,title,resource_name,yun_principal,category,manifestation,operation_range,cooperating_state,cooperating_mode,conform_crowd,tags_info,area', $conditions, $order);
//        Q(3);
        $category = Data_Mysql_Table_Winchance::$category;
        $yun_principal = Data_Mysql_Table_Winchance::$yun_principal;
        $manifestation = Data_Mysql_Table_Winchance::$manifestation;
        $city_array = Data_Mysql_Table_Winchance::$citys;
        $area_array = Data_Mysql_Table_Winchance::$area_array;
        $cooperating_state_array = Data_Mysql_Table_Winchance::$cooperating_state_array;
        $cooperating_mode_array = Data_Mysql_Table_Winchance::$cooperating_mode_array;
        if($rs['rows']){
            foreach($rs['rows'] as $k=>$v){
                $rs['rows'][$k]['yun_principal'] = $yun_principal[$v['yun_principal']];
                $rs['rows'][$k]['category'] = $category[$v['category']];
                $rs['rows'][$k]['area'] = $area_array[$v['area']];
                $rs['rows'][$k]['tags_info'] = implode(',',json_decode($v['tags_info'],1));
            }
        }


        Tpl_Smarty::assign('category', $category);
        Tpl_Smarty::assign('yun_principal', $yun_principal);
        Tpl_Smarty::assign('manifestation', $manifestation);
        Tpl_Smarty::assign('city_array', $city_array);
        Tpl_Smarty::assign('area_array', $area_array);
        Tpl_Smarty::assign('cooperating_state_array', $cooperating_state_array);
        Tpl_Smarty::assign('cooperating_mode_array', $cooperating_mode_array);
        Tpl_Smarty::assign('data', $rs);
        Tpl_Smarty::display('OA_Static', 'winchance/winchance_list.tpl');
    }


    //编辑和添加
    static function handleWinchanceDetail()
    {

        $request = Func_Input::filter(array(
                    'id' => 'int'
                ));
        $_data = array();
        if (!empty($request['id'])) {
            $data = Data_Mysql_Table_Winchance::select('*', array('id =?' => $request['id']), '', 1);
            if (!empty($data[0])) {
                $_data = Data_Mysql_Table_Winchance::rowFormat($data[0]);
                $_data['id'] = $data[0]['id'];

            } else {
                Func_Header::back('没有相关数据！');
            }
        }
        $status = Data_Mysql_Table_Winchance::$status;
        $category = Data_Mysql_Table_Winchance::$category;
        $yun_principal = Data_Mysql_Table_Winchance::$yun_principal;
        $resource_form = Data_Mysql_Table_Winchance::$resource_form;
        $manifestation = Data_Mysql_Table_Winchance::$manifestation;
        $city_array = Data_Mysql_Table_Winchance::$citys;
        $authorization_money = Data_Mysql_Table_Winchance::$authorization_money;
        $area_array = Data_Mysql_Table_Winchance::$area_array;
        $life_array = Data_Mysql_Table_Winchance::$life_array;
        $materiel = Data_Mysql_Table_Winchance::$materiel;
        $cooperating_state_array = Data_Mysql_Table_Winchance::$cooperating_state_array;
        $price_category_array = Data_Mysql_Table_Winchance::$price_category_array;
        $cooperating_mode_array = Data_Mysql_Table_Winchance::$cooperating_mode_array;
        $yunying_team_array = Data_Mysql_Table_Winchance::$yunying_team_array;

        Tpl_Smarty::assign('category', $category);
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('yun_principal', $yun_principal);
        Tpl_Smarty::assign('resource_form', $resource_form);
        Tpl_Smarty::assign('manifestation', $manifestation);
        Tpl_Smarty::assign('city_array', $city_array);
        Tpl_Smarty::assign('authorization_money', $authorization_money);
        Tpl_Smarty::assign('area_array', $area_array);
        Tpl_Smarty::assign('life_array', $life_array);
        Tpl_Smarty::assign('materiel', $materiel);
        Tpl_Smarty::assign('cooperating_state_array', $cooperating_state_array);
        Tpl_Smarty::assign('price_category_array', $price_category_array);
        Tpl_Smarty::assign('cooperating_mode_array', $cooperating_mode_array);
        Tpl_Smarty::assign('yunying_team_array', $yunying_team_array);
        Tpl_Smarty::assign('_data', $_data);
        Tpl_Smarty::display('OA_Static', 'winchance/winchance_edit.tpl');
    }


    //提交文创
    static function handleIsSubmit()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'title' => 'string',
            'marketing_title' => 'string',
            'author' => 'string',
            'status' => 'int',
            'media' => 'array',
            'attr' => 'array',
            'tags_info' => 'array',
            'accessory' => 'array',
            'order_lv' => 'int',
            'category' => 'int',
            'resource_name'=>'string', //资源的名词就是Ip名词
            'yun_principal'=>'int',//云负责人
            'manifestation'=>'string', //表现形式
            'operation_range'=>'string', //运营范围
            'cooperating_state'=>'string',//合作状态
            'cooperating_mode'=>'string',//合作模式
            'conform_crowd'=>'string',//符合人群
            'area'=>'int',  //面积
            'remarks'=>'text',
            'url_referer'=>'string',
        ));

        $files = Func_Input::filter(array(
            'accessory' => 'array',
        ), $_FILES);

        if (empty($request['title'])) {
            Func_Header::back('标题不能为空！');
        }
        if (empty($request['marketing_title'])) {
            Func_Header::back('副标题不能为空！');
        }
        if (empty($request['tags_info'][0])) {
            Func_Header::back('标签不能为空！');
        }
        if(mb_strwidth($request['tags_info'][0],'UTF-8')>40) {
            Func_Header::back('标签字数太长！');
        }

        if (!empty($files['accessory']['name'])) {
            preg_match_all('/\.(.*)/',$files['accessory']['name'],$match);
            if(!empty($match[0][0])) {
                $type = $match[0][0];
                if($type !== '.pdf') {
                    Func_Header::back('请上传PDF格式的文件！');
                }
            }
            $intelligence = Func_Upload::file('accessory');
            if (is_array($intelligence) && $intelligence['code'] == 0) {
                Func_Header::back($intelligence['msg']);
            } else {
                $request['accessory']['name'] = $intelligence;
            }
            $request['accessory']['size'] = $files['accessory']['size'];
            $request['accessory']['filename'] = $files['accessory']['name'];
        }
//        if (empty($request['accessory']['filename']) && empty($request['accessory']['name'])) {
//            Func_Header::back('必须上传文件！');
//        }
//        if(!empty($request['accessory']['name'])) {
//            preg_match_all('/\.(.*)/',$request['accessory']['name'],$match);
//            if(!empty($match[0][0])) {
//                $type = $match[0][0];
//                if($type !== '.pdf') {
//                    Func_Header::back('请上传PDF格式的文件！');
//                }
//            }
//        }
        if(empty($request['order_lv'])) {
            $request['order_lv'] = 0;
        }

        $data = array();
        $data['tags_info'] = $request['tags_info'];
        $data['title'] = $request['title'];
        $data['marketing_title'] = $request['marketing_title'];
        $data['author'] = $request['author'];
        $data['status'] = $request['status'];
        $data['attr'] = $request['attr'];
        $data['accessory'] = $request['accessory'];
        $data['order_lv'] = $request['order_lv'];
        $data['category'] = $request['category'];

        $data['resource_name'] = $request['resource_name'];
        $data['yun_principal'] = $request['yun_principal'];
        $data['manifestation'] = $request['manifestation'];
        $data['operation_range'] = $request['operation_range'];
        $data['cooperating_state'] = $request['cooperating_state'];
        $data['cooperating_mode'] = $request['cooperating_mode'];
        $data['conform_crowd'] = $request['conform_crowd'];
        $data['area'] = $request['area'];
        $data['remarks'] = $request['remarks'];

        unset($request['media']['$$']);
        $data['media'] = array_values($request['media']);
        if (!empty($request['id'])) {
            $data['id'] = $request['id'];
        } else {
            $data['create_time'] = time();
        }
        $rows = Data_Mysql_Table_Winchance::update($data);
        if ($rows > 0) {
            Func_Header::to(' 操作成功！',empty($request['url_referer'])?Core::$urls['path']:$request['url_referer']);
        } else {
            Func_Header::to('操作失败！', Core::$urls['path']);
        }

    }
    

    //删除一条文创项目
    static function handleDelete()
    {

        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $conditions['id'] = $_REQUEST['id'];
        $back_rs = Data_Mysql_Table_Winchance::delete($conditions, "{table}");
        if (!empty($back_rs)) {
            Func_Header::to('删除成功！！', Core::$urls['path']);
        } else {
            Func_Header::back('删除失败！！');
        }
    }


    static function handleChangeStatus()
    {
        Core::output('');
        if (isset($_REQUEST['status'])) {
            $request = Func_Input::filter(array(
                'status' => 'int',
                'id' => 'int'
            ));
            if (!$request['id']) {
                Func_Output::json('error', '', '缺少参数！');
            }

            $r = Data_Mysql_Table_Winchance::query("UPDATE {table} SET status = ? WHERE id = ?", array($request['status'], $request['id']), 1);

            if (empty($r[0])) {
                Func_Output::json('error', '', '修改失败！');
            } else {
                Func_Output::json('success', '', ' 修改成功！');
            }
            Func_Output::json('error', '', '发生错误！');
        }
    }
    //导出
    static function handleWinchanceExport(){
//        Q($_REQUEST,11);
        Core::$debug=0;
        error_reporting(0);
        $conditions = array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'resource_name' => 'string',
                'yun_principal' => 'int',
                'category' => 'int',
                'manifestation' => 'string',
                'operation_range' => 'string',
                'cooperating_state' => 'string',
                'cooperating_mode' => 'string',
                'tags_info' => 'string',
                'area' => 'int',
            ), $_REQUEST['search']);

//            q($search);
            //文章标题或ID筛选
            if (!empty($search['resource_name'])) {
                if (is_numeric($_REQUEST['search']['resource_name'])) {
                    $conditions['id=?'] = $search['resource_name'];
                } else {
                    $conditions['resource_name=?'] = $search['resource_name'];
                }
            }
            //云负责人
            if (!empty($search['yun_principal'])) {
                $conditions['yun_principal=?'] = $search['yun_principal'];
            }

            //类别筛选
            if (!empty($search['category'])) {
                $conditions['category=?'] = $search['category'];
            }
            //表现形式
            if (!empty($search['manifestation'])) {
                $conditions['manifestation=?'] = $search['manifestation'];
            }
            //运营范围
            if (!empty($search['operation_range'])) {
                $conditions['operation_range=?'] = $search['operation_range'];
            }
            //合作状态
            if (!empty($search['cooperating_state'])) {
                $conditions['cooperating_state=?'] = $search['cooperating_state'];
            }
            //合作模式
            if (!empty($search['cooperating_mode'])) {
                $conditions['cooperating_mode=?'] = $search['cooperating_mode'];
            }
            //关键词
            if (!empty($search['tags_info'])) {
                $conditions['tags_info'][] = $search['tags_info'];
            }
            //面积
            if (!empty($search['area'])) {
                $conditions['area=?'] = $search['area'];
            }
        }
        $order = 'ORDER BY create_time desc';
        $rs = Data_Mysql_Table_Winchance::select('*', $conditions, $order,2000);
            $status = Data_Mysql_Table_Winchance::$status;
            $category = Data_Mysql_Table_Winchance::$category;
            $yun_principal = Data_Mysql_Table_Winchance::$yun_principal;
            $area_array = Data_Mysql_Table_Winchance::$area_array;
            $life_array = Data_Mysql_Table_Winchance::$life_array;
        if($rs){
            foreach($rs as $k=>$v){
                $rs[$k]['tags_info'] = implode(',',json_decode($v['tags_info'],1));
                $v['attr'] = json_decode($v['attr'],1);
                $rs[$k]['attr']  =  $v['attr'] ;
                $rs[$k]['area'] = $area_array[$v['area']]."平米";
                $rs[$k]['status'] =$status[$v['status']];
                $rs[$k]['attr']['年限'] =$life_array[$v['attr']['年限']];
                $rs[$k]['yun_principal']  = $yun_principal[$v['yun_principal']];
                $rs[$k]['category']  = $category[$v['category']];
            }
        }
//        Q($rs);
        $cols = array(
                "上线顺序编号",
                "资源的名称",
                "云负责人",
                "资源来自国家",
                "IP所属单位",
                "分类",
                "表现形式",
                "运营范围",
                "授权金",
                "年限",
                "物料",
                "合作状态",
                "价格分类",
                "合作模式",
                "符合人群",
                "关键词",
                "面积",
                "授权费",
                "搭建费",
                "道具费",
                "运营费",
                "运营团队所属国家",
                "档期",
                "上线网站标题",
                "概括活动的一句话",
//                "是否有资料",
//                "前期接洽",
//                "合作意向",
//                "代理协议",
//                "开始合作时间",
//                "推广计划",
                "联系人",
                "职位",
                "邮箱",
                "联系电话",
                "被授权公司",
                "策展人",
                "备注"

        );
        $list = array();
        foreach($rs as $k=>$v){
            $list[$k][] = $v['id'];
            $list[$k][] = $v['resource_name'];
            $list[$k][] = $v['yun_principal'];
            $list[$k][] = $v['attr']['资源来自国家'];
            $list[$k][] = $v['attr']['IP所属单位'];
            $list[$k][] = $v['category'];
            $list[$k][] = $v['manifestation'];
            $list[$k][] = $v['operation_range'];
            $list[$k][] = $v['attr']['授权金'];
            $list[$k][] = $v['attr']['年限'];
            $list[$k][] = $v['attr']['物料'];
            $list[$k][] = $v['cooperating_state'];
            $list[$k][] = $v['attr']['价格分类'];
            $list[$k][] = $v['cooperating_mode'];
            $list[$k][] = $v['conform_crowd'];
            $list[$k][] = $v['tags_info'];
            $list[$k][] = $v['area'];
            $list[$k][] = $v['attr']['授权费'];
            $list[$k][] = $v['attr']['搭建费'];
            $list[$k][] = $v['attr']['道具费'];
            $list[$k][] = $v['attr']['运营费'];
            $list[$k][] = $v['attr']['运营团队所属国家'];
            $list[$k][] = $v['attr']['档期'];
            $list[$k][] = $v['title'];
            $list[$k][] = $v['marketing_title'];
            $list[$k][] = $v['attr']['联系人'];
            $list[$k][] = $v['attr']['职位'];
            $list[$k][] = $v['attr']['邮箱'];
            $list[$k][] = $v['attr']['联系电话'];
            $list[$k][] = $v['attr']['被授权公司'];
            $list[$k][] = $v['attr']['策展人'];
            $list[$k][] = $v['remarks'];
        }
        Func_Csv::writeRow($cols,$list,"IP项目数据库");
//        Q($rs);
    }

    //一键转换为百科
    static function handleConvertBaike(){
        $data=Data_Mysql_Table_Winchance::select('*','','',150);
        foreach($data as $k=>$v){
            if(!empty($v['media'])){
                $v['media']=json_decode($v['media'],1);
            }
            if(!empty($v['attr'])){
                $v['attr']=json_decode($v['attr'],1);
            }
            if(!empty($v['tags_info'])){
                $v['tags_info']=json_decode($v['tags_info'],1);
            }
            if(!empty($v['accessory'])){
                $v['accessory']=json_decode($v['accessory'],1);
            }
            $baike['space_name']=$v['title'];
            $baike['category_id']=200;
            $baike['attr']['营销标题']=$v['marketing_title'];
            $baike['attr']['特色标签']=empty($v['tags_info'][0])?"":$v['tags_info'][0];
            $baike['other_demo']['作者']=$v['author'];
            $baike['other_demo']['下载次数']=$v['download_num'];
            $baike['other_demo']['来源']=empty($v['attr']['来源'])?'':$v['attr']['来源'];
            $baike['other_demo']['面积']=empty($v['attr']['面积'])?'':$v['attr']['面积'];
            $baike['other_demo']['适用人群']=empty($v['attr']['适用人群'])?'':$v['attr']['适用人群'];
            $baike['other_demo']['预算上限']=empty($v['attr']['预算上限'])?'':$v['attr']['预算上限'];
            $baike['other_demo']['预算下限']=empty($v['attr']['预算下限'])?'':$v['attr']['预算下限'];
            $baike['other_demo']['附件']=empty($v['accessory'])?'':$v['accessory'];
            $baike['media']=$v['media'];
            $baike['status']=$v['status'];
            if($v['order_lv']==3 || $v['order_lv']==2 || $v['order_lv']==1){
                $baike['level']=4;
            }elseif($v['order_lv']==-1 || $v['order_lv']==-2 || $v['order_lv']==-3){
                $baike['level']=-1;
            }else{
                $baike['level']=0;
            }
            //1.放入百科表
            $rs=Data_Mysql_Table_Spacepedia::insert($baike);
            if(!empty($rs[0])){
                //2.放入历史表中一条数据
                $history['object_id']=$rs[0];
                $history['admin_id']=$_SESSION['administrator']['id'];
                $history['status']=1;
                $history['data_backup']=$baike;
                $history['data_backup']['space_id']=$rs[0];
                Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->insert($history);
            }
        }
    }
}