# frozen_string_literal: true

module DecryptedId
  extend ActiveSupport::Concern

  def decrypted_id(id)
    Base64.decode64(id)
    # rubocop:disable all
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    raise 'デコード失敗しました'
    # rubocop:enable all
  end

  def encrypted_id(id)
    Base64.encode64(id)
    # rubocop:disable all
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    raise 'エンコード失敗しました'
    # rubocop:enable all
  end
end
