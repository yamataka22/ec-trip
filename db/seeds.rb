tables = %w(managers taxes categories sliders static_pages)

tables.each do |table|
  require(Rails.root.join('db', 'seeds', "#{table}.rb"))
end
