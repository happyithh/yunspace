<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/9/7
 * Time: 15:44
 */
class OA_Raiders_Candidate
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'raiders_candidate_list' : $_REQUEST['action'];
        if($action == 'raiders_candidate_list') {
            self::handleRaidersCandidateList();
        } elseif ($action == 'check') {
            if (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'repeat') {
                self::handleRaidersCandidateRepeat();
            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'less') {
                self::handleRaidersCandidateLess();
            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'invalid') {
                self::handleRaidersCandidateInvalid();
            } else {
                self::handleCheck();
            }
        } elseif ($action == 'detail') {
            self::handleRaidersCandidateDetail();
        } elseif ($action == 'is_submit') {
            self::handleIsSubmit();
        } elseif ($action == 'raiders_detail') {
            self::handleRaidersDetail();
        }
    }

    static function handleRaidersCandidateList() {

        $conditions = array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'from_where' => 'string',
                'status' => 'int',
                'create_end_time' => 'string',
                'create_start_time' => 'string',
                'update_end_time' => 'string',
                'update_start_time' => 'string',
                'username' => 'string',
            ), $_REQUEST['search']);

            //来源筛选
            if (!empty($search['from_where'])) {
                $conditions['from_where'] = $search['from_where'];
            }
            //操作人筛选
            if (!empty($search['username'])) {
                $conditions['username'] = $search['username'];
            }
//            q($conditions);
            //入库时间筛选
            if (!empty($search['create_start_time']) && !empty($search['create_end_time'])) {
                if (strtotime($search['create_start_time']) > strtotime($search['create_end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['create_start_time']), strtotime($search['create_end_time']));
                }
            } elseif (!empty($search['create_start_time']) && empty($search['create_end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['create_start_time']);
            } elseif (empty($search['create_start_time']) && !empty($search['create_end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['create_end_time']);
            }
            //操作时间筛选
            if (!empty($search['update_start_time']) && !empty($search['update_end_time'])) {
                if (strtotime($search['update_start_time']) > strtotime($search['update_end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.update_time between ? and ?'] = array(strtotime($search['update_start_time']), strtotime($search['update_end_time']));
                }
            } elseif (!empty($search['update_start_time']) && empty($search['update_end_time'])) {
                $conditions['{table}.update_time > ?'] = strtotime($search['update_start_time']);
            } elseif (empty($search['update_start_time']) && !empty($search['update_end_time'])) {
                $conditions['{table}.update_time < ?'] = strtotime($search['update_end_time']);
            }
        }
        //tab标签筛选状态
        $handle_type = empty($_REQUEST['handle_type']) ? 'waiting' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "pass":
                $conditions['{table}.status = ? '] = 1;
                break;
            case "repeat":
                $conditions['{table}.status = ? '] = 2;
                break;
            case "waiting":
                $conditions['{table}.status = ? '] = 3;
                break;
            case "invalid":
                $conditions['{table}.status = ? '] = 4;
                break;
            case "less":
                $conditions['{table}.status = ? '] = 5;
                break;
        }
//        q($conditions);

        if (!empty($_REQUEST['search'])) {
            $search_url = '&search[create_start_time]='.$search['create_start_time'].'&search[create_end_time]='.$search['create_end_time'].'&search[update_start_time]='.$search['update_start_time'].'&search[update_end_time]='.$search['update_end_time'].'&search[username]='.$search['username'];
//            q($search_url);
            Tpl_Smarty::assign('urls', $search_url);
        }

        $cols = array('id,title,des,cont,username,create_time,update_time,status,from_where');
        $order = 'ORDER BY {table}.update_time DESC';
        $candidate = Data_Mysql_Table_Raiders_Candidate::page(0, 0, $cols, $conditions, $order, '{table}');

        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('_data', $candidate);
        Tpl_Smarty::display('OA_Static', 'raiders_candidate/raiders_candidate_list.tpl');
    }

    //处理初始页
    static function handleCheck()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $data = Data_Mysql_Table_Raiders_Candidate::select('*', array('id' => $_REQUEST['id']), '', 1);
//        q($data);
        $conditions = array();
        if (!empty($data[0]['title'])) {
            $conditions['title'] = $data[0]['title'];
            $rs = Data_Mysql_Table_Raiders_Info::select('id,title,author,des,status,update_time', $conditions, '', 5, '{table}');
        }
        if (!empty($rs)) {
            Tpl_Smarty::assign('p_data', $rs);
        }
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display('OA_Static', 'raiders_candidate/raiders_candidate_check.tpl');

    }

    //标记为重复
    static function handleRaidersCandidateRepeat()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        //更新数据的状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 2,
            'username' =>$_SESSION['administrator']['username'],
            'update_time' =>time(),
        );
        $update_rs = Data_Mysql_Table_Raiders_Candidate::update($condition, $data);
        if (!empty($update_rs)) {
            Func_Header::to(' 标记成功！', Core::$urls['path']);
        }
        Func_Header::back('标记失败，请重试！');

    }

    //标记为无效
    static function handleRaidersCandidateInvalid()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        //更新数据的状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 4,
            'username' =>$_SESSION['administrator']['username'],
            'update_time' =>time(),
        );
        $update_rs = Data_Mysql_Table_Raiders_Candidate::update($condition, $data);
        if (!empty($update_rs)) {
            Func_Header::to(' 标记成功！', Core::$urls['path']);
        }
        Func_Header::back('标记失败，请重试！');

    }

    //标记为不完整
    static function handleRaidersCandidateLess()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        //更新数据的状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 5,
            'username' =>$_SESSION['administrator']['username'],
            'update_time' =>time(),
        );
        $update_rs = Data_Mysql_Table_Raiders_Candidate::update($condition, $data);
        if (!empty($update_rs)) {
            Func_Header::to(' 标记成功！', Core::$urls['path']);
        }
        Func_Header::back('标记失败，请重试！');

    }

    //采集数据的详情页
    static function handleRaidersCandidateDetail()
    {
        $request = Func_Input::filter(array(
                    'id' => 'int'
                ));
        $_data = array();
        if (!empty($request['id'])) {
            $data = Data_Mysql_Table_Raiders_Candidate::select('*', array('id =?' => $request['id']), '', 1);
            if (!empty($data[0])) {
                $_data = Data_Mysql_Table_Raiders_Candidate::rowFormat($data[0]);
                $_data['id'] = $data[0]['id'];
            } else {
                Func_Header::back('没有相关数据！');
            }
        }
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('category_name', $categoryName);

        $vendorAttr = Data_Config_Vendor_Attr::get('attr');

        Tpl_Smarty::assign('author', $_SESSION['administrator']['username']);
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);
        Tpl_Smarty::assign('_data', $_data);
        Tpl_Smarty::display('OA_Static', 'raiders_candidate/raiders_info_edit.tpl');

    }

    //采集数据提交
    static function handleIsSubmit()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'title' => 'string',
            'author' => 'string',
            'status' => 'int',
            'category_id' => 'int',
            'des' => 'string',
            'cont' => 'html',
//            'media' => 'array',
            //'city' => 'string',
            'tags_info' => 'array',
            'create_time' => 'string',
            'accessory' => 'array',
            'detail_des' => 'array',
            'logo' => 'string',
            'hide_logo' => 'int',
            'is_hot' => 'int',
            'is_good' => 'int',
        ));

        $files = Func_Input::filter(array(
            'accessory' => 'array',
            'logo_f' => 'array',
        ), $_FILES);
//        q($files);
//        攻略文章的logo缩略图
        if (!empty($files['logo_f']['name'])) {
            $logo = Func_Upload::image('logo_f');
            if (!empty($logo)) {
                $request['logo_f'] = $logo;
            }
        }
        $ss = Data_Mysql_Table_Raiders_Info::$category_name;
        foreach($ss as $k => $v){
            if($request['category_id'] == $v['id'] ){
                if($v['parent'] == 12 || $v['id'] == 12){
                    $files = Func_Input::filter(array(
                        'accessory' => 'array',
                    ), $_FILES);
                    if(!empty($files['accessory']['name'])){

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
                    if(empty($request['accessory']['filename']) && empty($files['accessory']['name'])) {
                        Func_Header::back('必须上传文件！');
                    }
                }
            }
        }
        if (empty($request['tags_info'][0])) {
            Func_Header::back('关键词不能为空！');
        }
        if (empty($request['title'])) {
            Func_Header::back('标题不能为空！');
        }
        if (empty($request['category_id'])) {
            Func_Header::back('请选择栏目！');
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
//        unset($request['media']['$$']);
//        $data['media'] = array_values($request['media']);
//        if (empty($data['logo'])) {
//            preg_match_all("/\<img.*?src\=\"(.*?)\"[^>]*>/i", $request['cont'], $match);
//            if (!empty($match[1][0])) {
//                //将图片移动到upload下对应的日期文件夹下，Page_Site_Global::displayMedia才能生效
//                Func_Upload::copy(Core::virtualPath('static/editor/') . substr($match[1][0], 15), substr($match[1][0], 31));
//                $data['logo'] = '/upload/' . substr($match[1][0], 31);
//            }
//        }
        if (empty($request['create_time'])) {
            //2014-01-01时间戳为  1388534400
            //2014-12-31时间戳为  1419984000
            $time = mt_rand(1388534400,1419984000);
            $data['create_time'] = $data['update_time'] = $time;
            $data['counter_view'] = mt_rand(36,68);
            $data['counter_praise'] = mt_rand(6,18);
        }
        if(!empty($request['create_time'])) {
            $data['create_time'] = strtotime($request['create_time']);
//            if($data['create_time'] > time()) {
//            Func_Header::back('修改时间不得大于当前时间！');
//            }
        }
        $data['from_where'] = 2;
        $rows = Data_Mysql_Table_Raiders_Info::update($data);
        if ($rows > 0) {
           Data_Mysql_Table_Raiders_Candidate::update($request['id'],array('status' =>1,'username'=>$_SESSION['administrator']['username']));
            Func_Header::to(' 操作成功！', Core::$urls['path']);
        } else {
            Func_Header::to('操作失败！', Core::$urls['path']);
        }
    }

    //相似资讯数据详情
    static function handleRaidersDetail()
    {
        $request = Func_Input::filter(array(
                    'id' => 'int'
                ));
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
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('category_name', $categoryName);

        $vendorAttr = Data_Config_Vendor_Attr::get('attr');

        Tpl_Smarty::assign('_action', $_REQUEST['action']);
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);
        Tpl_Smarty::assign('_data', $_data);
        Tpl_Smarty::display('OA_Static', 'raiders_candidate/raiders_info_edit.tpl');

    }
}