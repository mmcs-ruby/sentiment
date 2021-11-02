# frozen_string_literal: true

require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "sentiment"

require "minitest/autorun"

PATH_TO_TEST_FILES = "test/data"
def test_files_path(filename)
  File.join(PATH_TO_TEST_FILES, filename)
end