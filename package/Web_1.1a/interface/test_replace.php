<?php
/**
 * Created by PhpStorm.
 * User: liusc
 * Date: 15/12/29
 * Time: 上午11:05
 */
q(Page_Site_Global::displayMedia('http://www.yunspace.com.cn/upload/image/20140520/052011253978.jpg',100,200));

$str = '<p>
    ewewewewqew测试测试qewq试测试,oasodfpasdifopasdfo试测试测试测试试测试试测试pasdifapodf
</p>
<p>
    腐蚀毒粉红记得是<img src="/static/editor/upload/ue/0/img/20151228/1451304935796130.jpg" title="是对方的说法但测试测试是放到是发生撒旦.jpg" alt="是对方的说法但是测试测试放到是发生撒旦.jpg"/>
</p><p>
    ewewewewqew测试测试qewq试测试,oasodfpasdifopasdfo试测试测试测试试测试试测试pasdifapodf
</p>
<p>
    腐蚀毒粉红记得是<img src="/static/editor/upload/ue/0/img/20151228/1451304935796130.jpg" title="是对方的说法但测试测试是放到是发生撒旦.jpg" alt="是对方的说法但是测试测试放到是发生撒旦.jpg"/>
</p>';


$src = array('测试测试'=>'<><>测试测试测试测试<><>');

//$str2 = preg_replace('/(\>([^\<])*'.$src.'([^\<]*)\<)+/i','>$$$1$$$<','>'.$str.'<',10);
q($str,Func_String::tagsReplace($str,$src));