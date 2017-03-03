<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/16
 * Time: 13:32
 */
class OA_Raiders_Info
{
    static function handle($cid=0)
    {

        $type = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($type) {
            case 'list':
                self::handelList($cid);
                break;
            case 'edit':
                self::handleRaidersEditForm();
                break;
            case 'add':
                self::handleRaidersEditForm();
                break;
            case 'is_submit':
                self::handleRaidersFormSubmit();
                break;
            case 'delete':
                self::handleRaidersDelete();
                break;
            case 'update_category':
                self::handleRaidersCategory();
                break;
            case 'update_status':
                self::handleRaidersStatus();
                break;
            case 'update_pv':
                self::handleRaidersPageView();
                break;
            case 'update_baike_cid':
                //一键更新文章的baike_cid
                if(empty($_REQUEST['id'])){
                    $_REQUEST['id']=0;
                }
                $lastId = OA_Import_New::updateAllRaidersCategoryId($_REQUEST['id']);
                if($lastId){
                    Func_Header::to('','?action=update_baike_cid&id='.$lastId); 
                }else{
                    Func_Header::to('','?action=list'); 
                }
                break;
        }
    }

    //删除文章
    static function handleRaidersDelete()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $conditions['id'] = $_REQUEST['id'];
        $update_data=Data_Mysql_Table_Raiders_Info::select("id,update_id,space_ids", array('id'=>$_REQUEST['id']));
        $back_rs = Data_Mysql_Table_Raiders_Info::delete($conditions, "{table}");
        //判断此文章是否在更新表中
        if(!empty($update_data[0])){
            $update_rs = Data_Mysql_Table_Raiders_Info::subTable('_update')->delete(array('id'=>$update_data[0]['update_id']));
        }
        if (!empty($back_rs[0])) {
            //更新关联百科的文章总数
            if(!empty($update_data[0]['space_ids'])){
                $space_arr=json_decode($update_data[0]['space_ids'],1);
                $space_ids=explode(",",$space_arr);
                Api_Baike_Article_Count::updateAricleCountBySpaceIds($space_ids);
            }
            Func_Header::to(' 删除成功！！', Core::$urls['path']);
        } else {
            Func_Header::back('删除失败！！');
        }
    }


    //准备添加数据前的模板准备
    static function handleRaidersForm()
    {
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryname = self::getCatTree($cate);
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('category_name', $categoryname);

        //调出模板
        Tpl_Smarty::display('OA_Static', 'article/raiders_info_edit.tpl');

    }


    //修改信息
    static function handleRaidersEditForm()
    {
        $request =
            Func_Input::filter(array(
                    'id' => 'int'
                )
            );
        $_data = array();
        if (!empty($request['id'])) {
            $data = Data_Mysql_Table_Raiders_Info::select('*', array('id =?' => $request['id']), '', 1);
            if (!empty($data[0])) {
                $_data = Data_Mysql_Table_Raiders_Info::rowFormat($data[0]);
                $_data['id'] = $data[0]['id'];
            } else {
                Func_Header::back('没有相关数据！');
            }
        }
        // 获取百科分类
        $baike_category = Data_Mysql_Table_Spacepedia::$category_name;
        Tpl_Smarty::assign('baike_category',$baike_category);

        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = self::getCatTree($cate);
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('category_name', $categoryName);

        $vendorAttr = Data_Config_Vendor_Attr::get('attr');
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);
        Tpl_Smarty::assign('_data', $_data);
        Tpl_Smarty::display('OA_Static', 'raiders_candidate/raiders_info_edit_new.tpl');
    }


    //添加提交数据
    static function handleRaidersFormSubmit()
    {

        $request=Func_Input::filter(array(
            'raiders_id'=>'int',
            'data'=>'array',
        ));
        if(intval(date("H",strtotime($request['data']['create_time'])))<7){
            $request['data']['create_time']=date("Y-m-d",strtotime($request['data']['create_time']))." ".date("H:i:s");
        }

        $request['data']['create_time'] = strtotime($request['data']['create_time']);
        $update_data=Spacepedia_Case_Management::handleSubmitData($request['data']);

        if (!empty($request['raiders_id'])) {
            //更新文章
            $rs= Data_Mysql_Table_Raiders_Info::update(array("id"=>$request['raiders_id']),$update_data);
        } else {
            //添加文章
            $update_data['counter_view'] = mt_rand(36,68);
            $update_data['counter_praise'] = mt_rand(6,18);
            $update_data['from_where']=1;
            $rs= Data_Mysql_Table_Raiders_Info::insert($update_data);
            //更新关联百科的文章总数
            if(!empty($update_data['space_ids'])){
                $space_ids=explode(",",$update_data['space_ids']);
                Api_Baike_Article_Count::updateAricleCountBySpaceIds($space_ids);
            }
        }
        if (!empty($rs[0])) {
            if(!empty($request['raiders_id']) && !empty($update_data['cont'])){
                //清除缓存文件
                $clear_data['s_key']=$request['raiders_id'];
                $clear_data['subTable']='raiders_content';
                Api_Common_Cache::clearCacheByKey($clear_data);
            }
            $msg="操作成功!";
            if(strpos($update_data['cont'],'http://mmbiz.qpic.cn/mmbiz')){
                $msg="文章内容含有来自微信的图片!";
            }
            Func_Header::to(' '.$msg, Core::$urls['path']);
        } else {
            Func_Header::to('操作失败！', Core::$urls['path']);
        }


    }


    //二级栏目分类
    static function getCatTree($arr, $id = 0, $lev = 0)
    {
        $tree = array();
        foreach ($arr as $v) {
            if ($v['parent'] == $id) {
                $v['lev'] = $lev;
                $tree[] = $v;

                $tree = array_merge($tree, self::getCatTree($arr, $v['id'], $lev + 1));
            }
        }
        return $tree;
    }


    //活动攻略文章列表页
    static function handelList($cid=0)
    {
        $conditions = array();
        $cid_children = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
        if($cid==12){
            $conditions[] = '{table}.category_id in (' . implode(',', $cid_children) . ")";
        }elseif($cid==1){
            $conditions[] = '{table}.category_id not in (' . implode(',', $cid_children) . ")";
        }else{
            //云发现列表只显示id小于5500
            $conditions[] = '{table}.id < 5500 ';

        }
        //定义操作内容
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = self::getCatTree($cate);
        if($cid==12){
            foreach($categoryName as $k=>$v){
                if($v['id']==12 || $v['parent']==12){
                    $category_12[]=$v;
                }
            }
            Tpl_Smarty::assign('category_name', $category_12);
        }elseif($cid==1){
            foreach($categoryName as $k=>$v){
                if($v['id']!=12 && $v['parent']!=12){
                    $category_1[]=$v;
                }
            }
            Tpl_Smarty::assign('category_name', $category_1);
        }else{
            Tpl_Smarty::assign('category_name', $categoryName);
        }

        //定义文章状态
        $status = Data_Mysql_Table_Raiders_Info::$status;

        Tpl_Smarty::assign('status', $status);
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',                //文章标题
                'author' => 'string',                //作者
                'category_id' => 'int',                //栏目id
                'status' => 'int',                  //状态
                'end_time' => 'string',               //开始时间
                'start_time' => 'string',             //结束时间
            ), $_REQUEST['search']);

            //文章标题或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['title'] = $search['title'];
                }
            }
            //作者筛选
            if (!empty($search['author'])) {
                $conditions['author'] = $search['author'];
            }
            //栏目筛选
            if (!empty($search['category_id'])) {
                $sub_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($search['category_id']);
                $conditions[] = '{table}.category_id in (' . implode(',', $sub_id) . ")";
            }

            //文章状态筛选
            if (!empty($search['status'])) {
                $is_status = $search['status'];
                switch ($is_status) {
                    case -1:
                        $conditions['status = ?'] = -1;
                        break;
                    case 1:
                        $conditions['status = ?'] = 1;
                        break;
                    default :
                        '';
                        break;
                }
            }

            //创建时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
            }
        }

        //tab标签筛选状态
        $handle_type = empty($_REQUEST['handle_type']) ? 'all' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "hand_insert":
                $conditions['{table}.from_where = ? '] = 1;
                break;
            case "auto_insert":
                $conditions['{table}.from_where = ? '] = 2;
                break;
            case "deliver":
                $conditions['{table}.from_where = ? '] = 3;
                break;
            case "banner":
                $conditions['{table}.is_hot = ?'] =1;
                break;
            case "recommend":
                $conditions['{table}.is_good = ?'] = 1;
                break;
            case "all":
                break;
        }
        if (!empty($_REQUEST['search'])) {
            $search_url = '&search[title]='.$search['title'].'&search[author]='.$search['author'].'&search[category_id]='.$search['category_id'].'&search[status]='.$search['status'].'&search[start_time]='.$search['start_time'].'&search[end_time]='.$search['end_time'];
            Tpl_Smarty::assign('urls', $search_url);
        }

        $order = 'ORDER BY create_time desc';
        $rs = Data_Mysql_Table_Raiders_Info::page(0, 10, 'city,{table}.id,{table}.title,{table}.author,{table}.category_id,{table}.create_time,{table}.update_time,{table}.status', $conditions, $order);

        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('data', $rs);
        Tpl_Smarty::display('OA_Static', 'article/raiders_list.tpl');

    }

    //ajax修改所属栏目
    static function handleRaidersCategory()
    {
        Core::output('');
        if (isset($_REQUEST['category_id'])) {
            $request = Func_Input::filter(array(
                'category_id' => 'int',
                'id' => 'int'
            ));
            if (!$request['id']) {
                Func_Output::json('error', '', '缺少参数！');
            }

            $r = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} SET category_id = ? WHERE id = ?", array(
                $request['category_id'],
                $request['id']
            ), 1);

            if (empty($r[0])) {
                Func_Output::json('error', '', '修改失败！');
            } else {
                Func_Output::json('success', '', ' 修改成功！');
            }
            Func_Output::json('error', '', '发生错误！');
        }
    }

    //ajax修改状态
    static function handleRaidersStatus()
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

            $r = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} SET status = ? WHERE id = ?", array(
                $request['status'],
                $request['id']
            ), 1);

            if (empty($r[0])) {
                Func_Output::json('error', '', '修改失败！');
            } else {
                Func_Output::json('success', '', ' 修改成功！');
            }
            Func_Output::json('error', '', '发生错误！');
        }
    }

    //ajax更新pv
    static function handleRaidersPageView()
    {
        Core::output('');

        if(isset($_REQUEST['id'])){
            $request = Func_Input::filter(array(
                'id' => 'int'
            ));

            if (!$request['id']) {
                Func_Output::json('error', '', '缺少参数！');
            }

            $condition['id = ?'] = array($request['id']);
            $counter_view = mt_rand(36, 68);
            $counter_praise = mt_rand(4,9);
            $r = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} SET counter_view = counter_view+?, counter_praise = counter_praise+? WHERE id = ?", array(
                $counter_view,
                $counter_praise,
                $request['id'],
            ), 1);

            if (empty($r[0])) {
                Func_Output::json('error', '', '修改失败！');
            } else {
                Func_Output::json('success', '', ' 修改成功！');
            }
            Func_Output::json('error', '', '发生错误！');
        }
    }

    //活动攻略数据提交处理
    static function handleSubmitData(){
        $request = Func_Input::filter(array(
            'id' => 'int',
            'title' => 'string',
            'author' => 'string',
            'status' => 'int',
            'category_id' => 'int',
            'des' => 'string',
            'cont' => 'html',
            'tags_info' => 'array',
            'create_time' => 'string',
            'accessory' => 'array',
            'detail_des' => 'array',
            'logo' => 'string',
            'hide_logo' => 'int',
            'is_hot' => 'int',
            'is_good' => 'int',
            'space_ids' => 'string',
        ));

        $files = Func_Input::filter(array(
            'accessory' => 'array',
            'logo_f' => 'array',
        ), $_FILES);
//        攻略文章的logo缩略图
        if (!empty($files['logo_f']['name'])) {
            $logo = Func_Upload::image('logo_f');
            if (!empty($logo)) {
                $request['logo_f'] = $logo;
            }
        }

        $ss = Data_Mysql_Table_Raiders_Info::$category_name;
        foreach ($ss as $k => $v) {
            if ($request['category_id'] == $v['id']) {
                if ($v['parent'] == 12 || $v['id'] == 12) {
                    $files = Func_Input::filter(array(
                        'accessory' => 'array',
                    ), $_FILES);
                    if (!empty($files['accessory']['name'])) {

                        if (!empty($files['accessory']['name'])) {
                            $intelligence = Func_Upload::file('accessory');
                            if (is_array($intelligence) && $intelligence['code'] == 0) {
                                Func_Header::back($intelligence['msg']);
                            } else {
                                $request['accessory']['name'] = $intelligence;
                            }
                        }
                        $request['accessory']['size'] = $files['accessory']['size'];
                        $request['accessory']['filename'] = $files['accessory']['name'];

                    }
                    if (empty($request['accessory']['filename']) && empty($files['accessory']['name'])) {
                        Func_Header::back('必须上传文件！');
                    }
                }
            }
        }
        if (empty($request['title'])) {
            Func_Header::back('标题不能为空！');
        }
        if (empty($request['category_id'])) {
            Func_Header::back('请选择类别！');
        }
        if (empty($request['tags_info'])) {
            Func_Header::back('关键词不能为空！');
        }
        if (empty($request['des'])) {
            Func_Header::back('简介不能为空！');
        }
        if (empty($request['cont'])) {
            Func_Header::back('请填写文章内容！');
        }

        $data = array();
        $data['tags_info'] = $request['tags_info'];
        $data['title'] = $request['title'];
        $data['author'] = $request['author'];
        $data['status'] = $request['status'];
        $data['category_id'] = $request['category_id'];
        $data['des'] = $request['des'];
        $data['cont'] = $request['cont'];
        $data['accessory'] = $request['accessory'];
        $data['detail_des'] = $request['detail_des'];
        $data['space_ids'] = $request['space_ids'];
        if(!empty($request['hide_logo'])) {
            $data['hide_logo'] = $request['hide_logo'];
        }else{
            $data['hide_logo'] = 0;
        }
        if(!empty($request['is_hot'])) {
            $data['is_hot'] = $request['is_hot'];
        }else{
            $data['is_hot'] = 0;
        }
        if(!empty($request['is_good'])) {
            $data['is_good'] = $request['is_good'];
        }else{
            $data['is_good'] = 0;
        }

        //文章的logo
        if (!empty($request['logo_f'])) {
            $data['logo'] = $request['logo_f'];
        }else{
            $data['logo'] = $request['logo'];
        }
        if (empty($data['logo'])) {
            preg_match_all("/\<img.*?src\=\"(.*?)\"[^>]*>/i", $request['cont'], $match);
            if (!empty($match[1][0])) {
                //将图片移动到upload下对应的日期文件夹下，Page_Site_Global::displayMedia才能生效
                Func_Upload::copy(Core::virtualPath('static/editor/') . substr($match[1][0], 15), substr($match[1][0], 31));
                $data['logo'] = '/upload/' . substr($match[1][0], 31);
            }
        }


        if (!empty($request['id'])) {
            $data['id'] = $request['id'];
        } else {
            $data['create_time'] = time();
            $data['counter_view'] = mt_rand(36,68);
            $data['counter_praise'] = mt_rand(6,18);
        }
        if(!empty($request['create_time'])) {
            $data['create_time'] = strtotime($request['create_time']);
        }
        return $data;
    }
}