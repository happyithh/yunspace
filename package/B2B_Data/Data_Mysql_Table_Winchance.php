<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/8
 * Time: 16:36
 */
Class  Data_Mysql_Table_Winchance extends Data_Mysql_Table
{
    public $cols = array(
        'title' => '200',                       //文创标题
        'marketing_title' => '200',             //营销副标题
        'author' => '20',                       //作者
        'category'=>'int',                      //文创类别
        'create_time' => 'int',                 //创建时间
        'update_time' => 'int',                 //更新时间
        'media' => 'array',                     //图片
        'status' => 'tinyint',                  //0下线，1上线
        'tags_info' => 'array',                 //标签 关键词
        'attr' => 'array',                      //来源，面积，适应人群
        'accessory' =>'array' ,                 //上传的文件
        'download_num' => 'int',                //下载量
        'order_lv' => 'int',                    //排名权重，数字越大越靠前
        //新添加
        'resource_name'=>'string', //资源的名词就是Ip名词
        'yun_principal'=>'int',//云负责人
        'manifestation'=>'string', //表现形式
        'operation_range'=>'string', //运营范围
        'cooperating_state'=>'string',//合作状态
        'cooperating_mode'=>'string',//合作模式
        'conform_crowd'=>'string',//符合人群
        'area'=>'int',  //面积
        'remarks'=>'text'
    );

    public $index = array(
        'title' => 'title',
        'resource_name'=>'title',
        'yun_principal'=>'i',
        'category'=>'i',
        'manifestation'=>'i',
        'operation_range'=>'i',
        'cooperating_state'=>'i',
        'conform_crowd'=>'i',
        'tags_info'=>'attr',
    );

    //状态
    public static $status = array(
        1 => '上线',
        -1 => '下线',
    );
    //分类
    public static $category = array(
        1=>'亲子',
        2=>'卡通',
        3=>'艺术',
        4=>'互动',
        5=>'市集',
        6=>'冒险',
        7=>'科技',
        8=>'可爱',
        9=>'时尚',
        10=>'家庭',
        11=>'动漫',
        12=>'影视',
        13=>'游戏',
        14=>'运动',
        15=>'动漫卡通',
        16=>'生活'
    );
    //云负责人
    public static $yun_principal  =array(
        85=>'Applecheng',
        27=>'yvon',
        206=>'angee',
        37=>'kingsley',
        -1=>'其他'
    );
    //资源来源国家
    public static $resource_form=array(
        "中国",
        "日本",
        "韩国",
        "美国",
        "英国",
        "法国",
        "德国",
        "芬兰",
        "台湾",
        "奥地利",
        "北美",
        "亚洲",
        "国际",
        "其他",
    );
    //表现形式
    public static $manifestation = array(
        "市集",
        "体验",
        "演出",
        "展览",
        "主题陈列",
        "主题活动",
        "其他",
    );
    //运营范围 (城市不能引用 Web_Global()里的啊)
    public  static $citys =  array(
        'quanguo' => '全国',
        'yixianchengshi' => '一线城市',
        'sh' => '上海',
        'bj' => '北京',
        'gz' => '广州',
        'sz' => '深圳',
        'cd' => '成都',
        'hz' => '杭州',
        'nj' => '南京',
        'suzhou' => '苏州',
        'chongqing' => '重庆',
        'wuhan' => '武汉',
        'xian' => '西安',
        'changsha' => '长沙',
        'nanchang' => '南昌',
        'guiyang' => '贵阳',
        'dalian' => '大连',
        'qingdao' => '青岛',
        'xiameng' => '厦门',
        'taiyuan' => '太原',
        'kunming' => '昆明',
        'dali' => '大理',
        'lijiang' => '丽江',
        'tengchong' => '腾冲',
        'xsbn' => '西双版纳',
        'qita' => '其他',
        );
    //授权金
    public static $authorization_money =array(
        "一次",
        "一年",
        "其他",
    );
    //场地面积
    public static $area_array = array(
        1=>"<100",
        2=>"100-500",
        3=>"500-1000",
        4=>"1000-3000",
        5=>"3000以上",
        6=>"其他",
    );
    //年限
    public static $life_array=array(
        1=>"1年",
        2=>"1-3年",
        3=>"3-5年",
        4=>"5-20年",
        5=>"20-50年",
        6=>"50以上年",
        7=>"其他",
    );
    //物料
    public static $materiel =array(
        '进口',
        '国产',
        '港台',
        '现成',
        '定制',
        '其他',
    );
    //合作状态
    public static $cooperating_state_array =array(
        'A',
        'B',
        'C',
        'D',
        '其他',
    );
    //价格分类
    public static $price_category_array =array(
        'A',
        'B',
        'C',
        'D',
        'E',
        '其他',
    );
    //合作模式
    public  static $cooperating_mode_array =array(
        "票务分成",
        "支付租金",
        "直接购买",
        "场地租赁",
        "分成",
        "买断",
        "买断/纯场租/门票分成",
        "买断和门票分成",
        "买断或分成",
        "买断或门票分成",
        "门票分成",
        "门票分成（场地贴装补优先考虑）",
        "门票分成5%-10%",
        "门票分成或买断",
        "票务合作，年会包场",
        "直接购买",
        "资源互换",
        "还未形成",
        "其他",
    );
    //运营团队国家
    public static $yunying_team_array= array(
        '大陆',
        '香港',
        '欧美',
        '日本',
        '韩国',
        '其他',
    );
    public static $conform_crowd_array=array(
                "0-12岁小朋友亲子互动活动",
                "10-29岁年轻群体",
                "15-45岁哈利波特爱好者",
                "18~35岁年轻人",
                "35岁以下年轻女性及家庭",
                "3岁-70岁所有人群",
                "3岁及以上人群",
                "70-90后所有圣斗士爱好者",
                "70-90年代所有大力水手爱好者",
                "70年-95年动漫迷",
                "80 90人群，格斗类游戏爱好者",
                "亲子",
                "以爱为名，打造一座泰迪熊爱的城堡",
                "体育爱好者、运动达人",
                "儿童",
                "儿童 青少年",
                "儿童,童话爱好者",
                "儿童,青少年",
                "儿童、家庭、情侣、泰迪爱好者",
                "儿童或充满童心的人群,花栗鼠爱好者",
                "儿童，青少年",
                "全球国家地理杂志的读者",
                "具有文艺气息的人群",
                "动漫 互动 经典",
                "动漫迷,青少年",
                "各年龄喜欢越狱兔的人群",
                "各年龄段喜欢宠物小精灵的人群",
                "各年龄段喜爱宫崎骏作品的群体",
                "各年龄段热爱小动物人士",
                "喜欢talking tom cat的多年龄层人群",
                "喜欢海绵宝宝的群体",
                "喜欢游戏的青年群体",
                "喜欢漫威英雄形象的所有人",
                "喜欢漫画中王子形象的人群",
                "喜欢猫和老鼠动画的各类人群",
                "喜爱卡通的青少年",
                "喜爱在夏天去水上乐园体验刺激",
                "喜爱小羊肖恩的所有人群",
                "喜爱机械战警的各类人群",
                "喜爱科技和美术结合的成人和小孩",
                "喜爱美乐蒂以及音乐的群众",
                "喜爱足球喜爱运动",
                "喜爱轻松熊的年轻女性",
                "大熊猫爱好者",
                "女性",
                "家庭,热爱科技的人群",
                "对于收集钱币有一定爱好的人群",
                "对传统文化和现代科技有一定认知",
                "对科技对蝙蝠侠喜爱的人群",
                "对艺术对科技创新有一定兴趣的人群",
                "小丸子漫画迷",
                "市集，购物，年轻，潮流",
                "年轻人",
                "年轻人,运动爱好者",
                "年轻喜欢新鲜事物的人群",
                "年轻爸妈及小孩",
                "年轻的亲子家庭",
                "年轻的兔斯基粉丝",
                "年轻群体,史努比忠实粉",
                "年轻群体，各类新社交媒体使用者",
                "年龄跨度极大，适合10-60岁各年龄",
                "恋爱中，失恋后，时尚潮人，怀旧人群",
                "悬疑惊悚喜爱者",
                "所有人群，尤其是热爱草本原生及养生的人群。",
                "所有几米漫画爱好者",
                "所有喜欢奈良美智的人群",
                "所有喜欢小黄人的群体",
                "所有喜欢愤怒小鸟游戏和形象的人群",
                "所有喜欢日本动漫的人群",
                "所有喜欢江南以及乾隆的人群",
                "所有喜欢陆战队的人",
                "所有喜爱刀刀的人群",
                "所有喜爱加菲猫的人群",
                "所有喜爱大熊猫想了解大熊猫的人群",
                "所有喜爱暴力熊的人群",
                "所有热爱动漫热爱二次元的人群",
                "所有热爱福音战士的人群",
                "排球少年喜爱者",
                "探险爱好者,骑行爱好者",
                "摄影热爱者，新闻界人士",
                "文艺爱好者",
                "文艺青年",
                "文艺青年,艺术工作者",
                "文艺青年、亲子",
                "文艺青年、密室爱好者",
                "文艺青年、青少年、亲子",
                "极品飞车游戏爱好者",
                "游戏动漫爱好者",
                "游戏爱好者，英雄情结",
                "潮人，积木熊爱好者",
                "热爱书画，喜爱徐悲鸿的人群",
                "热爱冰川世纪的所有人群",
                "热爱卡通的70-80后，日本通形象，喜爱时尚多元卡通形象",
                "热爱名侦探，热爱破案解密的人群",
                "热爱复古和市集的各类人群",
                "热爱拍照，热爱艺术喜欢猫咪的人群",
                "热爱时尚热爱粉红豹的人群",
                "热爱歌舞剧的年轻人群或企业年会特色活动",
                "热爱游戏的80后人群",
                "热爱画画的小朋友及年轻家庭群体",
                "热爱积木的家庭以及小孩",
                "爱好乐高积木或者星球大战的群体",
                "父母陪同的亲子家庭",
                "猫咪爱好者,动漫爱好者",
                "白领女性",
                "科幻迷，影迷",
                "经典重温",
                "经典重温，喜剧爱好者",
                "美食甜品爱好者",
                "萌物爱好者",
                "针对哆啦A梦粉丝、运动爱好者及亲子",
                "青少年、动漫爱好者",
                "青少年、电影、美国漫画爱好者",
                "青少年、美剧爱好者",
                "青少年（8-16）、电影、美国漫画爱好者",
                "其他"
    );

}