require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    specify { expect(subject).to validate_presence_of(:name)}
    specify { expect(subject).to validate_length_of(:name).is_at_least(2)}
    specify { expect(subject).to validate_length_of(:name).is_at_most(24)}

    specify { expect(subject).to validate_presence_of(:username)}
    specify { expect(subject).to validate_length_of(:username).is_at_least(5)}
    specify { expect(subject).to validate_length_of(:username).is_at_most(14)}
    specify { expect(subject).to validate_uniqueness_of(:username)}

    specify { expect(subject).to validate_presence_of(:email)}
    specify { expect(subject).to validate_uniqueness_of(:email)}

    specify { expect(subject).to validate_presence_of(:password)}

  end
end
