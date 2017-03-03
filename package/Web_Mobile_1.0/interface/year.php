<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/10/26
 * Time: 上午9:55
 */
$action = Core::$urls['action'];
@session_start();
$weekTime = strtotime('Monday');
if($weekTime>time()){
    $weekTime = strtotime('last Monday');
}
$rs = Data_Mysql_Table_YearMeeting_Vote::select('COUNT(*) as num,year_id',array('vote_time >= ?'=>$weekTime),"GROUP BY year_id ",4);//1文艺表演

//每个年会主题的总票数统计
$rs_all = Data_Mysql_Table_YearMeeting_Vote::select('COUNT(*) as num,year_id','',"GROUP BY year_id ",4);//1文艺表演
$counter = $counter_all = array();
foreach($rs as $v){
    $counter[$v['year_id']] = $v['num'];
}
foreach($rs_all as $v){
    $counter_all[$v['year_id']] = $v['num'];
}
Tpl_Smarty::assign('counter_all',$counter_all);
Tpl_Smarty::assign('counter',$counter);
$rs = Data_Mysql_Table_YearMeeting_Vote::select('COUNT(*) as c');
@Tpl_Smarty::assign('year_all',$rs[0]['c']);
if(!empty($_SESSION['openid'])){
    $rs_vote = Data_Mysql_Table_YearMeeting_Vote::select('id',array('openid'=>$_SESSION['openid']));
}
@Tpl_Smarty::assign('is_voted',!empty($rs_vote[0]['id']));
if(empty($action)) {
    @$year_arr = array(
        array('year_id'=>1,'color'=>'magenta','counter_all'=>$counter_all[1],'counter'=>$counter[1],'img_h'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/comn_img1.jpg','title'=>'文艺表演','des'=>'办一场更出彩文艺盛宴','counter_all'=>$counter_all[1],'counter'=>$counter[1],'detail'=>array(array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4684.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/st_img1.jpg','img_title'=>'宛如一场走秀般的年会——云space秀场年会'),array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4683.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/st_img2.jpg','img_title'=>'体验异国风味的年会——墨西哥艺术中心'),array('href'=>'http://www.yunspace.com.cn/raiders-info/4696.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/st_img3.jpg','img_title'=>'韩国最牛喜剧jump show万圣节/年会套餐攻略！！！'))),
        array('year_id'=>2,'color'=>'yellow','counter_all'=>$counter_all[2],'counter'=>$counter[2],'img_h'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/comn_img3.jpg','title'=>'度假旅游','des'=>'年会也可以边走边看','counter_all'=>$counter_all[2],'counter'=>$counter[2],'detail'=>array(array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4690.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sd_img1.jpg','img_title'=>'吃住京城，年会还可以这么办！'),array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4692.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sd_img2.jpg','img_title'=>'吃货的年会之旅|舌尖上的广州'),array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4467.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sd_img3.jpg','img_title'=>'边开年会边旅游，会奖旅游最佳目的地——上海'))),
        array('year_id'=>3,'color'=>'lightblue','counter_all'=>$counter_all[3],'counter'=>$counter[3],'img_h'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/comn_img2.jpg','title'=>'创意内容','des'=>'给员工一个有范儿的年会!','counter_all'=>$counter_all[3],'counter'=>$counter[3],'detail'=>array(array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4689.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sc_img1.jpg','img_title'=>'像“奥斯卡”颁奖礼那样办年会'),array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4688.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sc_img2.jpg','img_title'=>'年会走红毯，体验明星"范”'),array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4687.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sc_img3.jpg','img_title'=>'年会一起变"大咖"'))),
        array('year_id'=>4,'color'=>'deepblue','counter_all'=>$counter_all[4],'counter'=>$counter[4],'img_h'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/comn_img4.jpg','title'=>'特色餐饮','des'=>'致那些吃货员工们','counter_all'=>$counter_all[4],'counter'=>$counter[4],'detail'=>array(array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4691.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sts_img1.jpg','img_title'=>'年会值得期待的美食 年会也要高大上'),array('href'=>'http://www.yunspace.com.cn/m/raiders-info/4466.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sts_img2.jpg','img_title'=>'现在魔都办一场高贵露台年会，这些地方你不可错过'),array('href'=>'http://pre0.yunspace.com.cn/raiders-info/4694.html','img'=>'/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/sts_img3.jpg','img_title'=>'为十二星座特别定制年会晚宴')))
    );
    shuffle($year_arr);
    Tpl_Smarty::assign('year_arr',$year_arr);
    Tpl_Smarty::display('Web_Mobile_Static::wechat_year/year_index.tpl');
} elseif ($action == 'vote') {
    Web_Account::handleIsLogin('');
    //请求接口

    //如果没有openid提示在微信端打开
    if(empty($_SESSION['openid'])) {
        Func_Header::to('请在微信客户端打开链接',Core::$urls['root'].Core::$urls['package'].Core::$urls['route']);
    }
    $request = Func_Input::filter(array(
        'year_id' => 'int',
    ),$_REQUEST);

    $rs_vote = Data_Mysql_Table_YearMeeting_Vote::select('year_id',array('user_id'=>$_SESSION['user']['id']));
//    q($rs_vote);
    if(!empty($rs_vote[0])) {
        //您已经投过票啦，请继续关注后续中奖情况~",
        Tpl_Smarty::assign('vote_year',$rs_vote[0]['year_id']);
        Tpl_Smarty::display('Web_Mobile_Static::wechat_year/year_repeat1.php.tpl');
    } elseif (empty($rs_vote[0])) {
        //评论点赞成功则插入表
        $rs = Data_Mysql_Table_YearMeeting_Vote::insert(array('year_id' => $request['year_id'], 'user_id' => $_SESSION['user']['id'], 'vote_time' =>time(),'openid'=>$_SESSION['openid'],'vote' => 1));
        if ($rs[0] > 0) {
            //投票成功
            Tpl_Smarty::display('Web_Mobile_Static::wechat_year/year_vote1.php.tpl');
        } else {
            //投票失败
            Func_Header::to('未知错误, 请联系客服:400-056-0599',Core::$urls['root'].Core::$urls['package'].Core::$urls['route']);
        }
    }
}



