class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "Julian", password: "test1234", except: [:index, :show]

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  # Ordering of methods is important - originally not working as this was below the 'private' keyword
  def show
    @article = Article.find(params[:id])
  end

  # Can change '.find' parameters to extract particular results as required
  def index
    @articles = Article.all
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  # Article parameters definition extracted for re-use
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
