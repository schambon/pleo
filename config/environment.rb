# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'java'

# Add stemmer.jar to Java classpath (so we can stem)
#$CLASSPATH << "file:///#{File.expand_path(File.join(RAILS_ROOT, 'java/stemmer.jar'))}"
$CLASSPATH << "#{File.dirname(__FILE__)}/../java/stemmer.jar"

# Initialize the Rails application.
Pleo2::Application.initialize!
