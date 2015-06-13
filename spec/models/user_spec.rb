require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    # :name
    specify { expect(subject).to validate_presence_of(:name)}
    specify { expect(subject).to validate_length_of(:name).is_at_least(2)}
    specify { expect(subject).to validate_length_of(:name).is_at_most(24)}
    # :usernams
    specify { expect(subject).to validate_presence_of(:username)}
    specify { expect(subject).to validate_length_of(:username).is_at_least(5)}
    specify { expect(subject).to validate_length_of(:username).is_at_most(14)}
    specify { expect(subject).to validate_uniqueness_of(:username)}
    # :email
    specify { expect(subject).to validate_presence_of(:email)}
    specify { expect(subject).to validate_uniqueness_of(:email)}
    # :password
    specify { expect(subject).to validate_presence_of(:password)}

  end

  it "sets default piece title" do
    @piece = Piece.new
    @uploader = double "uploader", filename: "/uploads/tmp/1434192355-29662-5162/This-is_a_test-IMAGE.png"
    allow(@piece).to receive(:image).and_return(@uploader)
    @piece.check_and_set_title
    expect(@piece.title).to eq("This Is A Test Image")
  end
end
