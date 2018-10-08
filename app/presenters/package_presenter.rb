class PackagePresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
    super(@model)
  end

  def authors
    @model.authors.collect{|a| a.name }.join(', ').strip.chomp
  end

  def maintainers
    @model.maintainers.collect{|m| m.name }.join(', ').strip.chomp
  end
end
