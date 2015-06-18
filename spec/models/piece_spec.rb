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

  describe "next_piece and prev_piece" do

    it "selects prev and next for piece" do
      relation = Piece.all_by_created_at.offset(0).limit(3)
      expect(Piece.prev_piece(1)).to eq(relation[0])
      expect(Piece.next_piece(1)).to eq(relation[2])
    end

    it "selects next piece and sets prev piece to nil for offset 0" do
      relation = Piece.all_by_created_at.limit(2)
      expect(Piece.prev_piece(0)).to eq(nil)
      expect(Piece.next_piece(0)).to eq(relation[1])
    end

  end
end
