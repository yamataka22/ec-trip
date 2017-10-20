tables = %w(managers categories)

tables.each do |table|
  require(Rails.root.join('db', 'seeds', "#{table}.rb"))
end
