<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/4
 * Time: 13:18
 * 获取搜狗微信账号里的文章
 *
 */
class OA_WeChat_Article_List
{
    static function handle()
    {

//        self::getArticleList();
        // 获取COOKIE
        Core::cron(60 * 60 * 24, 'OA_WeChat_Article_List', 'getCookie', '', true);
        // 采集文章
        Core::cron(15 * 60, 'OA_WeChat_Article_List', 'getArticleList', '', true);

        $action = empty($_REQUEST['action']) ? 'wechat_article' : $_REQUEST['action'];
        switch ($action) {
            case 'wechat_article':
                self::showArticleList();
                break;
            case 'update_article':
                self::updateArticle();
                break;
            case 'article_info':
                self::setAuthorInfo();
                break;
            case 'update_hide':
                self::updateHide();
                break;
        }
    }

    static function getArticleList()
    {
        $res = Data_Mysql_Table_Public_Number::select('show_name,update_time', '', 'ORDER BY update_time DESC',30);
        $one_title = array_rand($res,1);
        $update_time = time();
        Data_Mysql_Table_Wechat_Article_Log::subTable(date('_Ym', time()))->query('INSERT INTO {table} (title,search_type,create_time) VALUE (?,?,?) ON DUPLICATE KEY UPDATE update_time=' . $update_time, array(
            $res[$one_title]['show_name'],
            '关键词',
            $update_time));
        if (!empty($res)) {
            $url = "http://weixin.sogou.com/weixin?type=2&query=" . Func_Url::str_urlencode($res[$one_title]['show_name']) . "&ie=utf8";
            $getCookie = Core::readData(Core::$paths['temp'] . 'setCookie');
            if (isset($getCookie) && !empty($getCookie)) {
                $cookie = $getCookie;
            } else {
                $cookie = 'SUV=0056783874E79AE156A9725BE7FBD805;SNUID=B0CBB5255257780A5874CB5152212E90';
            }
            $opts = array(
                'http' => array(
                    'method' => "GET",
                    'header' => "Accept-language: en\r\n" .
                        "Cookie:" . $cookie
                )
            );
            $context = stream_context_create($opts);
            $html = file_get_contents($url, false, $context);

            if (!strpos(strip_tags($html), '您的访问过于频繁')) {
                // 标题
                $str_title = '/<h4>\n.*?\n<\/h4>/ism';
                preg_match_all($str_title, $html, $arr_title);
                // 摘要
                $str_digest = '/<\/h4>\n.*?<\/p>/ism';
                preg_match_all($str_digest, $html, $arr_digest);
                // 图片
                $str_src = '/<img style="visibility:hidden;border:none;".*?src="(.*?)">/';
                preg_match_all($str_src, $html, $arr_src);
                // 作者
                $str_author = '/<a id="weixin_account".*?title="(.*?)"/';
                preg_match_all($str_author, $html, $arr_author);
                // 发布时间
                $str_time = "/write\('(.*?)'\)/ism";
                preg_match_all($str_time, $html, $arr_time);

                //创建采集日志
                $log['html_size'] = strlen($html);
                $log['article_sum'] = count($arr_title[0]);
                $log['search_type'] = '关键词';
                $log['create_time'] = time();
                $log['title'] = $res[$one_title]['show_name'];
//            Data_Mysql_Table_Wechat_Article_Log::subTable(date('_Ym'))->debug(1);
//            $log_res = Data_Mysql_Table_Wechat_Article_Log::subTable(date('_Ym'))->query('INSERT INTO {table} (title,html_size,article_sum,search_type,create_time) VALUE ("'.$log['title'].'",'.$log['html_size'].','.$log['article_sum'].',"'.$log['search_type'].'",'.$log['create_time'].') ON DUPLICATE KEY UPDATE article_sum=article_sum+'.$log['article_sum'],1);
                $log_res = Data_Mysql_Table_Wechat_Article_Log::subTable(date('_Ym', time()))->query('INSERT INTO {table} (title,html_size,article_sum,search_type,create_time) VALUE (?,?,?,?,?) ON DUPLICATE KEY UPDATE html_size=' . $log['html_size'] . ',article_sum=article_sum+' . $log['article_sum'], array(
                    $log['title'],
                    $log['html_size'],
                    $log['article_sum'],
                    $log['search_type'],
                    $log['create_time'],

                ), 1);

                // 采集到的文章入库
                foreach ($arr_title[0] as $k => $v) {
                    // 获取文章标题
                    if (strpos($v, '&hellip;') != 0) {
                        $data[$k]['title'] = str_replace('&hellip;', '...', strip_tags($v));
                    } else {
                        $data[$k]['title'] = strip_tags($v);
                    }
                    $data[$k]['digest'] = strip_tags($arr_digest[0][$k]);
//                    if (strpos($arr_src[1][$k], 'amp;') != 0) {
//                        $data[$k]['img'] = str_replace('amp;', '', $arr_src[1][$k]);
//                    } else {
//                        $data[$k]['img'] = $arr_src[1][$k];
//                    }
                    if (strpos($arr_src[1][$k], 'amp;') != 0) {
                        $img = str_replace('amp;', '', $arr_src[1][$k]);
                    } else {
                        $img = $arr_src[1][$k];
                    }
                    $aaa = explode('url=', $img);
                    $data[$k]['img'] = Func_Upload::download_image($aaa[1], '', 2);
                    $data[$k]['author'] = $arr_author[1][$k];
                    $data[$k]['article_time'] = $arr_time[1][$k];
//                    $data[$k]['article_url'] = $arr_url[1][$k];
                    $res_1 = Data_Masql_Table_WeChat_Article::insert($data[$k]);
                    // 创建采集日志
                    if (!empty($res_1[0])) {
                        $date = time();
                        Data_Mysql_Table_Wechat_Article_Log::subTable(date('_Ym'))->query('UPDATE {table} SET insert_sum=insert_sum+1,update_time=' . $date . ' WHERE id=' . $log_res[0]);
                    }
                }
                Data_Mysql_Table_Public_Number::update(array('show_name' => $res[$one_title]['show_name']), array('update_time' => ($res[$one_title]['update_time'] - (86400 * 100))));

            } else {
                /**
                 * 查询过于频繁时：清空储存的cookie
                 * 两个小时后再执行采集
                 */
                self::getCookie();
                Core::cron(60 * 60 *2, 'OA_WeChat_Article_List', 'getArticleList', '', true);
            }
        } else {
            /**
             * 未查询到关键词时 两个小时继续执行
            */
            Core::cron(60 * 60 *2, 'OA_WeChat_Article_List', 'getArticleList', '', true);
        }
        /**
         * 采集顺利的情况下 15 分钟执行抓取任务
         */
        Core::cron(15 * 60, 'OA_WeChat_Article_List', 'getArticleList', '', true);
    }

    static function showArticleList()
    {


        $request = Func_Input::filter(array(
            'status' => 'string',
            'search'=>'array'
        ), $_REQUEST);
        $condition = array();
        if(!empty($request['search'])){
            if (!empty($request['search']['title'])) {
                $condition['title'] = $request['search']['title'];
            }
            if (!empty($request['search']['author'])) {
                $condition['author'] = $request['search']['author'];
            }
            if (!empty($request['search']['article_start_time']) && !empty($request['search']['article_end_time'])){
                if(strtotime($request['search']['article_start_time'])>strtotime($request['search']['article_end_time'])){
                    Func_Header::back('请选择正确的起止时间！');
                }else{
                   $condition['article_time between ? and ?']=array(strtotime($request['search']['article_start_time'].'00:00:00'),strtotime($request['search']['article_end_time'].'23:59:59'));
                }
            }
            if (!empty($request['search']['article_start_time']) && empty($request['search']['article_end_time'])){
                $condition['article_time > ?'] =strtotime($request['search']['article_start_time'].'00:00:00');
            }
            if (empty($request['search']['article_start_time']) && !empty($request['search']['article_end_time'])){
                $condition['article_time < ?'] =strtotime($request['search']['article_end_time'].'23:59:59');
            }
            if (!empty($request['search']['create_start_time']) && !empty($request['search']['create_end_time'])){
                if(strtotime($request['search']['create_start_time'])>strtotime($request['search']['create_end_time'])){
                    Func_Header::back('请选择正确的起止时间！');
                }else{
                   $condition['create_time between ? and ?']=array(strtotime($request['search']['create_start_time'].'00:00:00'),strtotime($request['search']['create_end_time'].'23:59:59'));
                }
            }
            if (!empty($request['search']['create_start_time']) && empty($request['search']['create_end_time'])){
                $condition['create_time > ?'] =strtotime($request['search']['create_start_time'].'00:00:00');
            }
            if (empty($request['search']['create_start_time']) && !empty($request['search']['create_end_time'])){
                $condition['create_time < ?'] =strtotime($request['search']['create_end_time'].'23:59:59');
            }
//            $search ='&'.strstr(Core::$urls['query'],'search');
        }
        $status = empty($request['status']) ? 'all' : $request['status'];
        switch ($status) {
            case 'all':
                $condition['status !=?'] = -1;
                break;
            case 'waiting':
                $condition['status'] = 0;
                break;
            case 'done':
                $condition['status'] = 2;
                break;
            case 'suggest':
                $condition['status'] = 1;
                break;
            case 'hide':
                $update_time= time();
                Data_Masql_Table_WeChat_Article::query("UPDATE {table} SET status = -1,update_time=".$update_time.",administrator='云space高级顾问',is_bad=0 WHERE is_bad >= 2 ");
                $condition[] = "(status =-1 OR is_bad >=2)";
                break;
            default:
                $condition['status !=?'] = -1;
        }
        $condition['is_bad <?'] = 2;
        if($status!='all'){
            $order = 'ORDER BY update_time DESC, article_time DESC';
        }else{
            $order = 'ORDER BY article_time DESC';
        }
        $data = Data_Masql_Table_WeChat_Article::page(0, 10, '*', $condition, $order);
        if(isset(Core::$urls['query']) && strstr(Core::$urls['query'],'search')){
            Tpl_Smarty::assign('search','&'.strstr(Core::$urls['query'],'search'));
        }
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('data', $data);
        Tpl_Smarty::display('OA_Static::public_number/wechat_article/wechat_article_list.tpl');
    }

    // 状态更改
    static function updateArticle()
    {
//        Core::output('');
        @session_start();
        $request = Func_Input::filter(array(
            'article_id' => 'int',
            'author' => 'string',
            'status' => 'int'
        ), $_REQUEST);
        $data['status'] = $request['status'];
        if ($request['status'] == 0) {
            $data['is_bad =?'] = 0;
        }
        $data['administrator']=empty($_SESSION['administrator'])?'系统操作':$_SESSION['administrator']['fullname'];
        $data['update_time']=time();
        $res = Data_Masql_Table_WeChat_Article::update(array('id' => $request['article_id']), $data);
        if (!empty($res[0])) {
            $args['author'] = $request['author'];
            $args['type'] = $request['status'];
            Api_Wechat_Article_Author_Trace::updateAuthorInfo($args);
            Func_Header::to('  状态更改成功！');
        } else {
            Func_Header::back('状态更改失败!');
        }
    }


    static function setAuthorInfo()
    {
        @session_start();
        Core::output('');
        $request = Func_Input::filter(array(
            'article_id' => 'int',
            'article_url' => 'string',
            'status' => 'int',
            'author' => 'string'
        ), $_REQUEST);
        if (!empty($request['article_id'])) {
            $da['administrator']=empty($_SESSION['administrator'])?'系统操作':$_SESSION['administrator']['fullname'];
            $da['update_time']=time();
            if(!empty($request['article_url'])){
                $da['article_url'] = $request['article_url'];
            }
            $da['status'] = $request['status'];
            $res = Data_Masql_Table_WeChat_Article::update(array('id' => $request['article_id']), $da);
//            //处理文章
            if (!empty($res)) {
                $args['author'] = $request['author'];
                $args['type'] = $request['status'];
                Api_Wechat_Article_Author_Trace::updateAuthorInfo($args);
                Func_Output::json('success', '', '   状态更改成功！');
            } else {
                Func_Output::json('error', '', '状态更改成功！');
            }
        }
    }

//    //更新隐藏数据
//    static function updateHide()
//    {
//        $update_time= time();
//        Data_Masql_Table_WeChat_Article::query("UPDATE {table} SET status = -1,update_time=".$update_time.",administrator='云space高级顾问',is_bad=0 WHERE is_bad >= 2 ");
//        $condition[] = "(status =-1 OR is_bad >=2)";
//        $data = Data_Masql_Table_WeChat_Article::page(0, 15, '*', $condition, 'ORDER BY update_time DESC,article_time DESC');
//        if(isset(Core::$urls['query']) && strstr(Core::$urls['query'],'search')){
//            Tpl_Smarty::assign('search','&'.strstr(Core::$urls['query'],'search'));
//        }
//        Tpl_Smarty::assign('status', 'hide');
//        Tpl_Smarty::assign('data', $data);
//        Tpl_Smarty::display('OA_Static::public_number/wechat_article/wechat_article_list.tpl');
//    }

    //获取cookie
    static function getCookie()
    {
        $res = Data_Mysql_Table_Public_Number::select('show_name,update_time', '', 'ORDER BY update_time DESC');
        if (!empty($res[0]['show_name'])) {
            $url = "http://weixin.sogou.com/weixin?type=2&query=" . Func_Url::str_urlencode($res[0]['show_name']) . "&ie=utf8";
            Func_Snoopy::fetch($url);
            Func_Snoopy::setcookies();
            $cookie = Func_Snoopy::$snoopy->cookies;
//            q($cookie);
            if (isset($cookie['SNUID'])) {
                Core::writeData(Core::$paths['temp'] . 'setCookie', 'SNUID=' . $cookie['SNUID']);
            } else {
                Core::writeData(Core::$paths['temp'] . 'setCookie', '');
            }
            Core::cron(60 * 60 * 24, 'OA_WeChat_Article_List', 'getCookie', '', true);
        } else {
            Core::cron(60 * 60 * 24 * 2, 'OA_WeChat_Article_List', 'getCookie', '', true);
        }
    }

}