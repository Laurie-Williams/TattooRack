require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "Validations" do
    specify { expect(subject).to validate_presence_of(:title)}
    specify { expect(subject).to validate_length_of(:title).is_at_most(128)}
    specify { expect(subject).to validate_length_of(:description).is_at_most(300)}
    specify { expect(subject).to validate_presence_of(:image)}
  end

  describe "Associations" do
    specify { expect(subject).to belong_to(:user) }
  end

  describe "next_piece and prev_piece" do
    before :all do
      @piece1 = FactoryGirl.create(:piece)
      @piece2 = FactoryGirl.create(:piece)
      @piece3 = FactoryGirl.create(:piece)
    end

    it "selects prev user piece" do
      expect(@piece2.prev_user_piece).to eq(@piece3)
    end

    it "selects next user piece" do
      expect(@piece2.next_user_piece).to eq(@piece1)
    end

    it "selects prev list piece" do
      @piece2.offset = 1
      expect(@piece2.prev_list_piece).to eq(@piece3)
    end

    it "selects next list piece" do
      @piece2.offset = 1
      expect(@piece2.next_list_piece).to eq(@piece1)
    end

    context "when piece is first user's piece" do
      it "selects prev user piece" do
        expect(@piece3.prev_user_piece).to eq(nil)
      end

      it "selects next user piece" do
        expect(@piece3.next_user_piece).to eq(@piece2)
      end
    end

    context "when piece is first in list" do
      it "selects prev list piece" do
        @piece3.offset = 0
        expect(@piece3.prev_list_piece).to eq(nil)
      end

      it "selects next list piece" do
        @piece3.offset = 0
        expect(@piece3.next_list_piece).to eq(@piece2)
      end
    end


  end
end
