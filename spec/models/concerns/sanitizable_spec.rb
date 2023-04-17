require 'rails_helper'

RSpec.describe Sanitizable do
  describe 'sanitize' do
    let(:model) { DummyModel.new(title: '<p>Test</p>', body: '<script>alert("malicious code")</script>') }

    it 'sanitizes input with HTML tags' do
      model.sanitize
      expect(model.title).to eq 'Test'
    end

    it 'does not change input without HTML tags' do
      model.title = 'Test'
      model.sanitize
      expect(model.title).to eq 'Test'
    end

    it 'sanitizes input with malicious code' do
      model.sanitize
      expect(model.body).to eq ''
    end
  end
end
