<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-1-18
 * Time: 上午11:54
 */
class Api_Baike_Like_Go extends Api{
    static function handle($args){
        if(empty($args['action'])){
            return self::request('error','','操作错误！！');
        }
        switch($args['action']){
            case 'fetch_like_go':
                $cache_data=Api_Common_Cache::get("like_go",$args['space_id']);
                if(!empty($cache_data)){
                    return $cache_data;
                }else{
                    $data=self::fetchLikeGo($args);
                    Api_Common_Cache::set("like_go",$args['space_id'],$data,9999);
                    return $data;
                }
                break;
            case "click_num":
                $data=self::initBaikeCountNum($args);
                return $data;
                break;
            default:
                return self::request('error','','操作错误！！');
                break;
        }
    }
    //初始化我喜欢和现场足迹数据
    static function initLikeAndGo($args){
        $request=Func_Input::filter(array(
            'space_id'=>'int',   //场地百科Id
        ),$args);
        if(empty($request['space_id'])){
            return self::request('error','','参数错误！！');
        }
        $condition['space_id'] = $request['space_id'];
        $order="ORDER BY update_time DESC";
        $like_go = Data_Mysql_Table_Like_Go::select('*', $condition, $order, 300);
        if(empty($like_go)){
            $con=array();
            $con['account_id < ?'] = 0;
//            $con["update_time >= ?"]=time()-3*30*24*3600;
            //放入我喜欢的数据
//            $limit1=mt_rand(10,50);
            $limit1=mt_rand(1,5);
            $res1 = Data_Mysql_Table_Account_Wechat::select("id",$con,'ORDER BY rand()',$limit1);
            if(!empty($res1)){
                $res_data_like1['like_go']=1;
                $res_data_like1['space_id']=$request['space_id'];
                $res_data_like1['update_time']=1;    //标识假数据
                shuffle($res1);
                foreach($res1 as $k=>$v){
                    $res_data_like1['wechat_id']=$v["id"];
                    Data_Mysql_Table_Like_Go::insert($res_data_like1);
                }
            }
            //放入现场足迹数据
//            $limit2=mt_rand(10,50);
//            $res2 = Data_Mysql_Table_Account_Wechat::select("id",$con,'ORDER BY rand()',$limit2);
//            if(!empty($res2)){
//                $res_data_like2['like_go']=2;
//                $res_data_like2['space_id']=$request['space_id'];
//                $res_data_like2['update_time']=1;    //标识假数据
//                shuffle($res2);
//                foreach($res2 as $k=>$v){
//                    $res_data_like2['wechat_id']=$v["id"];
//                    Data_Mysql_Table_Like_Go::insert($res_data_like2);
//                }
//            }
        }
        return true;
    }

    //调用某个百科的我喜欢和现场足迹数据
    static function getLikeAndGoList($args){
        $baikeLike_return=$baikeGo_return=array();
        $request=Func_Input::filter(array(
            'space_id'=>'int',       //场地百科Id
            'limit'=>'int',         //调取数量
        ),$args);
        if(empty($request['space_id'])){
            return self::request('error','','参数错误！！');
        }
        $order="ORDER BY {table}.update_time DESC";
        //调取我喜欢数据列表
        $condition1['space_id'] = $request['space_id'];
        $condition1['{table}.like_go = ?']=1;
        $baikeLike = Data_Mysql_Table_Like_Go::select('{table}.*,{prefix}account_wechat.user_info', $condition1, $order, $request['limit'], '{table} LEFT JOIN {prefix}account_wechat ON {table}.wechat_id={prefix}account_wechat.id');
        foreach($baikeLike as $k=>$v){
            $baikeLike_return[]=json_decode($v['user_info'],1);
        }
        //调取现场足迹数据列表
        $condition2['space_id'] = $request['space_id'];
        $condition2['{table}.like_go = ? ']=2;
        $baikeGo = Data_Mysql_Table_Like_Go::select('{table}.*,{prefix}account_wechat.user_info', $condition2, $order, $request['limit'], '{table} LEFT JOIN {prefix}account_wechat ON {table}.wechat_id={prefix}account_wechat.id');
        foreach($baikeGo as $k=>$v){
            $baikeGo_return[]=json_decode($v['user_info'],1);
        }
        $return['like_data']=$baikeLike_return;
        $return['go_data']=$baikeGo_return;
        return $return;
    }


    //获取我喜欢和现场足迹数据总量
    static function initLikeAndGoNum($args){
        $request=Func_Input::filter(array(
            'space_id'=>'int',       //场地百科Id
            'is_init'=>'int',       //是否已初始化    1为已初始化
        ),$args);
        if(empty($request['space_id'])){
            return self::request('error','','参数错误！！');
        }
        if(empty($request['is_init'])){
            self::initLikeAndGo($request);
        }
        $is_love=$is_go=0;
        $data=Data_Mysql_Table_Like_Go::select("space_id,like_go",array("space_id"=>$request['space_id']),'',300);
        foreach($data as $k=>$v){
            if($v['like_go']==1){
                $is_love+=1;
            }else{
                $is_go+=1;
            }
        }
        $return['is_love']=$is_love;
        $return['is_go']=$is_go;
        return $return;
    }

    //获取和初始化百科的浏览量
    static function initBaikeCountNum($args){
        $request=Func_Input::filter(array(
            'space_id'=>'int',       //场地百科Id
        ),$args);
        if(empty($request['space_id'])){
            return self::request('error','','参数错误！！');
        }
        //获取百科关联的文章总浏览量
        $article_view=Data_Mysql_Table_Raiders_Info::select("sum(counter_view) as total",array("space_ids"=>$request['space_id']));
        $click_article=empty($article_view[0]['total'])?0:$article_view[0]['total'];
        //获取百科浏览量
        $click_baike=Data_Mysql_Table_Baike_Statistical::select('click',array("space_id"=>$request['space_id']));
        if(!empty($click_baike[0]['click']) && $click_baike[0]['click'] >= $click_article){
            return self::request('success',$click_baike[0]['click'],'返回浏览量');
        }else{
            //更新百科浏览量
            Data_Mysql_Table_Baike_Statistical::query('UPDATE {table} SET click = ? WHERE space_id = ?',array(
                $click_article,
                $request['space_id']
            ));
            return self::request('success',$click_article+1,'返回浏览量');
        }
    }


    //渲染我喜欢和现场足迹页面
    static function fetchLikeGo($args){
        $request=Func_Input::filter(array(
            'space_id'=>'int',       //场地百科Id
        ),$args);
        if(empty($request['space_id'])){
            return self::request('error','','参数错误！！');
        }
        //获取百科信息
        $baike=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_id'],array("{table}.status = ?"=>1));
        if(!empty($baike[0]) && Web_Global::catIsSpace($baike[0]['category_id'])) {
            $baike[0]['is_space']=1;
        }
        Tpl_Smarty::assign('info',$baike[0]);
        //判断调用数量
        if(!empty($baike[0]['is_space']) || $baike[0]['category_id']==200){
            $request['limit']=8;
        }else{
            $request['limit']=16;
        }
        //初始化我喜欢和现场足迹数据
        self::initLikeAndGo($request);
        //获取我喜欢和现场足迹列表
        $return=self::getLikeAndGoList($request);
        Tpl_Smarty::assign('like_list',empty($return['like_data'])?array():$return['like_data']);
        Tpl_Smarty::assign('go_list',empty($return['go_data'])?array():$return['go_data']);

        //获取我喜欢总数
        $request['is_init']=1;
        $like_data_num=self::initLikeAndGoNum($request);
        Tpl_Smarty::assign('is_love_num',empty($like_data_num['is_love'])?0:$like_data_num['is_love']);

        $tpl = Tpl_Smarty::fetch("Web_Static::site/inc/person_side.tpl");
        $return['tpl']=$tpl;
        $return['num']['people']=$like_data_num['is_love']+$like_data_num['is_go'];

        return Api::request('success', $return, '成功');
    }
}