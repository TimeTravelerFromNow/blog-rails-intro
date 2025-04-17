class AdminController < ApplicationController
  http_basic_authenticate_with name: 'username', password: 'supersecret19000fwh0f203f90qjf0'
end
