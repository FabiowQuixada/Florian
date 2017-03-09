namespace :karma do
  task start: :environment do
    with_tmp_config :start
  end

  task run: :environment do
    exit with_tmp_config :start, '--single-run'
  end

  private

  def with_tmp_config(command, args = nil)
    Tempfile.open('karma_unit.js', Rails.root) do |f|
      f.write unit_js(application_spec_files)
      f.flush

      system "karma #{command} #{f.path} #{args}"
    end
  end

  def application_spec_files
    Rails.application.assets.find_asset('application_spec.js').to_a.map { |e| e.pathname.to_s }
  end

  def unit_js(files)
    unit_js = File.open('karma.conf.js', 'r').read
    unit_js.gsub 'APPLICATION_SPEC', "\"#{files.join("\",\n\"")}\""
  end
end
