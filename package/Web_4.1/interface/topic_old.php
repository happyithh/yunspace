<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/6/22
 * Time: 9:51
 */


$action = Core::$urls['action'];

switch($action){
    case 'market':
        $visit_sum =Data_Config::get('topic_market');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_market',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/market.tpl');
        die();
        break;
    case 'music':
        $visit_sum =Data_Config::get('topic_music');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_music',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/music.tpl');
        die();
        break;
    case 'movies':
        $visit_sum =Data_Config::get('topic_movies');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_movies',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/movies.tpl');
        die();
        break;
    case 'self':
        $visit_sum =Data_Config::get('topic_self');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_self',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/self.tpl');
        die();
        break;
    case 'hot_market':
        $visit_sum =Data_Config::get('topic_hot_market');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_hot_market',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/hot_market.tpl');
        die();
        break;
    case 'terrace':
        $visit_sum =Data_Config::get('topic_terrace');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_terrace',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/terrace.tpl');
        die();
        break;
    case 'show':
        $visit_sum =Data_Config::get('topic_show');
        if(empty($visit_sum)){
            $visit_sum=0;
        }
        $visit_sum =$visit_sum +1;
        Data_Config::set('topic_show',$visit_sum);
        Tpl_Smarty::display('Web_Feature_Static::topic/show.tpl');
        die();
        break;
    default:
        echo "路径写错了";
        break;
}