<?php
/**
 *
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/4/9
 *  @首页banner 过度页
 */
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
    Func_Header::notFound();
}

switch(substr(Core::$urls['action'],0, -5))
{
    case 'baoshanxiuchang':
        Tpl_Smarty::display('Web','baoshan_xiuchang.tpl');
        break;

}
