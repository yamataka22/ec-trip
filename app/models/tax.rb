class Tax < ApplicationRecord
  @@tax = nil
  def self.now
    if @@tax && @@last_date == Date.today
      @@tax
    else
      @@tax = Tax.where('start_date <= ?', Date.today).order(:start_date).last.rate.to_f * 0.01 + 1
      @@last_date = Date.today
      @@tax
    end
  end
end
