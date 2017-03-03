<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/5/16
 * Time: 14:32
 * 文章内页
 */
class Web_Article_Classify_Tags extends Web_Global
{
    function seo()
    {
        return array(
//            '网页标题'=>'云space-'.$this->getBaikeName.$this->info['baike_word'][0].'-'.$this->info['title'].'_场地百科|云SPACE',
            '网页标题' => $this->request() . '相关文章-云SPACE玩转商业空间艺术,打造活动新场景【云SPACE－商业空间短租平台】',
            '网页关键词' => $this->getBaikeName . ',' . $this->info['title'] . ',' . $this->getTags,
            '网页简介' => mb_substr(trim(strip_tags($this->info['des'])), 0, 300, 'utf-8')
        );
    }

    function  request()
    {
        $request = Func_Input::filter(array(
            'tags' => 'string',
        ), $_REQUEST);
        if (!empty($request['tags'])) {
            return $request['tags'];
        }
        return '最新';
    }

    function  getArticleList()
    {
        if (!empty($_REQUEST['page'])) {
            $page = intval($_REQUEST['page']);
        } else {
            $page = 0;
        }
        $conditions['status=?'] = 1;
        $tags = $this->request();
        if ($tags != '最新') {
            $conditions['tags_info'] = $tags;
        }
        $data = Data_Mysql_Table_Raiders_Info::page($page, 10, '*', $conditions,
            'ORDER BY create_time DESC,counter_view DESC');
        $rs = $data['rows'];
        foreach ($rs as $k => $val) {
            if ($val['img_set']) {
                $img_set = explode(',', $val['img_set']);
                $rs[$k]['img_set0'] = $img_set[0];
                $rs[$k]['img_set1'] = $img_set[1];
                $rs[$k]['img_set2'] = $img_set[2];
            }
        }
        $data['rows'] = $rs;
        return $data;
    }

    function getNewTags()
    {
        $hotTags = Api_Article_GetRelateArticle::getHotTags();
        return array_slice($hotTags, 0, 4);
    }


}