<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/23
 * Time: 15:21
 */
class OA_Home_Page
{
    static function handle()
    {
        $type = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];

        switch ($type) {
            case 'home':
                self::handleHomeContent();
                break;
            case 'banner':
                self::handleHomeBanner();
                break;

        }
    }
    static function handleHomeBanner()
    {
        /*if (empty($_REQUEST['city'])) {
            $_REQUEST['city'] = '上海';
        }*/
        $banner = Web_HomePage_V2::get('banner');
        $banner_mobile = Web_HomePage_V2::get('banner_mobile');
        //首页banner
        if (empty($banner) || !is_array($banner)) {
            $banner = array();
            $banner_mobile = array();
        }
        if (empty($banner_mobile)) {
            $banner_mobile = Web_HomePage::get('banner');
        }

        //精心推荐
        $specialRecommend = Web_HomePage_V2::get('specialRecommend');



        //这里是解决删除，最后一张删不掉的问题
        if (!empty($_REQUEST['data']['media'])) {
           // $banner[$_REQUEST['city']] = array();
            Web_HomePage_V2::set('banner', $banner);
        }
        unset($_REQUEST['data']['media']['$$']);
        unset($_REQUEST['data']['media_mobile']['$$']);
       // if (!empty($_REQUEST['data']['media']) && !empty($_REQUEST['city'])) {
            if (!empty($_REQUEST['data']['media'])) {
            foreach ($_REQUEST['data']['media'] as $k => $v) {
                if (empty($v['url'])) {
                    $_REQUEST['data']['media'][$k]['url'] = 'javascript::void(0)';
                }
            }
            $banner = array_values($_REQUEST['data']['media']);
            Web_HomePage_V2::set('banner', $banner);
        }
        //    if (!empty($_REQUEST['data']['media_mobile']) && !empty($_REQUEST['city']) && count($_REQUEST['data']['media_mobile']) > 0) {
           if (!empty($_REQUEST['data']['media_mobile']) && count($_REQUEST['data']['media_mobile']) > 0) {
            foreach ($_REQUEST['data']['media_mobile'] as $k => $v) {
                if (empty($v['url'])) {
                    $_REQUEST['data']['media_mobile'][$k]['url'] = 'javascript::void(0)';
                }
            }
           /* $banner_mobile[$_REQUEST['city']] = array_values($_REQUEST['data']['media_mobile']);*/
               $banner_mobile= array_values($_REQUEST['data']['media_mobile']);
            Web_HomePage_V2::set('banner_mobile', $banner_mobile);
            Web_HomePage::set('banner', $banner_mobile);
        }
           Tpl_Smarty::assign('_data', array(
               'media' => @array_values($banner),
               'media_mobile' => @array_values($banner_mobile),
           ));



        //精心推荐
        if (empty($specialRecommend)) {
            $specialRecommend_data = array(
                array('name' => '左上', 'path' => '', 'title' => '', 'url' => '', 'content' => '','category'=>'','categoryUrl'=>''),
                array('name' => '中上', 'path' => '', 'title' => '', 'url' => '', 'content' => '','category'=>'','categoryUrl'=>''),
                array('name' => '中左', 'path' => '', 'title' => '', 'url' => '', 'content' => '','category'=>'','categoryUrl'=>''),
                array('name' => '中右', 'path' => '', 'title' => '', 'url' => '', 'content' => '','category'=>'','categoryUrl'=>''),
                array('name' => '右上', 'path' => '', 'title' => '', 'url' => '', 'content' => '','category'=>'','categoryUrl'=>''),
                array('name' => '右下', 'path' => '', 'title' => '', 'url' => '', 'content' => '','category'=>'','categoryUrl'=>''),
            );
            Tpl_Smarty::assign('_data3', array(
                'specialRecommend' => $specialRecommend_data,
            ));
        } else {
            if (empty($specialRecommend['精心推荐'][5])) {
                $specialRecommend['精心推荐'][5] = array('name' => '超值套餐', 'path' => '', 'url' => '', 'content' => '');
            }
        }


        if (!empty($_FILES)) {
            $files = $_FILES;
            foreach ($files as $k => $val) {
                if ($val['error'] == 0) {
                    $headImg = Func_Upload::image($k);
                    $upload = explode('upload', $k);

                    if (isset($upload[1]) && $k == 'upload' . $upload[1]) {
                        $_REQUEST['data']['specialRecommend']['精心推荐'][$upload[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['specialRecommend']['精心推荐'][$upload[1]]['url'])) {
                            $_REQUEST['data']['specialRecommend']['精心推荐'][$upload[1]]['url'] = 'javascript::void(0)';
                        }
                    }
                }
            }
        }



        if (!empty($_REQUEST['data']['specialRecommend'])) {
            $specialRecommend = $_REQUEST['data']['specialRecommend'];
//            q($_REQUEST);
            Web_HomePage_V2::set('specialRecommend', $specialRecommend);
        }
        if (!empty($specialRecommend['精心推荐'])) {
            Tpl_Smarty::assign('_data3', array('specialRecommend' => $specialRecommend['精心推荐']));
        }

        Tpl_Smarty::display('OA_Static::website/home_page/banner2.tpl');

    }


    static function handleHomeContent()
    {
        if (empty($_REQUEST['city'])) {
            $_REQUEST['city'] = '上海';
        }
        //超值套餐
        $goldPosition = Web_HomePage_V2::get('goldPosition');
        //广告位
      //  $advertising = Web_HomePage_V2::get('advertising');

        if (!empty($_FILES)) {
            $files = $_FILES;
            foreach ($files as $k => $val) {
                if ($val['error'] == 0) {
                    $headImg = Func_Upload::image($k);
                   // $upload = explode('upload', $k);
                    $gold = explode('gold', $k);
                    $advertise=explode('advertise',$k);
                    $show = explode('show',$k);
                    $business = explode('business',$k);
                    $club = explode('club',$k);
                    $services = explode('services',$k);

                        //设置超值套餐
                   if (isset($gold[1]) && $k == 'gold' . $gold[1]) {
                        $_REQUEST['data']['goldPosition']['超值套餐'][$gold[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['goldPosition']['超值套餐'][$gold[1]]['url'])) {
                            $_REQUEST['data']['goldPosition']['超值套餐'][$gold[1]]['url'] = 'javascript::void(0)';
                        }
                        //设置广告位
                    }/*elseif(isset($advertise[1]) && $k == 'advertise' . $advertise[1]) {
                        $_REQUEST['data']['advertising']['广告位'][$advertise[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['advertising']['广告位'][$advertise[1]]['url'])) {
                            $_REQUEST['data']['advertising']['广告位'][$advertise[1]]['url'] = 'javascript::void(0)';
                        }
                        //秀场展馆
                    }*/elseif(isset($show[1]) && $k == 'show' . $show[1]) {
                        $_REQUEST['data']['showPosition']['秀场展馆'][$show[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['showPosition']['秀场展馆'][$show[1]]['url'])) {
                            $_REQUEST['data']['showPosition']['秀场展馆'][$show[1]]['url'] = 'javascript::void(0)';
                        }
                        //商业广场
                    }elseif(isset($business[1]) && $k == 'business' . $business[1]) {
                        $_REQUEST['data']['businessPosition']['商业广场'][$business[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['businessPosition']['商业广场'][$business[1]]['url'])) {
                            $_REQUEST['data']['businessPosition']['商业广场'][$business[1]]['url'] = 'javascript::void(0)';
                        }
                        //高端会所
                    }elseif(isset($club[1]) && $k == 'club' . $club[1]) {
                        $_REQUEST['data']['clubPosition']['高端会所'][$club[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['clubPosition']['高端会所'][$club[1]]['url'])) {
                            $_REQUEST['data']['clubPosition']['高端会所'][$club[1]]['url'] = 'javascript::void(0)';
                        }
                        //配套服务
                    }elseif(isset($services[1]) && $k == 'services' . $services[1]) {
                        $_REQUEST['data']['servicesPosition']['配套服务'][$services[1]]['path'] = $headImg;
                        if (empty($_REQUEST['data']['servicesPosition']['配套服务'][$services[1]]['url'])) {
                            $_REQUEST['data']['servicesPosition']['配套服务'][$services[1]]['url'] = 'javascript::void(0)';
                        }
                    }

                }
            }
        }

        // 其他
        $hotContent = Web_HomePage_V2::get('hotContent');

        if (empty($hotContent) || !is_array($hotContent)) {
            $hotContent = array();
        }
        if (!empty($_REQUEST['data']['hotContent']) && !empty($_REQUEST['city'])) {
            $hotContent[$_REQUEST['city']] = $_REQUEST['data']['hotContent'];
            Web_HomePage_V2::set('hotContent', $hotContent);
        }
        // 热门空间的标题
        $hotTitle = Web_HomePage_V2::get('hotTitle');
        if (empty($hotTitle) || !is_array($hotTitle)) {
            $hotTitle = array();
        }
        if (!empty($_REQUEST['data']['hotTitle']) && !empty($_REQUEST['city'])) {
            $dataHotTitle = $_REQUEST['data']['hotTitle'];
            foreach ($dataHotTitle as $k => $v) {
                $dataHotTitle[$k] = str_replace('，', ',', $v);
            }
            $hotTitle[$_REQUEST['city']] = $dataHotTitle;
            Web_HomePage_V2::set('hotTitle', $hotTitle);
        }
        Tpl_Smarty::assign('_data2', array(
            'hotContent' => @$hotContent[$_REQUEST['city']],
            'hotTitle' => @$hotTitle[$_REQUEST['city']],
        ));


        //超值套餐设置
        if (!empty($_REQUEST['data']['goldPosition'])) {
            $goldPosition[$_REQUEST['city']] = $_REQUEST['data']['goldPosition'];
            Web_HomePage_V2::set('goldPosition', $goldPosition);
        }
        //超值套餐初始值
        if (empty($goldPosition[$_REQUEST['city']])) {
            $goldPosition_data = array(
                array('name' => '一', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '二', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '三', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '四', 'path' => '', 'title' => '', 'url' => ''),
            );
            Tpl_Smarty::assign('_data5', array(
                'goldPosition' => $goldPosition_data,
            ));
        }

        if (!empty($goldPosition[$_REQUEST['city']]['超值套餐'])) {
            Tpl_Smarty::assign('_data5', array('goldPosition' => $goldPosition[$_REQUEST['city']]['超值套餐']));
        }

        //秀场展馆设置
        if (!empty($_REQUEST['data']['showPosition'])) {
            $showPosition[$_REQUEST['city']] = $_REQUEST['data']['showPosition'];
            Web_HomePage_V2::set('showPosition', $showPosition);
        }
        //秀场展馆初始值
        if (empty($showPosition[$_REQUEST['city']])) {
            $showPosition_data = array(
                array('name' => '一', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '二', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '三', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '四', 'path' => '', 'title' => '', 'url' => ''),
            );
            Tpl_Smarty::assign('_data7', array(
                'showPosition' => $showPosition_data,
            ));
        }

        if (!empty($showPosition[$_REQUEST['city']]['秀场展馆'])) {
            Tpl_Smarty::assign('_data7', array('showPosition' => $showPosition[$_REQUEST['city']]['秀场展馆']));
        }

        //商业广场设置
        if (!empty($_REQUEST['data']['businessPosition'])) {
            $businessPosition[$_REQUEST['city']] = $_REQUEST['data']['businessPosition'];
            Web_HomePage_V2::set('businessPosition', $businessPosition);
        }
        //商业广场初始值
        if (empty($businessPosition[$_REQUEST['city']])) {
            $businessPosition_data = array(
                array('name' => '一', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '二', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '三', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '四', 'path' => '', 'title' => '', 'url' => ''),
            );
            Tpl_Smarty::assign('_data8', array(
                'businessPosition' => $businessPosition_data,
            ));
        }

        if (!empty($businessPosition[$_REQUEST['city']]['商业广场'])) {
            Tpl_Smarty::assign('_data8', array('businessPosition' => $businessPosition[$_REQUEST['city']]['商业广场']));
        }
//        q($businessPosition[$_REQUEST['city']]['商业广场']);

        //高端会所设置
        if (!empty($_REQUEST['data']['clubPosition'])) {
            $clubPosition[$_REQUEST['city']] = $_REQUEST['data']['clubPosition'];
            Web_HomePage_V2::set('clubPosition', $clubPosition);
        }
        //高端会所初始值
        if (empty($clubPosition[$_REQUEST['city']])) {
            $clubPosition_data = array(
                array('name' => '一', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '二', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '三', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '四', 'path' => '', 'title' => '', 'url' => ''),
            );
            Tpl_Smarty::assign('_data9', array(
                'clubPosition' => $clubPosition_data,
            ));
        }

        if (!empty($clubPosition[$_REQUEST['city']]['高端会所'])) {
            Tpl_Smarty::assign('_data9', array('clubPosition' => $clubPosition[$_REQUEST['city']]['高端会所']));
        }

        //配套服务设置
        if (!empty($_REQUEST['data']['servicesPosition'])) {
            $servicesPosition[$_REQUEST['city']] = $_REQUEST['data']['servicesPosition'];
            Web_HomePage_V2::set('servicesPosition', $servicesPosition);
        }
        //配套服务初始值
        if (empty($clubPosition[$_REQUEST['city']])) {
            $clubPosition_data = array(
                array('name' => '一', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '二', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '三', 'path' => '', 'title' => '', 'url' => ''),
                array('name' => '四', 'path' => '', 'title' => '', 'url' => ''),
            );
            Tpl_Smarty::assign('_data10', array(
                'servicesPosition' => $clubPosition_data,
            ));
        }

        if (!empty($servicesPosition[$_REQUEST['city']]['配套服务'])) {
            Tpl_Smarty::assign('_data10', array('servicesPosition' => $servicesPosition[$_REQUEST['city']]['配套服务']));
        }

   /*     //广告位设置
        if (!empty($_REQUEST['data']['advertising'])) {
            $advertising[$_REQUEST['city']] = $_REQUEST['data']['advertising'];
            Web_HomePage_V2::set('advertising', $advertising);
        }
        //广告位初始值设置
        if (empty($advertising[$_REQUEST['city']])) {
            $advertising_data = array(
                array('name' => '一', 'path' => '', 'title' => '', 'url' => '', 'content' => ''),
                array('name' => '二', 'path' => '', 'title' => '', 'url' => '', 'content' => ''),
                array('name' => '三', 'path' => '', 'title' => '', 'url' => '', 'content' => ''),
            );
            Tpl_Smarty::assign('_data6', array(
                'advertising' => $advertising_data,
            ));
        }
        if (!empty($advertising[$_REQUEST['city']]['广告位'])) {
            Tpl_Smarty::assign('_data6', array('advertising' => $advertising[$_REQUEST['city']]['广告位']));
        }*/
        Tpl_Smarty::display('OA_Static::website/home_page/v2.tpl');
    }


}