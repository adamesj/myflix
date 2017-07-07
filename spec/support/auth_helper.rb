module AuthHelpers
  def log_in(resource)
    mapping = (resource == :food_donor) ? :food_donor : :user
    @request.env['devise.mapping'] = Devise.mappings[mapping]
    options = (resource == :region_head) ? { moderate_region_id: Region.first.id }: {}
    sign_in FactoryGirl.create(resource, options)
  end
end
