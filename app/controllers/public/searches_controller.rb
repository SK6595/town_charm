class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		# @method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content).where(is_active: true).page(params[:page]).per(10)
		elsif @model == 'group'
			@records = Group.search_for(@content).page(params[:page]).per(10)
		else
			@records = Post.search_for(@content).page(params[:page]).per(10)
		end
	end
end
