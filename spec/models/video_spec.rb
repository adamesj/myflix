require 'rails_helper'

RSpec.describe Video, type: :model do
  it "saves itself" do
  park = Video.new(
      title: "Parks and Recreation",
      description: "You had me at Meat Tornado",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg"
    )
    park.save
    expect(park.title).to eq "Parks and Recreation"
  end

  it "is valid with a title, description, and category" do
    category =  Category.create(name: "TV Comedies")
    park = Video.create(
      title: "Married with Children",
      description: "You had me at Meat Tornado",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    expect(park).to be_valid
  end

  it { should belong_to(:category) }

  it "is invalid without a title" do
    category =  Category.create(name: "TV Comedies")
    park = Video.new(
      title: nil,
      description: "You had me at Meat Tornado",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    park.valid?
    expect(park.errors[:title]).to include("can't be blank")
  end


  it "is invalid without a description" do
    category =  Category.create(name: "TV Comedies")
    park = Video.new(
      title: "Married with Children",
      description: nil,
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    park.valid?
    expect(park.errors[:description]).to include("can't be blank")
  end

  describe "search by title" do
    before do
      @category = Category.create(name: "TV Comedies")
    end

    it "returns an empty array if there is no match" do
      simpsons = Video.create(
        title: "The Simpsons",
        description: "This long-running animated comedy focuses on an eponymous family.",
        category_id: @category.id
      )
      futurama = Video.create(
        title: "Futurama",
        description: "Accidentally frozen, pizza-deliverer Fry wakes up 1,000 years in the future.",
        category_id: @category.id
      )
      expect(Video.search_by_title("hello")).to eq [] # expects that there is no match
    end

    it "returns an array of one video for an exact match" do
      simpsons = Video.create(
        title: "The Simpsons",
        description: "This long-running animated comedy focuses on an eponymous family.",
        category_id: @category.id
      )
      futurama = Video.create(
        title: "Futurama",
        description: "Accidentally frozen, pizza-deliverer Fry wakes up 1,000 years in the future.",
        category_id: @category.id
      )
      expect(Video.search_by_title("Futurama")).to eq [futurama]
    end

    it "returns an array of one video for a partial match" do
      simpsons = Video.create(
        title: "The Simpsons",
        description: "This long-running animated comedy focuses on an eponymous family.",
        category_id: @category.id
      )
      futurama = Video.create(
        title: "Futurama",
        description: "Accidentally frozen, pizza-deliverer Fry wakes up 1,000 years in the future.",
        category_id: @category.id
      )
      expect(Video.search_by_title("urama")).to eq [futurama] # partial match
    end

    it "returns an array of all matches ordered by created_at" do
      family_guy = Video.create(
        title: "Family Guy",
        description: "Sick, twisted and politically incorrect, the animated series features the adventures of the Griffin family.",
        created_at: 1.week.ago,
        category_id: @category.id
      )
      f_family = Video.create(
        title: "F Is for Family",
        description: "This animated raunchy comedy is inspired by the life of stand-up comic Bill Burr.",
        created_at: 1.day.ago,
        category_id: @category.id
      )
      expect(Video.search_by_title("Fam")).to eq [f_family, family_guy]
    end

    it "returns an empty array for a search with an empty string" do
      simpsons = Video.create(
        title: "The Simpsons",
        description: "This long-running animated comedy focuses on an eponymous family.",
        category_id: @category.id
      )
      futurama = Video.create(
        title: "Futurama",
        description: "Accidentally frozen, pizza-deliverer Fry wakes up 1,000 years in the future.",
        category_id: @category.id
      )
      expect(Video.search_by_title("")).to eq []
    end
  end

end
