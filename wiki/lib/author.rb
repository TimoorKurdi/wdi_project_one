require 'active_record'

class Author < ActiveRecord::Base
  def documents
    Document.where({author_id: self.id})
  end
end