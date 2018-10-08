require 'rails_helper'

RSpec.describe Fetchers::PackageIndexerService do
  before do
    @indexer = Fetchers::PackageIndexerService.new
  end

  let(:packages) do
    [
      {
        Package: "A3",
        Version: "1.0.0",
        Depends: "R (>= 2.15.0), xtable, pbapply",
        Suggests: "randomForest, e1071",
        License: "GPL (>= 2)",
        NeedsCompilation: "no"
      },
      {
        Package: "abbyyR",
        Version: "0.5.4",
        Depends: "R (>= 3.2.0)",
        Imports: "httr, XML, curl, readr, plyr, progress",
        Suggests: "testthat, rmarkdown, knitr (>= 1.11), lintr",
        License: "MIT + file LICENSE",
        NeedsCompilation: "no"
      }
    ]
  end

  let(:package) do
    {
      "Package"=>"abctools",
      "Type"=>"Package",
      "Title"=>"Tools for ABC Analyses",
      "Version"=>"1.1.3",
      "Date"=>"2018-07-17",
      "Authors@R"=>
       "c(person(\"Matt\",\"Nunes\",role=c(\"aut\",\"cre\"), email=\"nunesrpackages@gmail.com\"),person(\"Dennis\", \"Prangle\", role=\"aut\",email=\"d.b.prangle@newcastle.ac.uk\"), \tperson(\"Guilhereme\", \"Rodrigues\", role=\"ctb\", \temail=\"g.rodrigues@unsw.edu.au\"))",
      "Description"=>
       "Tools for approximate Bayesian computation including summary statistic selection and assessing coverage.",
      "Depends"=>"R (>= 2.10), abc, abind, parallel, plyr, Hmisc",
      "Author"=>"Matt Nunes [aut, cre], Dennis Prangle [aut], Guilhereme Rodrigues [ctb]",
      "Maintainer"=>"Matt Nunes <nunesrpackages@gmail.com>",
      "Date/Publication"=>"2018-07-17 23:20:02 UTC"
    }
  end

  describe "#packages" do
    it "returns an Array of packages" do
      packages_service = Fetchers::PackagesService.new
      allow(Fetchers::PackagesService).to receive(:new).and_return(packages_service)
      allow(packages_service).to receive(:call).and_return(packages)
      expect(@indexer.send(:packages)).to be_an Array
    end
  end

  describe "#author_name" do
    it "returns striped author name" do
      expect(@indexer.send(:author_name, "Matt Nunes ")).to eq("Matt Nunes")
    end
  end

  describe "#call" do
    it "creates a new package" do
      allow(@indexer).to receive(:packages).and_return([package])

      package_service = Fetchers::PackageService.new
      allow(Fetchers::PackageService).to receive(:new).and_return(package_service)
      allow(package_service).to receive(:call).and_return(package)

      expect { @indexer.call }.to change { Package.count }.by(1)
    end

    it "creates associating contributors when new package is created" do
      allow(@indexer).to receive(:packages).and_return([package])

      package_service = Fetchers::PackageService.new
      allow(Fetchers::PackageService).to receive(:new).and_return(package_service)
      allow(package_service).to receive(:call).and_return(package)

      @indexer.call

      maintainer = Maintainer.find_by_email("nunesrpackages@gmail.com")
      author = Author.find_by_email("d.b.prangle@newcastle.ac.uk")

      expect(Package.last.maintainers).to include(maintainer)
      expect(Package.last.authors).to include(author)
    end
  end
end

