%w(テーブル チェア キャビネット キッチン その他).each.with_index(1) do |name, i|
  Category.create(name: name, sequence: i)
end
