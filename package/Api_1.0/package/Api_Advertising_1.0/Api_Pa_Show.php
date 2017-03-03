<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/26
 * Time: 18:19
 *
 * 前台广告位的显示
 */
class Api_Pa_Show extends Api
{
    static function handle($args)
    {
        $res = self::getPa($args);
        return self::request('success', $res, '');
    }

    static function getPa($args)
    {
        unset($args['pa_list']['length']);
        $request = Func_Input::filter(array(
            'pa_list' => 'array',
        ), $args);
        if (!empty($request['pa_list'])) {
            $result = $request['pa_list'];
            $ids = array();
            $conditions = array();
            $conditions['t1.status =?'] = 1;
            $conditions['t2.status =?'] = 0;
            $conditions['t1.start_time < ?'] = time();
            $conditions['t1.end_time > ?'] = time();
            $site = implode("','",$result);
            $conditions[] = "t2.site IN ('".$site."')";
            $rs = Data_Mysql_Table_Pa::select('t1.id, t2.id as site_id, t2.site,t2.size,t1.path, t1.advertising_link, t1.advertising_title as title',
                $conditions, 'ORDER BY default_adver ASC,rank ASC', count($result),
                '{table} as t1 LEFT JOIN {prefix}pa_site as t2 ON t1.site_id = t2.id'
            );
            $results=array();
            foreach($rs as $k=>$v){
                if(in_array($v['site'],$result)){
                    if(!empty($v['advertising_link'])){
                        $v['link'] = '/static/api/pa/goto.json?id=' . Func_NumEncode::e($v['id']);
                    }else{
                        $v['link'] = '';
                    }
                    $array_key =array_search($v['site'],$result);
                    $results[$array_key] = array(
                        'link'=>$v['link'],
                        'path'=>$v['path'],
                        'title'=>$v['title'],
                        'size'=>json_decode($v['size'],1),
                    );
                    unset($result[$array_key]);
                    $ids[] = array($v['site_id'], $v['id']);
                }
            }
            //更新展现量
            self::updateDisplayCounter($ids);

            return  $results;
        }
    }
    function updateDisplayCounter($ids){
        $date = date('ymdH');
        foreach($ids as $id){
            Data_Mysql_Table_Pa_Static::subTable(date('_Ym'))->query(
                'INSERT INTO {table} (site_id, adv_id, date_time, display) VALUES (?, ?, ?, 1)  ON DUPLICATE KEY UPDATE display = display +1',
                array(
                    $id[0],
                    $id[1],
                    $date
                )
            );
        }
    }
}