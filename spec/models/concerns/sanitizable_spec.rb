require 'rails_helper'
require 'active_record'

class SanitizedClass < ActiveRecord::Base
  self.table_name = 'sanitizable_table'
  include Sanitizable
  sanitizable [:sanitized, :sanitized_second]
end

RSpec.describe SanitizedClass do
  before(:all) do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    ActiveRecord::Base.connection.create_table :sanitizable_table do |t|
      t.string :sanitized
      t.string :sanitized_second
      t.string :other_input
    end
  end

  after(:all) do
    ActiveRecord::Base.connection.drop_table :sanitizable_table
  end

  let(:sanitized_value) { '<a>test link</a>' }
  let(:sanitized_second_value) { "test slug 2<script src='https://test.com/script.js' />" }

  subject(:sanitized_object) { SanitizedClass.create(sanitized: sanitized_value, sanitized_second: sanitized_second_value) }

  it "has a class method :sanitized_inputs" do
    expect(SanitizedClass).to respond_to(:sanitized_inputs)
  end

  it "defines the correct sanitized inputs" do
    expect(SanitizedClass.sanitized_inputs).to match_array([:sanitized, :sanitized_second])
  end

  it "sanitizes inputs when saving the object" do
    sanitized_object.reload
    expect(sanitized_object.sanitized).to eq('test link')
    expect(sanitized_object.sanitized_second).to eq('test slug 2')
  end

  it "sanitizes inputs on update" do
    sanitized_object.update(sanitized: '<strong>bold text</strong>')
    sanitized_object.reload
    expect(sanitized_object.sanitized).to eq('bold text')
    expect(sanitized_object.sanitized_second).to eq('test slug 2')
  end

  it "doesn't sanitize other inputs" do
    sanitized_object.update(other_input: '<script>malicious code</script>')
    sanitized_object.reload
    expect(sanitized_object.other_input).to eq('<script>malicious code</script>')
  end
end
