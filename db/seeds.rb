tables = %w(managers taxes categories sliders)

tables.each do |table|
  require(Rails.root.join('db', 'seeds', "#{table}.rb"))
end
