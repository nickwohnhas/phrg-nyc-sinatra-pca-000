# frozen_string_literal: true

$LOAD_PATH.unshift "."
require "config/environment"
require_relative "app/controllers/figures_controller"
require_relative "app/controllers/titles_controller"
require_relative "app/controllers/landmarks_controller"
# Rack fix allows seeing the css folder.
use Rack::Static, urls: ["/css"], root: "public"

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise "Migrations are pending run `rake db:migrate` to resolve the issue."
end
use Rack::MethodOverride

use FiguresController
use TitlesController
use LandmarksController
run ApplicationController
