class DummyModel < ApplicationRecord
  include Sanitizable
  
  sanitizable [:title, :body]
end
  