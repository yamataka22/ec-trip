var image_select = {};

image_select.dialog = $('#image_select_dialog');
image_select.file = image_select.dialog.find('.image_file');
image_select.btn_upload = image_select.dialog.find('.btn_select');
image_select.target = image_select.dialog.find('.target_class');

image_select.upload = function() {
    if (file_blank(image_select.file)) {
        alert('ファイルを指定してください');
        return false;
    }
    if (!check_size_and_type(image_select.file)) {
        alert('ファイルは3MB以内,jpg/png/gifのみ指定可能です。');
        return false;
    }
    image_select.btn_upload.text('処理中...');
    image_select.btn_upload.prop('disabled', true);
    var target_file = image_select.file.prop("files")[image_select.file.prop("files").length - 1];
    var form_data = new FormData();
    form_data.append('file', target_file);
    form_data.append('size_type', 'thumb');

    $.ajax({
        url: '/admin/images',
        type: 'post',
        dataType: 'json',
        cache: false,
        contentType: false,
        processData: false,
        data: form_data
    }).done(function(response) {
        if (response.error_message != undefined) {
            alert(response.error_message);
        } else {
            console.log(response.image.url);
            var target = $('.' + image_select.target.val());
            target.val(response.image.id);
            target.next().show();
            target.next().find('img').attr('src', response.image.url);
            image_select.dialog.modal('hide');
        }
    }).fail(function() {
        alert("エラーが発生しました。");
    }).always(function() {
        image_select.init_element();
    });
};

image_select.clear = function(previewElement, imageIdElement, self) {
    $(previewElement).html('');
    $(imageIdElement).val(null);
    $(self).parent().hide();
};

image_select.dialog.on('hide.bs.modal', function (e) {
    image_select.init_element();
});

image_select.init_element = function() {
    image_select.file.val('');
    image_select.previewElement = '';
    image_select.imageIdElement = '';
    image_select.btn_upload.text('選択');
    image_select.btn_upload.prop('disabled', false);
};

function file_blank(file) {
    return !(file.get(0) && file.get(0).files.length > 0);
}

function check_size_and_type(file, max_mega_byte, file_types) {
    var _max_mega_byte = max_mega_byte || 3;
    //最大ファイルサイズ5MB
    var max_file_size = _max_mega_byte * 1024 * 1024;
    //ファイルの選択肢
    var file_type_options = file_types || ["image/jpg", "image/jpeg", "image/png", "image/x-png", "image/gif"];

    //アップロードファイルが存在する場合のみ処理を行う
    if (!file_blank(file)){
        var file_type = file.get(0).files[0].type;
        var file_size = file.get(0).files[0].size;
        //ファイルタイプのチェック
        if(file_type_options.indexOf(file_type) == -1){
            return false;
        }
        //ファイルサイズのチェック
        if(file_size > max_file_size){
            return false;
        }
    }
    return true;
}

function file_clear(target) {
    var preview = $(target).closest('.preview');
    preview.hide();
    preview.prev().val('');
}