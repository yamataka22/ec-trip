require 'csv'
require 'nkf'

csv_str = CSV.generate do |csv|
  csv_column_names = %w(購入日時 注文番号 会員名 メールアドレス お届け先氏名(姓) お届き先氏名(名) お届け先電話番号 お届け先郵便番号 お届け先都道府県 お届け先住所 お届け先建物名 配送 配送日 メモ 商品ID 商品名 数量 小計 配送料 消費税 総額)
  csv << csv_column_names
  @purchases.each do |purchase|
    purchase.details.each_with_index do |detail, i|
      csv_column_values = []
      csv_column_values.push purchase.created_at.strftime('%Y/%m/%d %H:%M')
      csv_column_values.push purchase.purchase_no
      csv_column_values.push purchase.member.present? ? purchase.member.account_name : 'ゲスト購入'
      csv_column_values.push purchase.member.present? ? purchase.member.email : purchase.guest_email
      csv_column_values.push purchase.delivery_last_name
      csv_column_values.push purchase.delivery_first_name
      csv_column_values.push purchase.delivery_phone
      csv_column_values.push purchase.delivery_postal_code
      csv_column_values.push purchase.delivery_prefecture.name
      csv_column_values.push purchase.delivery_address1
      csv_column_values.push purchase.delivery_address2
      csv_column_values.push purchase.delivered? ? '済' : '未'
      csv_column_values.push purchase.delivered? ? purchase.delivered_at&.strftime('%Y/%m/%d') : ''
      csv_column_values.push purchase.remarks
      csv_column_values.push detail.item.id
      csv_column_values.push detail.item.name
      csv_column_values.push detail.quantity
      csv_column_values.push i == 0 ? purchase.item_amount : ''
      csv_column_values.push i == 0 ? purchase.delivery_fee : ''
      csv_column_values.push i == 0 ? purchase.tax : ''
      csv_column_values.push i == 0 ? purchase.total_amount : ''
      csv << csv_column_values
    end

  end
end

NKF::nkf('--sjis -Lw', csv_str)