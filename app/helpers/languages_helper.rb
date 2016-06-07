module LanguagesHelper

  def build_void_language

    lang = 'en'

    path = "#{Rails.root}/config/locales/" + lang + '.yml'
    content = 'data from the form'

    File.open(path, 'w+') do |f|
      File.open("#{Rails.root}/config/locales/pt-BR.yml", 'r').each_line do |line|
        if line == "pt-BR:\n"
          f.puts(lang + ":\n")
        elsif line[0] == '#' || line == "\n" || line.end_with?(':') || line.end_with?(': ') || line.include?('- :')
          f.puts(line)
        elsif line.include?(':') && leaf_tag(line)
          f.puts(line_prefix(line) + ':')
        elsif line.include?(':') && !leaf_tag(line)
          f.puts(line_prefix(line) + ': "______"')
        else
          f.puts(line_lala(line) + '- ______')
        end
      end
    end
  end

  private

  def only_tag(line)
    line.include?(':') && !leaf_tag(line)
  end

  def leaf_tag(line)
    line.split(':').last == "\n" || line.split(':').last == " \n"
  end

  def line_prefix(line)
    line.split(':').first
  end

  def line_lala(line)
    line.split('-').first
  end

end
