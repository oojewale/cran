class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def halt(tag: :abort, attr: :base, msg: nil)
    errors.add(attr, msg) if msg
    throw(tag)
  end
end
