<?php
switch(Core::$urls['action']){
    case 'download':
        Tpl_Smarty::display('Web', 'app.tpl');
        break;
}