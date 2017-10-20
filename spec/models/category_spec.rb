require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validate' do
    it 'nameは必須であること' do
      category = Category.new(name: '')
      expect(category).not_to be_valid
      expect(category.errors[:name]).to be_present
    end
  end

  describe 'change_sequence' do
    it '前方のシーケンスのカテゴリーと入れ替えができること' do
      category1 = create(:category, sequence: 1)
      category2 = create(:category, sequence: 2)
      category2.change_sequence(:up)
      expect(category1.reload.sequence).to eq(2)
      expect(category2.reload.sequence).to eq(1)
    end

    it '後方のシーケンスのカテゴリーと入れ替えができること' do
      category1 = create(:category, sequence: 1)
      category2 = create(:category, sequence: 2)
      category1.change_sequence(:down)
      expect(category1.reload.sequence).to eq(2)
      expect(category2.reload.sequence).to eq(1)
    end

    it '前方にカテゴリーがない場合、シーケンスに変化が無いこと' do
      category = create(:category, sequence: 1)
      category.change_sequence(:up)
      expect(category.reload.sequence).to eq(1)
    end

    it '後方にカテゴリーがない場合、シーケンスに変化が無いこと' do
      category = create(:category, sequence: 1)
      category.change_sequence(:down)
      expect(category.reload.sequence).to eq(1)
    end
  end

  describe 'before_destroy' do
    it 'Itemが登録されているカテゴリーは削除できないこと' do
      category = create(:category)
      create(:item, category_id: category.id)
      expect(category.before_destroy).to be false
      expect(category.errors[:base]).to be_present
    end

    it 'Itemが登録されていないカテゴリーは削除できること' do
      category = create(:category)
      expect(category.before_destroy).to be true
      category.destroy
      expect{category.reload}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
