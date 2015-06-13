require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "Validations" do
    specify { expect(subject).to validate_presence_of(:title)}
    specify { expect(subject).to validate_length_of(:title).is_at_least(3)}
    specify { expect(subject).to validate_length_of(:title).is_at_most(128)}

    specify { expect(subject).to validate_length_of(:description).is_at_most(300)}

    specify { expect(subject).to validate_presence_of(:image)}
  end
end
