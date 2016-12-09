class LocaleDuplicationChecker

  def self.run
    I18n.available_locales.each do |locale|
      file_path = "#{Rails.root}/config/locales/#{locale}.yml"
      duplicated_keys[locale] = []
      check_duplicates file_path, locale
    end

    print_dupl_lines
  end

  @duplicated_keys = {}

  class << self
    attr_reader :duplicated_keys
  end

  def self.print_dupl_lines

    if no_errors?
      puts 'No locale duplicated keys'
      return true
    end

    print_errors
  end

  def self.prefix(line)
    line.split(':').first
  end

  def self.same_prefix?(prev_line, line)
    prefix(line) == prefix(prev_line) && !prefix(line).ends_with?(' ') && prev_line != ''
  end

  def self.no_errors?
    I18n.available_locales.each do |locale|
      return false unless duplicated_keys[locale].empty?
    end

    true
  end

  def self.check_duplicates(file_path, locale)
    prev_line = ''
    File.foreach(file_path).with_index do |line, num|
      duplicated_keys[locale] << "#{num}: #{line}" if same_prefix?(prev_line, line)
      prev_line = line
    end
  end

  def self.print_errors
    puts '== Locale duplicated keys =================================='
    I18n.available_locales.each do |locale|
      unless duplicated_keys[locale].empty?
        puts "--> #{locale}"
        duplicated_keys[locale].each { |line| puts line }
      end
    end

    puts '============================================================'
  end

  private_class_method :print_dupl_lines
  private_class_method :prefix
  private_class_method :same_prefix?
  private_class_method :no_errors?
  private_class_method :duplicated_keys
  private_class_method :check_duplicates
  private_class_method :print_errors
end
