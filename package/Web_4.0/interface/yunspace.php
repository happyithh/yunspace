<?php
Tpl_Smarty::assign('seo', array(
    '网页标题' => '关于云SPACE_上海星期网络科技有限公司 -【云SPACE-商业空间短租平台】',
    '网页关键词' => '关于云SPACE_上海星期网络科技有限公司 -【云SPACE-商业空间短租平台】',
    '网页简介' => '关于云SPACE_上海星期网络科技有限公司 -【云SPACE-商业空间短租平台】'
));
Tpl_Smarty::assign('nav','yunspace');
switch (Core::$urls['action']) {
    case  "about_us":
        Tpl_Smarty::display('Web_Static::about/about_us.tpl');
        break;
    case  "news":
        //获取yunspace的文章信息
        // Data_Mysql_Table_Raiders_Info::rebuildIndex();
        $article_list=Web_Baike_New::getArticles(array('space_ids'=>9721),'','','',10);
        Tpl_Smarty::assign('article',$article_list);
        Tpl_Smarty::display('Web_Static::about/news.tpl');
        break;
    case  "business":
        Tpl_Smarty::display('Web_Static::about/about_business.tpl');
        break;
    case  "recruitment":
        Tpl_Smarty::display('Web_Static::about/about_recruitment.tpl');
        break;
    case  "contact_us":
        Tpl_Smarty::display('Web_Static::about/about_contact_us.tpl');
        break;
    case  "agreement":
        Tpl_Smarty::display('Web_Static::about/about_agreement.tpl');
        break;
    case  "drawback":
        Tpl_Smarty::display('Web_Static::about/about_drawback.tpl');
        break;
    case  "question":
        Tpl_Smarty::display('Web_Static::about/about_question.tpl');
        break;
    case  "feedback":
        Tpl_Smarty::display('Web_Static::about/about_feedback.tpl');
        break;
}
