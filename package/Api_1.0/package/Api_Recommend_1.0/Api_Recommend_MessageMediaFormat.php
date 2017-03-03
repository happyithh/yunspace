<?php

/**
 * 组装多媒体格式
 * 1。产品信息类别   发送推荐的场地或者套餐的信息
 * 2。带看场地类别   发送带看场地信息， 信息内容时间地点等.
 * 3
 *
 */
class Api_Recommend_MessageMediaFormat extends Api
{

    /**
     *
     * @ 套餐或者空间的 格式
     * 传入参数
     * @param $args array(
     *                  'set_id'=>'int'             产品ID 或者 套餐的ID
     *                  'product_id'=>'int'
     *                  )
     * @return  array(
     *                      pic,
     *                      title,
     *                      des,
     *                      url,
     *                 )
     *
     */
    static function formatSpace($args)
    {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'product_id' => 'int',
        ), $args);
        if (empty($request['set_id']) && empty($request['product_id'])) {
            return false;
        }
        $mediaSpace = array();

        if ($request['product_id']) {
            $rs = Data_Mysql_Table_Product_Search::select('id,logo,product_name,des', array('id=?' => $request['product_id']));
            $data = $rs[0];
            $data['des'] = str_replace(trim(strip_tags($data['des'])), '&nbsp;', '');
            $mediaSpace['title'] = $data['product_name'];
            $mediaSpace['pic'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($data['logo'], 100, 100);
            $mediaSpace['des'] = empty($data['des']) ? '商家太懒没有留下介绍' : mb_substr($data['des'], 0, 34, 'utf-8');
            $mediaSpace['url'] = 'http://' . Core::$urls['host'] . '/service_info/' . $data['id'] . '.html';
            return $mediaSpace;

        } elseif ($request['set_id']) {
            $rs = Data_Mysql_Table_Product_Set::select('id,logo,set_name,des', array('id=?' => $request['set_id']));
            $data = $rs[0];
            $data['des'] = str_replace(trim(strip_tags($data['des'])), '&nbsp;', '');
            $mediaSpace['title'] = $data['set_name'];
            $mediaSpace['pic'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($data['logo'], 100, 100);
            $mediaSpace['des'] = empty($data['des']) ? '商家太懒没有留下介绍' : mb_substr($data['des'], 0, 34, 'utf-8');
            $mediaSpace['url'] = 'http://' . Core::$urls['host'] . '/set_info/' . $data['id'] . '.html';

            return $mediaSpace;
        }
        return false;

    }

    //根据数据 格式化
    static function dataFormatSpace($args)
    {
        $request = Func_Input::filter(array(
            'type' => 'string',            //product  产品       set  套餐
            'data' => 'array',
        ), $args);
        if (empty($request['data']) || empty($request['type'])) {
            return false;
        }
        $mediaSpace = array();
        $data = $request['data'];
        $data['des'] = trim(str_replace('&nbsp;', '', strip_tags($data['des'])));
        if ($request['type'] == 'product') {
            $mediaSpace['title'] = $data['product_name'];
            $mediaSpace['pic'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($data['logo'], 100, 100);
            $mediaSpace['des'] = empty($data['des']) ? '商家太懒没有留下介绍' : mb_substr($data['des'], 0, 60, 'utf-8');
            $mediaSpace['url'] = 'http://' . Core::$urls['host'] . '/service_info/' . $data['id'] . '.html';
            return $mediaSpace;
        } elseif ($request['type'] == 'set') {
            $mediaSpace['title'] = $data['set_name'];
            $mediaSpace['pic'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($data['logo'], 100, 100);
            $mediaSpace['des'] = empty($data['des']) ? '商家太懒没有留下介绍' : mb_substr($data['des'], 0, 60, 'utf-8');
            $mediaSpace['url'] = 'http://' . Core::$urls['host'] . '/set_info/' . $data['id'] . '.html';
            return $mediaSpace;
        }

        return false;
    }

}

