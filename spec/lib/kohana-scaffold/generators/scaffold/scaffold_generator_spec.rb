require 'spec_helper'

describe KohanaScaffold::ScaffoldGenerator do
  it_behaves_like "a Kohana scaffold generator", "product"
  it_behaves_like "a Kohana scaffold generator with db", "post", ["title", "content"]
end
