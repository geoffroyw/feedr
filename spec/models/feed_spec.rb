require 'spec_helper'

describe Feed do
  it{should validate_presence_of :name}
  it{should validate_presence_of :url}
  it{should validate_uniqueness_of(:url).case_insensitive}
end
