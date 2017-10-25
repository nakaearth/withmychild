module Encryptedable
  extend ActiveSupport::Concern

  included do
    before_save :encrypted

    class_attribute :__encrypted_columns
    self.__encrypted_columns = []
  end

  module ClassMethods
    def attr_encrypted(*columns)
      columns.map(&:to_s).each do |column|
        __encrypted_columns << column
      end
    end
  end

  def encrypted
    __encrypted_columns.each do |encrypted_column|
      value = Base64.encode64(read_attribute(encrypted_column))
      write_attribute(encrypted_column, value)
    end
  end
end
