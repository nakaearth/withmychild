# frozen_string_literal: true

class TopController < ApplicationController
  skip_before_action :login?, only: %i[index]
  # トップ画面
  def index
    @search_form = SearchForm.new
  end
end
