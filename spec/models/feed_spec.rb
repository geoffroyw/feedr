require 'spec_helper'

describe Feed do
  it{should validate_presence_of :name}
  it{should validate_presence_of :url}
end
