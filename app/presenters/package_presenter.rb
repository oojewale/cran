class PackagePresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
    super(@model)
  end

  def authors
    extract_names(@model.authors)
  end

  def maintainers
    extract_names(@model.maintainers)
  end

  def extract_names(collection)
    collection.collect{|m| m.name }.join(', ').strip.chomp
  end
end
