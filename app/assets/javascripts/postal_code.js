function search_address(postal_code, prefecture, address1) {
    document.activeElement.blur();
    if (postal_code === '') {
        alert('郵便番号を入力してください');
        return false;
    }
    $.ajax({
        url: '/postal_codes/' + postal_code,
        type: 'get'
    }).done(function(response) {
        if (response.message == null) {
            if (response.results == null) {
                alert('該当する郵便番号が見つかりませんでした');
            } else {
                var result = response.results[0];
                $(prefecture).val(result.prefcode);
                $(address1).val(result.address2 + result.address3);
            }
        } else {
            alert(response.message);
        }
    });
}