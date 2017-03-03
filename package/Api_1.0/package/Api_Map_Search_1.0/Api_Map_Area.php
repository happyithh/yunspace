<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/10/10
 * Time: 13:53
 * 查询当前城市有多少个区域和区域内的多少个数量
 */
class  Api_Map_Area extends Api
{

    static function  handle($args = '')
    {
        $data = self::HandleArea();
        if ($data) {
            return Api::request('success', $data, '成功');
        } else {
            return Api::request('error', '', '失败~');
        }
    }

    static function  HandleArea()
    {
        $conditions['status=?'] = 1;
        $conditions['attr_index'][46] = $_COOKIE['city'];
        $children = Data_Mysql_Table_Product_Category::getChildren(112);
        $children[] = 112;
        $conditions[] = 'category_id IN (' . implode(',', $children) . ')';
        if (!Func_Input::isLocal()) {
            $cache = Data_Mysql_Table_Cache_Array::get('_map_search', $conditions);
            if ($cache) {

                return $cache;
            }
        }

        $data = Data_Mysql_Table_Product_Search::select('id,attr_index', $conditions, '', 50000);
        $area = self::AreaAttr($data);

        Data_Mysql_Table_Cache_Array::set('_map_search', $conditions, $area, 86400);
        return $area;
    }

    static function  AreaAttr($list)
    {
        $area = array();
        $ids = '';
        $editIDS = array();
        foreach ($list as $k => $val) {
            if (!is_array($list['attr_index'])) {
                $attr_index = json_decode($list[$k]['attr_index'], 1);
            } else {
                $attr_index = $list[$k]['attr_index'];
            }

            if ((!strpos($attr_index[4], '区') && !strpos($attr_index[4], '县')) || strlen($attr_index[4]) < 6) {
                $editIDS[] = $val['id'];
                unset($attr_index[4]);
            }
            if (empty($attr_index[4])) {
                $ids[] = $val['id'];
            }
            $area[] = $attr_index[4];
        }

        if (!empty($editIDS)) {
            $title = '【通知】';
            $email = Data_Config_Demand_Notice::get('运营部');
            $msg = "<dl><dd>【通知】</dd><dd>发现有商品资料不合格，请去补充一下！";
            $iiii = '';
            foreach ($editIDS as $v) {
                $iiii = "<a href='http://www.yunspace.com.cn/service_info/{$v}.html' target='_blank'>点击访问(新窗口)</a></br>";
            }
            Func_Mail::send($email, $title, $msg . $iiii . '</dd></dl>');
        }
        $newData = array();
        $data = array_count_values($area);
        foreach ($data as $key => $val) {
            if ($val > 1) {
                $baiDuJson = file_get_contents("http://api.map.baidu.com/geocoder/v2/?address=" . $_COOKIE['city'] . $key . "&output=json&ak=aaNCRRcGGai6klHMOGZ8yBbP");
                $baiDuData = json_decode($baiDuJson, 1);
                if ($baiDuData['status'] == 0) {
                    $newData[] = array(
                        'name' => $key,
                        'num' => $val,
                        'lng' => $baiDuData['result']['location']['lng'],
                        'lat' => $baiDuData['result']['location']['lat'],
                    );
                }
            }
        }

        if (!empty($ids)) {
            $conditions[] = 'id IN(' . implode(',', $ids) . ')';
            Data_Mysql_Table_Product_Info::update($conditions, array('update_time' => time()));
        }
        return $newData;
    }
}