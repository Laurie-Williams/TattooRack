require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "Validations" do
    specify { expect(subject).to validate_presence_of(:title)}
    specify { expect(subject).to validate_length_of(:title).is_at_most(128)}
    specify { expect(subject).to validate_length_of(:description).is_at_most(300)}
    specify { expect(subject).to validate_presence_of(:image)}
  end

  describe "activerecord relations" do
    before :all do
      DatabaseCleaner.start
      @piece1 = FactoryGirl.create(:piece, category_id: 1)
      @piece2 = FactoryGirl.create(:piece, category_id: 2)
      @piece3 = FactoryGirl.create(:piece, category_id: 2)
      @piece4 = FactoryGirl.create(:piece, category_id: 2)
    end

    after(:all) do
      DatabaseCleaner.clean
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
    end

    describe "scopes" do
      it "filters pieces with .all_in_category" do
      @pieces = Piece.all_in_category("flash")
      expect(@pieces).to contain_exactly(@piece2, @piece3, @piece4)
    end
    end

    describe "next_piece and prev_piece" do

      it "selects prev user piece" do
        expect(@piece3.prev_user_piece).to eq(@piece4)
      end

      it "selects next user piece" do
        expect(@piece3.next_user_piece).to eq(@piece2)
      end

      it "selects prev list piece" do
        @piece3.offset = 1
        expect(@piece3.prev_list_piece).to eq(@piece4)
      end

      it "selects next list piece" do
        @piece3.offset = 1
        expect(@piece3.next_list_piece).to eq(@piece2)
      end

      context "when piece is first user's piece" do
        it "selects prev user piece" do
          expect(@piece4.prev_user_piece).to eq(nil)
        end

        it "selects next user piece" do
          expect(@piece4.next_user_piece).to eq(@piece3)
        end
      end

      context "when piece is first in list" do
        it "selects prev list piece" do
          @piece4.offset = 0
          expect(@piece4.prev_list_piece).to eq(nil)
        end

        it "selects next list piece" do
          @piece4.offset = 0
          expect(@piece4.next_list_piece).to eq(@piece3)
        end
      end

    end
  end

  describe "Associations" do
    specify { expect(subject).to belong_to(:user) }
  end

end
