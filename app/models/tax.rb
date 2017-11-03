class Tax < ApplicationRecord
  @@tax = nil
  def self.now
    if @@tax && @@last_date == Date.current
      @@tax
    else
      @@tax = Tax.where('start_date <= ?', Date.current).order(:start_date).last.rate.to_f * 0.01 + 1
      @@last_date = Date.current
      @@tax
    end
  end
end
