class SearchesController < ApplicationController
  def search
    @model = params[:model]
  @content = params[:content]
  @method = params[:method]
  if @model == "user"
 @records = User.search(@content, @method)
    else
      @records = Book.search(@content, @method)

end
  end
end