namespace :build_client_data do |client_data|
  task :all do
    client_data.tasks.each { |task| Rake::Task[task].invoke }
  end

  task :constants do
    procompile 'server_constants.js'
  end

  task :functions do
    procompile 'server_functions.js'
  end

  private

  def source_dir
    'lib/source_erb'
  end

  def target_dir
    'app/assets/javascripts'
  end

  def procompile(file_name)
    system "erb init_comment='#{init_comment}' #{source_dir}/#{file_name}.erb > #{target_dir}/#{file_name}"

    # When the Rails environment is loaded, the secrets.yml file is printed here,
    # so these lines need to be removed
    input_lines = File.readlines("#{target_dir}/#{file_name}")
    output_lines = input_lines.select.with_index { |_, i| i > 28 }

    File.open("#{target_dir}/#{file_name}", 'w') do |f|
      output_lines.each { |line| f.write line }
    end
  end

  def init_comment
    "// This file was generated through erb templating. Any changes you do directly\n" \
    '// in this file will be overriden when the "build_client_data:all" rake task is run;'
  end
end
