{static "find.v3.0/find_library_list.css"}
<div class="act-doc">
    {*<div class="act-doc-nav">*}
        {**}
        {*<div class="act-doc-nav-line"></div>*}
    {*</div>*}
    <div class="act-doc-body">
        <ul class="act-doc-body-header">
            <li style="width:80px;">类型</li>
            <li style="width:415px;text-align:left;padding-left: 10px;">文档名称</li>
            <li style="width:100px;">文件分类</li>
            <li style="width:100px;">下载量</li>
            <li style="width:100px;border: 0px;">文件大小</li>
        </ul>
        {foreach $page->getaccessory['rows'] as $v}
        <ul class="act-doc-body-list" style="border: 0;">
            <li style="width:80px;">
                {if $v['match'][1][0] == 'rar' || $v['match'][1][0] == 'zip'}
                    <img src="img/find.v3.0/rar_icon.png" alt="">
                {elseif $v['match'][1][0] == 'pdf'}
                    <img src="img/find.v3.0/pdf_icon.png" alt="">
                {elseif $v['match'][1][0] == 'png'}
                    <img src="img/find.v3.0/png_icon.png" alt="">
                {elseif $v['match'][1][0] == 'docx' || $v['match'][1][0] == 'doc'}
                    <img src="img/find.v3.0/word_icon.png" alt="">
                {elseif $v['match'][1][0] == 'pptx' || $v['match'][1][0] == 'ppt'}
                    <img src="img/find.v3.0/wps_icon.png" alt="">
                {elseif $v['match'][1][0] == 'xlsx' || $v['match'][1][0] == 'xls'}
                    <img src="img/find.v3.0/excel_icon.png" alt="">
                {elseif $v['match'][1][0] == 'txt' || $v['match'][1][0] == 'TXT'}
                    <img src="img/find.v3.0/txt_icon.png" alt="">
                {/if}
            </li>
            <li style="width:420px;text-align:left;padding-left: 10px;">
                <a href="{$_root}raiders-info/{$v['id']}.html">{$v['title']}</a>
            </li>
            <li style="width:100px;">
                {$v['category_name']}
            </li>
            <li style="width:100px;">
                <span>{$v['download']}次</span>
            </li>
            <li style="width:100px;">
                <span>{round(($v['accessory']['size'])/1024)}KB</span>
            </li>
        </ul>
        {/foreach}
        {*<ul class="act-doc-body-list" style="border: 0;">*}
            {*<li style="width:80px;">*}
                {*<img src="img/find.v3.0/word_icon.png" alt="">*}
            {*</li>*}
            {*<li style="width:436px;">*}
                {*<a href="#">512国际护士节活动方案</a>*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*活动方案*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*<span>16次</span>*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*<span>45K</span>*}
            {*</li>*}
        {*</ul>*}
        {*<ul class="act-doc-body-list" style="border: 0;">*}
            {*<li style="width:80px;">*}
                {*<img src="img/find.v3.0/word_icon.png" alt="">*}
            {*</li>*}
            {*<li style="width:436px;">*}
                {*<a href="#">512国际护士节活动方案</a>*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*活动方案*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*<span>16次</span>*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*<span>45K</span>*}
            {*</li>*}
        {*</ul>*}
        {*<ul class="act-doc-body-list" style="border: 0;">*}
            {*<li style="width:80px;">*}
                {*<img src="img/find.v3.0/word_icon.png" alt="">*}
            {*</li>*}
            {*<li style="width:436px;">*}
                {*<a href="#">512国际护士节活动方案</a>*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*活动方案*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*<span>16次</span>*}
            {*</li>*}
            {*<li style="width:100px;">*}
                {*<span>45K</span>*}
            {*</li>*}
        {*</ul>*}
    </div>
</div>