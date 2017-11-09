class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :member
  belongs_to_active_hash :prefecture

  accepts_nested_attributes_for :member

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :phone, presence: true
  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :address1, presence: true

  def full_name
    "#{self.last_name} #{first_name}"
  end

  def invoice_create
    self.invoice = true
    if self.valid?
      self.save!
      self.member.main_address_id = self.id
      self.member.save
      true
    else
      false
    end
  end

  def destroy
    if super
      # メイン住所IDもクリアする
      self.member.main_address_id = nil if self.member.main_address_id == self.id
    else
      false
    end
  end

end
