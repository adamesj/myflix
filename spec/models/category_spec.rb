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

  it "should have many videos" do
    category = Category.reflect_on_association(:videos)
    expect(category.macro).to eq(:has_many)
  end

  # can also use: it { should have_many(:videos) }
end
