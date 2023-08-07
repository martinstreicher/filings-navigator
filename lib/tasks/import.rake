namespace :returns do
  task :import => :environment do
    ##
    # @todo: Make the file name(s) an argument for the rake task

    base_url = 'https://filing-service.s3-us-west-2.amazonaws.com/990-xmls/'

    files =
      %w[
        201612429349300846_public.xml
      ].freeze

    files.each do |file|
      Import990Interactor.call(xml_file_url: URI.join(base_url, file))
    end
  end
end

