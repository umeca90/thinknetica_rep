# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validator_meth

    def validate(name, vl_type, option = nil)
      @validator_meth ||= []
      @validator_meth << { attr_name: name, vl_meth: vl_type, option: option }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validator_meth.each do |param|
        validation_method = "validate_#{param[:vl_meth]}".to_sym
        attribute = instance_variable_get("@#{param[:attr_name]}")
        option = param[:option]
        send(validation_method, attribute, option)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence(attr_name, _option)
      raise "Can't be empty" if attr_name.nil? || attr_name.to_s.empty?
    end

    def validate_format(attr_name, format)
      raise "Неверный формат значения" if attr_name !~ format
    end

    def validate_type(attr_name, class_of)
      raise "Не подходящий класс объекта" unless attr_name.is_a?(class_of)
    end
  end
end
