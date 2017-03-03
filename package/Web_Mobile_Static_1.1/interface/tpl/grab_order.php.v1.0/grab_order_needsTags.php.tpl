<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}

    <title>标签修改-【云·SPACE】</title>
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "select2/select2.css"}
    {static "select2/select2.min.js"}


</head>
<body>

<div class="update-records" style="height: 500px;">
    <div class="update-records-title">更新标签</div>
    <div class="update-records-cont " style="padding-top: 20px;">
        <div class="col clearfix" style="text-align: center;border-bottom: none">
            <input id="tags-select" style="width: 80%;height: 40px" class="select2 tags_select2" type="text"
                   data-values="{$tags}" value=""/>
        </div>

        <button class="update-btn " onclick="changeTags()" style="margin-top: 75%">
            提交
        </button>
    </div>
</div>

{*<div style="text-align: center;margin-top: 50px;height: 100%;">*}
{*<div style="margin: 10px">标签</div>*}
{*<input id="tags-select" style="width: 80%;height: 40px" class="select2 tags_select2" type="text"*}
{*data-values="{$tags}" value=""/>*}
{*<br/>*}
{*<button class="update-btn js-update-btn" onclick="changeTags()">*}
{*提交*}
{*</button>*}
{*<button style="width: 100px;height: 30px;margin-top: 10px;" onclick="changeTags()">提交</button>*}
{*</div>*}
<script>
    $(document).ready(function () {
        var tagsString = localStorage.getItem('needsTags');
        if (tagsString) {
            $('#tags-select').val(tagsString);
        }
        $('#tags-select').select2({
            tags: $('#tags-select').attr('data-values').split(','),
            placeholder: "请输入",
            minimumInputLength: 1,
            multiple: true,
            separator: ",",                             // 分隔符
            maximumSelectionSize: 5,                               // 限制数量
            initSelection: function (element, callback) {   // 初始化时设置默认值
                var data = [];
                $(element.val().split(",")).each(function () {
                    if (this != '') {
                        data.push({
                            id: this, text: this
                        });
                    }
                });
                callback(data);
            },
            createSearchChoice: function (term, data) {           // 创建搜索结果（使用户可以输入匹配值以外的其它值）
                return {
                    id: term, text: term
                };
            },
            formatSelection: function (item) {
                return item.id;
            },  // 选择结果中的显示
            formatResult: function (item) {
                return item.id;
            }
        })
    })

    function changeTags() {
        var val = $("#tags-select").val();
        localStorage.setItem('needsTags', val);
        self.location = document.referrer;
    }

</script>
</body>

</html>