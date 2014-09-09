  require 'pry'
  require 'sinatra'
  require 'sinatra/reloader'
  require 'httparty'
  require_relative './lib/connection'
  require_relative './lib/author'
  require_relative './lib/document'
  require_relative './lib/subscriber'
  require_relative './lib/revision'

  after do
    ActiveRecord::Base.connection.close
  end

  get("/") do
    erb(:index)
  end

  get("/documents") do
    erb(:"documents/index", { locals: { documents: Document.all() }})
  end

  get("/documents/new") do
    erb(:"documents/new", { locals: { authors: Author.all() }})
    #binding.pry
  end

  post("/documents") do
    #binding.pry

    document_hash = {
      name: params["name"],
      content: params["content"],
      author_id: params["author_id"]
    }

    # binding.pry

    Document.create(document_hash)

  erb(:"documents/index", { locals: { documents: Document.all() }})
end

get("/documents/search") do
    erb(:"documents/search")
  end

get("/documents/searchresults") do

  search = params[:docname]

  results = Document.where({name: search})
#binding.pry
  erb(:"documents/searchresults", {locals: {results: results, search: search}})
end


  get("/documents/:id") do
    document = Document.find_by({id: params[:id]})
    erb(:"documents/show", { locals: { document: document }})
end

  get("/documents/:id/edit") do
    document = Document.find_by({id: params[:id]})
    erb(:"documents/edit", { locals: { document: document, authors: Author.all() }})
end

  put("/documents/:id") do
    document_hash = {
      name: params["name"],
      content: params["content"],
      author_id: params["author_id"]
    }
    #binding.pry

    document = Document.find_by({id: params[:id]})
    document.update(document_hash)
    #binding.pry
    modified_hash = {
      older_title: params["name"],
      older_content: params["content"],
      doc_id: params["id"]
    }



    Revision.create(modified_hash)

    erb(:"documents/show", {locals: { document: document }})
  end

  delete("/documents/:id") do
    document = Document.find_by({id: params[:id]})
    document.destroy
    documents = Revision.where({doc_id: params[:id]})
    documents.each do |doc|
      document.destory
    end

    redirect "/documents"
  end

  get('/documents/history/:id') do
    document = Document.find_by({id: params[:id]})
    past_docs = Revision.where({doc_id: params[:modified]})

    erb(:"documents/pastdocs", {locals: {document: document, past_docs: past_docs}})
  end

  get('/documents/past/:id') do
    document = Revision.find_by({id: params[:id]})
    erb(:"documents/old", {locals: {document: document}})
  end

  #####################################

  get("/authors") do
    erb(:"authors/index", {locals: { authors: Author.all() }})
  end

  post("/authors") do

    author_hash = {
      name: params["name"],
      age: params["age"]
    }

    Author.create(author_hash)

    erb(:"authors/index", { locals: { authors: Author.all() }})
  end

  get("/authors/new") do
    erb(:"authors/new", {locals: { authors: Author.all() }})
end

  get("/authors/:id") do
    author = Author.find_by({id: params[:id]})

    erb(:"authors/show", { locals: { author: author }})
  end
