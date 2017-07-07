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

  describe "#recent_videos" do
    it "returns videos in the order it was created at" do
      thriller = Category.create(name: "Thriller")
      batman = Video.create(title: "The Dark Knight", description: "Batman faces the Joker while Harvey pledges to save Gotham City.", category_id: thriller.id)
      island = Video.create(title: "Shutter Island", description: "Dicaprio explores an abandoned Asylum, or so he thinks.", category_id: thriller.id, created_at: 1.day.ago)
      expect(thriller.recent_videos).to eq [batman, island]
      # because its a method in the category model, you can call recent_videos on the category
    end

    it "returns all videos if there are less than six videos" do
      thriller = Category.create(name: "Thriller")
      batman = Video.create(title: "The Dark Knight", description: "Batman faces the Joker while Harvey pledges to save Gotham City.", category_id: thriller.id)
      island = Video.create(title: "Shutter Island", description: "Dicaprio explores an abandoned Asylum, or so he thinks.", category_id: thriller.id)
      inception = Video.create(title: "Inception", description: "Dom Cobb is a thief with the rare ability to enter people's dreams", category_id: thriller.id)
      # expect(thriller.recent_videos).to eq [batman, island, inception]
      expect(thriller.recent_videos.count).to eq 3
    end

    it "returns six videos if there are more than six videos" do
      thriller = Category.create(name: "Thriller")
      batman = Video.create(title: "The Dark Knight", description: "Batman faces the Joker while Harvey pledges to save Gotham City.", category_id: thriller.id)
      island = Video.create(title: "Shutter Island", description: "Dicaprio explores an abandoned Asylum, or so he thinks.", category_id: thriller.id)
      inception = Video.create(title: "Inception", description: "Dom Cobb is a thief with the rare ability to enter people's dreams", category_id: thriller.id)
      interstellar = Video.create(title: "Interstellar", description: "In Earth's future, a global crop blight and second Dust Bowl are slowly rendering the planet uninhabitable.", category_id: thriller.id)
      memento = Video.create(title: "Memento", description: "Leonard (Guy Pearce) is tracking down the man who raped and murdered his wife.", category_id: thriller.id)
      prestige = Video.create(title: "The Prestige", description: "An illusion gone horribly wrong pits two 19th-century magicians.", category_id: thriller.id)
      insomnia = Video.create(title: "Insomnia", description: "A veteran police detective is sent to a small Alaskan town to investigate the murder of a teenage girl.", category_id: thriller.id)
      # expect(thriller.recent_videos).to eq [insomnia, prestige, memento, interstellar, inception, island]
      expect(thriller.recent_videos.count).to eq 6
    end

    it "returns an empty array if there are no videos" do
      thriller = Category.create(name: "Thriller")
      # expect(thriller.recent_videos).to eq []
      expect(thriller.recent_videos.count).to eq 0
    end
  end
end
