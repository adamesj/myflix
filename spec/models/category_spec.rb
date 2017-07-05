require 'rails_helper'

RSpec.describe Category, type: :model do
  it "saves itself" do
    category = Category.new(
      name: "TV Dramas"
    )
    category.save
    expect(category.name).to eq "TV Dramas"
  end

  it "is valid with a name" do
    category = Category.create(
      name: "TV Dramas"
    )
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category = Category.new(
      name: nil
    )
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end
end
