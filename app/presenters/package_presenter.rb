class PackagePresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
    super(@model)
  end

  def authors
    @model.authors.join(', ').chomp
  end

  def maintainers
    @model.maintainers.join(', ').chomp
  end
end
