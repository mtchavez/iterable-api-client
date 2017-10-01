files = %w[]

files.each { |path| require_relative "./iterable/#{path}" }

##
#
# Iterable module for API interactions
module Iterable
end
