require 'spec_helper'

describe User do
  it{should validate_presence_of :email}
  it{should validate_presence_of :password}
  it{should ensure_length_of(:password).is_at_least 8}

  it{should have_many :user_feeds}
  it{should have_many(:feeds).through :user_feeds }
end
