require 'fileutils'

module GeoNamesAPI
  class Country < ListEndpoint

    METHOD = "countryInfoJSON"
    FIND_PARAMS = %w(country)

    EXPORT_BASE_URL = "http://download.geonames.org/export/zip/"
    EXPORT_HEADERS = %W(country_code postal_code place_name admin_name1 admin_code1 admin_name2 admin_code2 admin_name3 admin_code3 latitude longitude accuracy)

    # if rails is defined use the rails tmp directory to ensure
    # compatability with heroku
    def export_directory
      if defined?(Rails)
        Rails.root.join("tmp")
      else
        directory = File.expand_path("../../../tmp", __FILE__)
        FileUtils.mkdir(directory) unless File.directory?(directory)
        directory
      end
    end

    def postal_code_export
      File.open(export_directory.to_s + "/export.zip", "wb") do |f|
        open(postal_code_export_url, "rb") do |export|
          f.write export.read
        end
      end

      tmp_file_name = export_directory + "/tmp.txt"
      file_name = export_directory + "/#{country_code}.txt"

      Zip::File.foreach(export_directory.to_s + "/export.zip") do |f|  
        File.delete(tmp_file_name) if File.exist?(tmp_file_name)
        f.extract(tmp_file_name) if f.name =~ /\A#{country_code}/
      end

      File.open(file_name, "wb") do |f|
        f.write EXPORT_HEADERS.join("\t") + "\n"
        f.write File.open(tmp_file_name, "r").read
      end

      File.open(file_name, "r").read
    end

    def postal_code_csv
      CSV.parse(postal_code_export, headers: true, col_sep: "\t", header_converters: :symbol, encoding: "ISO8859-1")
    end

    def postal_code_export_url
      EXPORT_BASE_URL + country_code + ".zip"
    end

  end
end
