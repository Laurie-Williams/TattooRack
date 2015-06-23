require 'rails_helper'

RSpec.describe Category, type: :model do

  it "correctly converts name to id" do
    expect(Category.get_id_from_name("tattoo")).to eq(1)
    expect(Category.get_id_from_name("inspiration")).to eq(4)
  end

end
