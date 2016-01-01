require "test_helper"
require "generators/iaq_gen/iaq_gen_generator"

class IaqGenGeneratorTest < Rails::Generators::TestCase
  tests IaqGenGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # def test_generator_runs
  #   # No error raised? It passes.
  #   run_generator ["arguments"]
  # end
end
