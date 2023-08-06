# frozen_string_literal: true

class BaseReturn
  include Memery

  def initialize(irs_return_as_hash)
    @irs_return_as_hash = irs_return_as_hash
  end

  ##
  # Given a series of paths, where each path resembles
  # `{Name,BusinessName}/{BusinessNameLine1,BusinessNameLine1Txt}`,
  # produce the cross product of each path and use the combinations as
  # alternate paths to dig into a hash to find the value.

  def diggin(*args)
    args.inject(irs_return_as_hash) do |xml, arg|
      return if xml.nil?

      ap xml.inspect

      sets = arg.split('/')

      path_alternates =
        sets.map do |set|
          set.match?(/\A\{.*\}\z/) ? set[1..-2].split(',') : [set]
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

  private

  attr_reader :irs_return_as_hash
end
