# frozen_string_literal: true

RSpec.describe Sanitizable do
  it "has a version number" do
    expect(Sanitizable::VERSION).not_to be nil
  end
end
