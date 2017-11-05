var stripe_js = {};
// stripe_js.showModal = function() {
//     var modal = $('#stripe_wrapper');
//     modal.find('.card_input').val('');
//     modal.find('.stripe_err_message').hide();
//     modal.modal();
// };

stripe_js.createToken = function() {
    var stripe_wrapper = $('#stripe_wrapper');
    stripe_wrapper.find('.stripe_err_message').hide();

    var card_number = stripe_wrapper.find('#card_number').val();
    var card_exp_month = stripe_wrapper.find('#card_exp_month').val();
    var card_exp_year = stripe_wrapper.find('#card_exp_year').val();
    var card_cvc = stripe_wrapper.find('#card_cvc').val();
    var card_name = stripe_wrapper.find('#card_name').val();

    var err_message = null;
    if (!card_number) err_message = 'カード番号を入力してください。';
    else if (!card_exp_month || !card_exp_year) err_message = '有効期限を入力してください。';
    else if (!card_cvc) err_message = 'セキュリティコードを入力してください。';
    else if (!card_name) err_message = 'カード名義を入力してください。';

    if (err_message) {
        stripe_wrapper.find('.stripe_err_message').text(err_message);
        stripe_wrapper.find('.stripe_err_message').show();
    } else {
        stripe_wrapper.find('.btn').prop('disabled', true);
        Stripe.card.createToken({
            number:     card_number,
            cvc:        card_cvc,
            exp_month:  card_exp_month,
            exp_year:   card_exp_year,
            name:       card_name
        }, stripe_js.responseHandler);
    }
    return false;
};

stripe_js.responseHandler = function(status, response) {
    var stripe_wrapper = $('#stripe_wrapper');
    if (response.error) {
        stripe_wrapper.find('.stripe_err_message').text(
            stripe_js.ja_message[response.error.message] || "このカードは使用できません。"
        );
        stripe_wrapper.find('.stripe_err_message').show();
        stripe_wrapper.find('.btn').prop('disabled', false);
    } else {
        stripe_wrapper.find('form').append($('<input type="hidden" name="stripe_token" />').val(response.id));
        stripe_wrapper.find('#stripe_submit').click();
    }
};

stripe_js.ja_message = {
    "Your card number is incorrect.": "カード番号が正しくありません。カード番号をお確かめください。",
    "The card number is not a valid credit card number.": "カード番号は有効なクレジットカード番号ではありません。",
    "Your card's expiration month is invalid.": "カードの有効期限が無効です。有効期限をお確かめください。",
    "Your card's expiration year is invalid.": "カードの有効期限が無効です。有効期限をお確かめください。",
    "Your card's security code is invalid.": "カードのセキュリティコードが無効です。",
    "Your card has expired.": "カードの有効期限が過ぎています。",
    "Your card's security code is incorrect.": "セキュリコードが正しくありません。",
    "Your card was declined.": "カードが拒否されました。別のカードをお試しください。",
    "There is no card on a customer that is being charged.": "このカードは使用できません。別のカードをお試しください。",
    "An error occurred while processing the card.": "決済処理中にエラーが発生しました。別のカードをお試しください。",
    "An error occurred due to requests hitting the API too quickly. Please let us know if you're consistently running into this error.": "処理中にタイムアウトとなりました。この現象が続く場合はお問い合わせください。",
    "Merchant do not support accepting in unknown card": "カード番号が正しくありません。カード番号をお確かめください。"
};