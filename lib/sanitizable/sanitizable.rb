# frozen_string_literal: true

require 'rails-html-sanitizer'

module Sanitizable
    extend ActiveSupport::Concern
  
    included do
        # Call the `sanitize_inputs` method before saving the record, but only if the sanitized inputs will update
        before_save :sanitize, if: :sanitized_inputs_will_update?
    end
  
    # Check if any of the sanitized inputs will update before calling the `sanitize` method
    def sanitized_inputs_will_update?
        will_update = false
        self.class.sanitized_inputs.each do |a|
            method_name = "will_save_change_to_" + a.to_s + "?"
            will_update = (self.send(method_name) or will_update)
        end
        will_update
    end
  
    # Sanitize the inputs for the record
    def sanitize
        self.class.sanitized_inputs.each_with_index do |a, index|
            if self[a].present?
                begin
                    sanitizer = Rails::Html::FullSanitizer.new
                    self[a] = sanitizer.sanitize(self[a])
                rescue => e
                    # If an exception is raised while sanitizing the input, set the attribute to an empty string
                    # and log the error for debugging
                    Rails.logger.error("Error sanitizing #{a}: #{e.message}")
                    self[a] = ''
                end
            end
        end
    end
  
    module ClassMethods
        attr_reader :sanitized_inputs
    
        private
        # Define the `sanitizable` method to set the list of attributes to sanitize
        def sanitizable(sanitized_inputs)
            @sanitized_inputs = sanitized_inputs
        end
    end
end