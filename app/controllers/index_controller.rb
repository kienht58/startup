class IndexController < ApplicationController
  before_action :sign_in_required, only: [:show]

end
