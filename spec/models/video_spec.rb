require 'rails_helper'

RSpec.describe Video, type: :model do
  it "saves itself" do
    video = Video.new(
      title: "Married with Children",
      description: "Love and marriage! Love and marriage!",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg"
    )
    video.save
    expect(video.title).to eq "Married with Children"
  end

  it "is valid with a title, description, and category" do
    category =  Category.create(name: "TV Comedies")
    video = Video.create(
      title: "Married with Children",
      description: "Love and marriage! Love and marriage!",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    expect(video).to be_valid
  end

  it { should belong_to(:category) }

  it "is invalid without a title" do
    category =  Category.create(name: "TV Comedies")
    video = Video.new(
      title: nil,
      description: "Love and marriage! Love and marriage!",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    video.valid?
    expect(video.errors[:title]).to include("can't be blank")
  end


  it "is invalid without a description" do
    category =  Category.create(name: "TV Comedies")
    video = Video.new(
      title: "Married with Children",
      description: nil,
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    video.valid?
    expect(video.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate title" do
    category =  Category.create(name: "TV Comedies")
    Video.create(
      title: "Married with Children",
      description: "Love and marriage! Love and marriage!",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )
    video = Video.new(
      title: "Married with Children",
      description: "Love and marriage! Love and marriage!",
      small_cover_url: "small_image.jpg",
      large_cover_url: "large_image.jpg",
      category_id: category.id
    )

    video.valid?
    expect(video.errors[:title]).to include("has already been taken")
  end

end
