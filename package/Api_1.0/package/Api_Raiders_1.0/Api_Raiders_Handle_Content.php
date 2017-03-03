<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 * 处理云发现文章的内容，关联到百科名称
 */
class  Api_Raiders_Handle_Content extends Api
{

    static function compareRaidersContentWithSpacepedia($data,$site="baike"){
        $request = Func_Input::filter(array(
            'id' => 'int',
            'cont' => 'html',
            'baike_word' => 'array',
        ),$data);
        if (empty($request['id']) || empty($request['cont'])) {
            return false;
        }
        //先从缓存中获取,如果没有或者过期，则更新缓存
        $cache_data=Api_Common_Cache::get('raiders_content',$request['id']);
        if(empty($cache_data) || (!empty($_REQUEST['update_page_cache']) && $_REQUEST['update_page_cache']==1)){
            return self::handleRaidersContent($request,$site);
        }
        return $cache_data;

    }
    //处理云发现的文章内容
    static function handleRaidersContent($request,$site=""){
        //去除文章内容中不是yunspace的超链接
        preg_match_all('/<a .*?href="(.*?)".*?>.*?<\/a>/',$request['cont'],$matche_link);
        if(!empty($matche_link[0])){
            foreach($matche_link[0] as $k=>$v){
                if(!preg_match('/.*(pre0.yunspace.com.cn|www.yunspace.com.cn|'.Core::$urls['host'].').*/',$v)){
                    preg_match_all("/>(.*?)</",$v,$text_arr);
                    $request['cont']=str_replace($v,$text_arr[1][0],$request['cont']);
                }
            }
        }
        $request['cont']=str_replace('http://mmbiz.qpic.cn/mmbiz','',$request['cont']);
        $content=strip_tags($request['cont']);
        $content_length=mb_strlen($content,"utf8");
        $baike_dictionary=self::getBaikeDictionaryCache();
        $temp_arr=array();
        //获取内容中首字存在百科词典中的字
        for ($i = 0;$i < $content_length;$i++) {
            $single=mb_substr($content,$i,1,"utf8");
            //如果首字存在百科词典中
            if(!empty($baike_dictionary[$single])){
                $temp_arr=array();
                $temp_arr=array_unique($baike_dictionary[$single]);
                rsort($temp_arr);
                foreach($temp_arr as $k=>$v){
                    //截取字符串
                    $str_temp=mb_substr($content,$i,$v,"utf8");
                    //查询是否存在于百科词典中
                    $condition['space_name = ?']=$str_temp;
                    $condition['status']=1;
                    $is_exists=Data_Mysql_Table_Spacepedia::select('id,space_name',$condition,'',1);
                    if(!empty($is_exists[0])){
                        $match_temp[]=$str_temp;
                    }

                }
            }
        }
        //处理匹配的百科名称
        if(!empty($match_temp)){
            $match_arr=array_unique($match_temp);
            rsort($match_arr);
            foreach($match_arr as $k=>$v){
                if($site=="site"){
                    $match2[$v]='<a style="color:#428bca;" target="_blank" href="/site/'.$v.'-百科">'.$v.'</a>';
                }else{
                    $match2[$v]='<a style="color:#428bca;" target="_blank" href="/baike/'.$v.'">'.$v.'</a>';
                }
            }
            $cont2=Func_String::tagsReplace($request['cont'],$match2);
            Api_Common_Cache::set('raiders_content',$request['id'], $cont2 ,7*24*3600);
            //更新云发现的关键词
//            $request['baike_word']=empty($request['baike_word'])?array():$request['baike_word'];
//            $baike_word=array_unique(array_merge($request['baike_word'],$match_arr));
//            Data_Mysql_Table_Raiders_Info::update(array("id"=>$request['id']),array("baike_word"=>$baike_word));
            return $cont2;
        }else{
            Api_Common_Cache::set('raiders_content',$request['id'], $request['cont'] ,7*24*3600);
            return $request['cont'];
        }
    }

    //获取/新增百科词典
    static function getBaikeDictionaryCache(){
        //每周更新一次 ,测试五分钟更新
        $baike_dictionary = Core::readData(Core::$paths["temp"] . "data/baike_dictionary." . (Core::$debugToken ? 1 : 0));
        if (empty($baike_dictionary)) {
            $length_arr=$full_name_arr=$first_name_arr=array();
            $data=Data_Mysql_Table_Spacepedia::select('id,space_name','','',999999999);
            foreach($data as $k=>$v){
                $first_name=mb_substr($v['space_name'],0,1,"utf8");
                $length=mb_strlen($v['space_name'],'utf-8');
                $cache_data[$first_name][]=$length;
            }
            //执行完成写入缓存文件
            Core::writeData(Core::$paths['temp'] . "data/baike_dictionary.". (Core::$debugToken ? 1 : 0), $cache_data, 7*24*3600);
            return $cache_data;
        }else{
            return $baike_dictionary;
        }
    }

    //清除百科首词的缓存
    static function clearBaikeDictionaryCache(){
        Core::writeData(Core::$paths['temp'] . "data/baike_dictionary.". (Core::$debugToken ? 1 : 0), '',7*24*3600);
    }

}