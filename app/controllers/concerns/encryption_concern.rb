# frozen_string_literal: true

module EncryptionConcern
  extend ActiveSupport::Concern

  def decrypted(param)
    Base64.decode64(param)
    # rubocop:disable all
  rescue => e
    # TODO: 何か例外クラス作ってそれを投げる
    logger.error(e.messages)
    raise 'デコード失敗しました'
    # rubocop:enable all
  end

  def encrypted(param)
    Base64.encode64(param)
    # rubocop:disable all
  rescue
    # TODO: 何か例外クラス作ってそれを投げる
    logger.error(e.messages)
    raise 'エンコード失敗しました'
    # rubocop:enable all
  end
end
