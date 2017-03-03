<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/2/19
 * Time: 10:47
 *
 * 百科集合页
 * $args = array(
 *  'category_id'=> 'int'  百科类型
 * )
 */
class Api_Baike_Sites_List extends Api{
    static function handle($args){
        return self::getBaikeList($_REQUEST);
    }
    static function getBaikeList($args){
        $category_ids = Data_Mysql_Table_Spacepedia::getChildren($args['category_id']);
        if(!empty($category_ids)){
            $conditions[] = "t1.category_id IN(" . implode(',', $category_ids) . "," . $args['category_id'] . ")";
        }else{
            $conditions['t1.category_id=?'] = $args['category_id'];
        }
        $conditions['t1.status = ?']=1;
        $conditions[] = 't1.level IN(4,3)';
        $order = 'ORDER BY t2.click DESC,t1.create_time DESC';
        $data = Data_Mysql_Table_Spacepedia::page(0,9,array('t1.id,t1.space_name,t1.attr,t1.logo,t1.media,t1.addr,t1.mobile_logo,t2.click,t2.is_love,t2.is_go,t2.comments,t2.article_sum,t2.update_time as article_update_time'),$conditions,
            $order,'{table} as t1 LEFT JOIN {prefix}baike_statistical as t2 ON t1.id=t2.space_id');
        // 我喜欢和现场足迹数据
        if(!empty($data['rows'])){
            $baike_ids = array_column($data['rows'],'id');
            $sumData = self::getLikeAndGoData(array_unique($baike_ids));
        }

        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                $data['rows'][$k]['click']=empty($v['click'])?'0':$v['click'];
                if(isset($sumData) && !empty($sumData)){
                    $data['rows'][$k]['is_go'] = $sumData[$v['id']];
                }
                if(empty($v['article_sum']) || (time()-$v['article_update_time']>86400*3)){
                    $data['rows'][$k]['article_sum'] = self::getArticleSum($v['id']);
                    $date = time();
                    Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_id,update_time) VALUES ("'.$v['id'].'","'.$date.'")  ON DUPLICATE KEY UPDATE article_sum ='.$data['rows'][$k]['article_sum'].',update_time='.$date);
                }
                if(!empty($v['attr'])){
                    $data['rows'][$k]['attr'] = json_decode($v['attr'],1);
                }
                if(!empty($v['logo'])){
                    $data['rows'][$k]['logo'] = Page_Site_Global::displayMedia($v['logo'],640,424);
                }
                if(!empty($v['mobile_logo'])){
                    $data['rows'][$k]['mobile_logo'] = Page_Site_Global::displayMedia($v['mobile_logo'],640,424);
                }
            }
        }
        return self::request('success',$data,'');
    }
    static function getArticleSum($space_id)
    {
//       $article =  Data_Mysql_Table_Raiders_Info::select('count(*) as sum',array('baike_word'=>$space_name,'status'=>1));
        $article =  Data_Mysql_Table_Raiders_Info::select('count(*) as sum',array('space_ids'=>$space_id,'status'=>1));
        return $article[0]['sum'];
    }

    // 获取我喜欢和现场足迹数据
    static function getLikeAndGoData($baike_ids){
        $key = array_fill(0,count($baike_ids),'');
        $sum = array_combine($baike_ids,$key);
        $conditions[] = "space_id IN (".implode(',',$baike_ids).")";
        $data=Data_Mysql_Table_Like_Go::select("space_id,like_go",$conditions,'',99999);
        foreach($data as $k=>$v){
            $sum[$v['space_id']] +=1 ;
        }
        return $sum;
    }
}