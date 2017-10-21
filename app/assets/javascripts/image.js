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