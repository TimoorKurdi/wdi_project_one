require 'active_record'

class Revision < ActiveRecord::Base
  def document
    Document.where({id: self.doc_id})
  end
end