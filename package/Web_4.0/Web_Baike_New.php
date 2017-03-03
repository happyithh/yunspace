<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-12-8
 * Time: 下午8:47
 */
class Web_Baike_New{
    static function handle($baike_data,$get_type='',$tags_type){
        if(empty($baike_data['space_name'])){
            Func_Header::notFound();
        }
        $condition["space_ids"]=$baike_data['id'];
        if(!empty($tags_type)){
            if(is_numeric($tags_type)){
                $condition['category_id']=$tags_type;
            }else{
                $condition["space_ids"]=$baike_data['id'];
                $condition['tags_info']='+'.$tags_type;
            }

        }
        //精华
        if($get_type=="fine"){
            $condition['is_good']=1;
        } elseif($get_type=='new'){
            $condition_two['is_good']=1;
            $condition_two["space_ids"]=$baike_data['id'];
            $two_data=self::getArticles($condition_two,1);
            unset($two_data['tags']);
            if(!empty($two_data)){
                foreach($two_data as $k=>$v){
                    $ids[]=$v['id'];
                }
                if(empty($tags_type)){
                    $condition[]="id not in (".implode(",",$ids).")";
                }
            }
            Tpl_Smarty::assign('two_data',$two_data);
        }
        $data=self::getArticles($condition);
        $tags=array();
        if(!empty($baike_data['cache_tags'])){
            $baike_data['cache_tags']=json_decode($baike_data['cache_tags'],1);
        }
        if(!empty($baike_data['cache_tags']) && ((time() - $baike_data['cache_tags']['cache_time'])<86400*7)){
            $tags=array_slice($baike_data['cache_tags']['tags'],0,10,true);
        }else{
            $tags= self::getCacheTags($baike_data);
            if(!empty($tags)){
                // 缓存文章标签
                $cache['cache_tags']['tags'] =array_slice($tags,0,10,true);
                $cache['cache_tags']['cache_time']=time();
                Data_Mysql_Table_Spacepedia::query('UPDATE {table} SET cache_tags=? WHERE id = ?', array(
                    json_encode($cache['cache_tags']),
                    $baike_data['id'],
                ));
            }
        }

        Tpl_Smarty::assign('tags',$tags);
        Tpl_Smarty::assign('_tags',empty($tags_type)?'':$tags_type);
        Tpl_Smarty::assign('article_list',$data);

    }

    //获取百科相关文章
    static function getArticles($condition=array(),$no_page=0,$order='',$num = 2,$page_size=20){
        $condition['status = ?']=1;
        $condition['create_time <=?'] = time();
        $order=empty($order)?" ORDER BY create_time DESC, counter_praise DESC":$order;
        if($no_page==1){
            $data=Data_Mysql_Table_Raiders_Info::select('*',$condition,$order,$num);
        }else{
            $data=Data_Mysql_Table_Raiders_Info::page(0,$page_size,'*',$condition,$order);
        }
        return $data;
    }


    // 获取 百科下文章的关键词
    static function getCacheTags($space_name)
    {
        // 获取百科下所有文章的类型
       $category = Data_Mysql_Table_Raiders_Info::select('category_id',array('space_ids'=>$space_name['id'],'status'=>1),'',100);
       $category_name='';
        if(!empty($category)){
           foreach($category as $k=>$v){
               $tags[]=$v['category_id'];
           }
           $tags = array_unique($tags);
           $categoryName = Data_Mysql_Table_Raiders_Info::$category_name;
           foreach($categoryName as $k=>$v){
               if(in_array($v['id'],$tags)){
                   $category_name[$v['id']] = $v['name'];
               }
           }
       }
        return $category_name;
    }

}