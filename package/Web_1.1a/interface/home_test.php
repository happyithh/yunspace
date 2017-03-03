<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/12/4
 * Time: 下午2:19
 */
 switch(Core::$urls['action']){
     case "":
         Tpl_Smarty::display('Web_Static', 'home/index.tpl');
         break;
     case "inc":
          Tpl_Smarty::display('Web_Static', 'baike.v1.0/inc/person_side.tpl');
         break;
     case "inc_two":
          Tpl_Smarty::display('Web_Static', 'baike.v1.0/inc/baike_comment.tpl');
         break;
     case "inc_three":
          Tpl_Smarty::display('Web_Static', 'inc/consult_list.tpl');
         break;
     case "baike":
          Tpl_Smarty::display('Web_Static', 'baike.v1.0/baike.tpl');
         break;
     case "news":
         Tpl_Smarty::display('Web_Static', 'baike.v1.0/news.tpl');
         break;
     case "noresult":
         Tpl_Smarty::display('Web_Static', 'baike.v1.0/news_noresult1.tpl');
         break;
     case 'classify':
         Tpl_Smarty::display('Web_Static','classify/classify.tpl');
         break;
     case 'article':
         Tpl_Smarty::display('Web_Static','article/article-content.tpl');
         break;
     case "get_space":
         Tpl_Smarty::display('Web_Static', 'get_space/get_space.tpl');
         break;
     case "form_space":
         Tpl_Smarty::display('Web_Static', 'get_space/form_space.tpl');
         break;
     case "success":
         Tpl_Smarty::display('Web_Static', 'get_space/success.tpl');
         break;
     case "m/comment":
         Tpl_Smarty::display('Web_Mobile_Static::comment/comment.tpl');
         break;
     case "comment_back":
         Tpl_Smarty::display('Web_Mobile_Static', 'comment/comment_back.tpl');
         break;
     case "consultation":
         Tpl_Smarty::display('Web_Mobile_Static', 'consultation/consultation.tpl');
         break;
     case "m/article":
         Tpl_Smarty::display('Web_Mobile_Static', 'articles/article.tpl');
         break;
     case "article_list":
         Tpl_Smarty::display('Web_Mobile_Static', 'articles/article_list.tpl');
         break;
     case "encyclopedias":
         Tpl_Smarty::display('Web_Mobile_Static', 'encyclopedias/encyclopedias.tpl');
         break;
     case "text":
         Tpl_Smarty::display('Web_Static', 'article/article_text.tpl');
         break;
 }
