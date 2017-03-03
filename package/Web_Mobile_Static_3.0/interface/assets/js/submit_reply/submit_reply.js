/**
 /**
 * Created by zzc on 2015/10/22.
 */

function sub_comments(e){
    var content = $('.new_content').val();
    if(content.trim()!=''){
        //var wx_pic =$('.new_tx-img')[0].src;      // 微信头像
        //var wx_name = $('.header-body-name').text();  // 微信昵称
        var space_id = $('.header-body-name').data('space-id');
        //var comments_id = $('.back-input').data('comment-id');  // 父级ID  回复评论时使用
        YunSpace.api('comments/create.jsonp', {
                content: content,
                space_id:space_id
                //comments_id:comments_id  // 回复评论时使用
            }, function (data) {

                if (data.status == 1) {

                }else{
                    alert(data.msg);
                }
            },
            'json'
        );
    }
}
