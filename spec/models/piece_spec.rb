require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "Validations" do
    specify { expect(subject).to validate_presence_of(:title)}
    specify { expect(subject).to validate_length_of(:title).is_at_least(3)}
    specify { expect(subject).to validate_length_of(:title).is_at_most(128)}
    specify { expect(subject).to validate_length_of(:description).is_at_most(300)}
    specify { expect(subject).to validate_presence_of(:image)}
  end

  describe "Associations" do
    specify { expect(subject).to belong_to(:user) }
  end

  describe "Scopes" do
    it "retreives all pieces ordered by created_at with :all_by_created_at" do
      piece1 = FactoryGirl.create(:piece)
      piece2 = FactoryGirl.create(:piece)
      piece3 = FactoryGirl.create(:piece)

      pieces = Piece.all_by_created_at
      expect(pieces).to eq([piece3, piece2, piece1])

    end
  end
end
