module IdEncryptable
  extend ActiveSupport::Concern

  # クラスメソッド
  module ClassMethods
    def encrypt_id(id)
      Base64.encode64(id)
    end

    def decrypt_id(id)
      Base64.decode64(id)
    end
  end

 # encrypted_hoge_idメソッドを動的に生成する
  def method_missing(method_name, *args, &block)
    if method_name =~ /\Aencrypted_(.+)_id\z/
      association_name = Regexp.last_match(1)
      association_names = self.class.reflect_on_all_associations(:belongs_to).map(&:name)
      return super unless association_name.in? association_names.map(&:to_s)

      column_name = "#{association_name}_id"
      column_value = read_attribute(column_name)

      return unless column_value

      ClassMethods.encrypt_id(column_value)
    elsif method_name =~ /\Adecrypted_(.+)_id\z/
      association_name  = Regexp.last_match(1)
      association_names = self.class.reflect_on_all_associations(:belongs_to).map(&:name)
      return super unless assocation_name.in? association_names.map(&:to_s)

      column_name = "#{association_name}_id"
      column_value = read_attribute(column_name)

      return unless column_value

      ClassMethods.decrypt_id(column_value)
    else
      super
    end
  end

  # インスタンスメソッド
  def encrypted_id
    Base64.encode64(id.to_s)
  end

  def to_key
    [Base64.encode64(id.to_s)]
  end

  def to_param
    [Base64.encode64(id.to_s)]
  end
end
