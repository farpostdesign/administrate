require_relative "associative"

module Administrate
  module Field
    class HasOne < Associative
      def nested_form
        @nested_form ||= Administrate::Page::Form.new(
          associated_dashboard,
          data || associated_class.new,
        )
      end

      def self.permitted_attribute(attr, options = nil)
        associated_class_name =
          if options
            options.fetch(:class_name, attr.to_s.singularize.camelcase)
          else
            attr
          end
        related_dashboard_attributes =
          "#{associated_class_name}Dashboard".constantize.new.permitted_attributes + [:id]

        { "#{attr}_attributes": related_dashboard_attributes }
      end
    end
  end
end
