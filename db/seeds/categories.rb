%w(リビング特集 オフィス特集 ソファ テーブル チェア その他).each do |name, i|
  Category.create_with_auto_sequence(name: name)
end

sofa = Category.find_by(name: 'ソファ')
%w(1人掛けソファ 2人掛けソファ 3人掛けソファ カウチソファ).each do |name|
  Category.create_with_auto_sequence(name: name, root_category: sofa)
end

table = Category.find_by(name: 'テーブル')
%w(60-120cm 120-150cm 150cm-).each do |name|
  Category.create_with_auto_sequence(name: name, root_category: table)
end