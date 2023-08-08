# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilersController do
  ##
  # @todo: Use test-prof and `let_it_be` to create the list once
  # and reuse it for all tests.

  let!(:filers)  { create_list(:filer, 9).sort_by(&:ein) }
  let(:per_page) { 3 }

  describe 'when calling GET #index' do
    it 'returns a maximum of `per_page` records' do
      get :index, params: { per_page: per_page, format: :json }
      reply = JSON.parse(response.body)
      expect(reply['filers'].size).to eq(per_page)
    end

    it 'paginates and returns a max of `per_page` records' do
      get :index, params: { per_page: per_page, page: 2, format: :json }
      reply = JSON.parse(response.body)
      expect(reply['filers'].size).to eq(per_page)
      expect(reply['filers'].first['ein']).to eq(filers[3].ein)
    end

    it 'sorts by the named column' do
      get :index, params: { per_page: per_page, sort: 'name', format: :json }
      reply = JSON.parse(response.body)
      expect(reply['filers'].first['name']).to eq(filers.sort_by(&:name).first.name)
    end

    ##
    # @todo: Add more tests for sorting and pagination.
    #  * Sort column does not exist
    #  * Page number is negative
    #  * Per page is negative
    #  * Per page is greater than 100
    #  * No SQL injection
  end
end
