# frozen_string_literal: true

class FilersController < ApplicationController
  def index
    filers =
      Filer
      .order(sorting_column => sorting_direction)
      .offset(page_number * per_page)
      .limit(per_page)

    render json: { filers: filers, page: page_number + 1 }, status: :ok
  end

  private

  def page_number
    page = (params[:page] || 1).to_i
    page.positive? ? page - 1 : 0
  end

  def per_page
    per_page = (params[:per_page] || 10).to_i
    per_page.positive? && (per_page <= 100) ? per_page : 10
  end

  def permitted_params
    params.require(:id)
  end

  def sorting_column
    column = params[:sort] || 'ein'
    Filer.column_names.include?(column) ? column : 'ein'
  end

  def sorting_direction
    direction = params[:direction] || 'asc'
    %w[asc desc].include?(direction) ? direction : 'asc'
  end
end
