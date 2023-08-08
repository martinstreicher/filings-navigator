# frozen_string_literal: true

class BaseReturnObject
  include Memery

  def initialize(irs_return_as_hash)
    @irs_return_as_hash = irs_return_as_hash
  end

  def city
    diggin('{City,CityNm}', data: address, options: { underscore: true })
  end

  ##
  # Given a series of paths, where each path resembles
  # `{Name,BusinessName}/{BusinessNameLine1,BusinessNameLine1Txt}`,
  # produce the cross product of each path and use the combinations as
  # alternate paths to dig into a hash to find the value.

  def diggin(*args, data: irs_return_as_hash, options: {})
    args.inject(HashWithIndifferentAccess.new(data)) do |xml, arg|
      return if xml.nil?

      sets = arg.split('/')

      path_alternates =
        sets.map do |set|
          terms = (set.match?(/\A\{.*\}\z/) ? set[1..-2].split(',') : [set])
          terms = terms.map(&:underscore).map(&:to_sym) if options[:underscore].to_boolean
          terms
        end

      seed = path_alternates.shift

      path_combinations =
        path_alternates.inject(seed) do |memo, alternate|
          memo.product(alternate).map(&:flatten)
        end

      working_path =
        path_combinations.detect do |path_elements|
          xml.dig(*path_elements)
        end

      return if working_path.nil?

      xml.dig(*working_path)
    end
  end

  def line1
    diggin('{AddressLine1,AddressLine1Txt}', data: address, options: { underscore: true })
  end

  def state
    diggin('{State,StateAbbreviationCd}', data: address, options: { underscore: true })
  end

  def zip
    diggin('{ZIPCode,ZIPCd}', data: address, options: { underscore: true })
  end

  private

  attr_reader :irs_return_as_hash
end
